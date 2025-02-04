unit PedidoController;

interface

uses
  SysUtils, PedidoModel, SelecaoModel, FireDac.Comp.Client, SelecaoController, ItemPedidoController, ItemPedidoModel, ClienteController;

type
  TPedidoController = class
  public
    class function Remover(pPedidoModelo: TPedidoModel): Boolean;
    function Salvar(pCodigoCliente: Integer; pValorTotal: Double): Boolean;
    function ExibirERetornarSelecao(): TPedidoModel;
    function GetUltimoID(): Integer;
    function GetAll(): TFDQuery;
    function GetById(pCodigo: Integer): TPedidoModel;
  end;

implementation

function TPedidoController.Salvar(pCodigoCliente: Integer; pValorTotal: Double): Boolean;
var
  lPedidoModel: TPedidoModel;
begin
  lPedidoModel := TPedidoModel.Create();
  try
    lPedidoModel.Cliente.Codigo := pCodigoCliente;
    lPedidoModel.DataEmissao := Now();
    lPedidoModel.ValorTotal := pValorTotal;

    Result := lPedidoModel.Salvar();
  finally
    lPedidoModel.Free();
  end;
end;

function TPedidoController.GetAll(): TFDQuery;
begin
  Result := TPedidoModel.GetAll();
end;

function TPedidoController.GetById(pCodigo: Integer): TPedidoModel;
var
  lItensDoPedido: TArray<TItemPedidoModel>;
  lClienteController: TClienteController;
begin
  Result := TPedidoModel.Create();
  lClienteController := TClienteController.Create();
  try
    Result.ZerarModelo();

    if (pCodigo <> -1) then
    begin
      lItensDoPedido := TItemPedidoController.GetById(pCodigo);
      Result := TPedidoModel.GetById(pCodigo);
      Result.Cliente := lClienteController.GetById(Result.Cliente.Codigo);
      Result.Itens := lItensDoPedido;
    end;
  finally
    lClienteController.Free();
  end;
end;

function TPedidoController.GetUltimoID(): Integer;
const
  CONSULTA = 'SELECT MAX(NUMERO_PEDIDO) AS CODIGO FROM PEDIDOS';
begin
  Result := TPedidoModel.Open(CONSULTA).fields.FieldByName('CODIGO').AsInteger;
end;

function TPedidoController.ExibirERetornarSelecao(): TPedidoModel;
var
  lSelecaoController: TSelecaoController;
  lSelecaoModelo: TSelecaoModel;
  lDsPedidos: TFDQuery;
begin
  lDsPedidos := GetAll();
  lSelecaoController := TSelecaoController.Create();
  try
    lSelecaoModelo := lSelecaoController.ExibirERetornarSelecaoPedido(lDsPedidos);
    Result := GetById(lSelecaoModelo.Codigo);
  finally
    lDsPedidos.Free();
    lSelecaoController.Free();
  end;
end;

class function TPedidoController.Remover(pPedidoModelo: TPedidoModel): Boolean;
var
   I: Integer;
begin
  for I := 0 to Length(pPedidoModelo.Itens) -1 do
    if TItemPedidoController.Remover(pPedidoModelo.Itens[I]) then
    begin
      Result := False;
      Exit;
    end;

  Result := pPedidoModelo.Remover();
end;

end.
