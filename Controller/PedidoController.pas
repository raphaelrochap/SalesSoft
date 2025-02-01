unit PedidoController;

interface

uses
  PedidoModel;

type
  TPedidoController = class
  public
    function Salvar(pCodigoCliente: Integer; pValorTotal: Double): Boolean;
    function GetUltimoID(): Integer;
  end;

implementation

function TPedidoController.Salvar(pCodigoCliente: Integer; pValorTotal: Double): Boolean;
var
  lPedidoModel: TPedidoModel;
begin
  lPedidoModel := TPedidoModel.Create();
  try
    lPedidoModel.CodigoCliente := pCodigoCliente;
    lPedidoModel.ValorTotal := pValorTotal;

    Result := lPedidoModel.Salvar();
  finally
    lPedidoModel.Free();
  end;
end;

function TPedidoController.GetUltimoID(): Integer;
const
  CONSULTA = 'SELECT MAX(NUMERO_PEDIDO) AS CODIGO FROM PEDIDOS';
begin
  Result := TPedidoModel.Open(CONSULTA).fields.FieldByName('CODIGO').AsInteger;
end;

end.
