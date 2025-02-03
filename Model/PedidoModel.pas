unit PedidoModel;

interface

uses
  Dialogs, SysUtils, BaseModel, FireDac.Comp.Client, ConexaoMySQLDAO, ClienteModel, ItemPedidoModel;

type
  TPedidoModel = class(TBaseModel)
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDateTime;
    FCliente: TClienteModel;
    FValorTotal: Double;
    FItens: TArray<TItemPedidoModel>;
  public
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property Cliente: TClienteModel read FCliente write FCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Itens: TArray<TItemPedidoModel> read FItens write FItens;

    class function GetAll(): TFDQuery;
    class function GetById(pCodigo: Integer): TPedidoModel;
    function Salvar(): Boolean;
    function Remover(): Boolean;
    procedure ZerarModelo();
    constructor Create();
    destructor Destroy; override;
  end;

implementation

constructor TPedidoModel.Create();
begin
  Self.FCliente := TClienteModel.Create();
  SetLength(FItens, 0);
end;

destructor TPedidoModel.Destroy();
var
  I: Integer;
begin
  FCliente.Free();

  for I := 0 to Length(FItens) -1 do
    FItens[I].Free();

  SetLength(FItens, 0);
end;

procedure TPedidoModel.ZerarModelo();
begin
  Self.NumeroPedido := -1;
  Self.DataEmissao := 0;
  Self.ValorTotal := 0;
end;

function TPedidoModel.Salvar(): Boolean;
const
  CONSULTA = 'INSERT INTO PEDIDOS ' +
             '   (CODIGO_CLIENTE, DATA_EMISSAO, VALOR_TOTAL) ' +
             ' VALUES ' +
             '   (%d, ''%s'', %s)';
begin
  Result := ExecSQL(Format(CONSULTA,
    [
      Self.Cliente.Codigo,
      FormatDateTime('yyyy-mm-dd hh:nn:ss', Self.DataEmissao),
      StringReplace(FloatToStr(ValorTotal), ',', '.', [rfReplaceAll])
    ]));
end;

class function TPedidoModel.GetAll(): TFDQuery;
const
   QUERY = 'SELECT ' +
           '  PEDIDOS.NUMERO_PEDIDO AS ''N�mero do Pedido'', ' +
           '  PEDIDOS.DATA_EMISSAO AS ''Data de Emiss�o'', ' +
           '  CLIENTES.CODIGO AS ''C�digo do Cliente'', ' +
           '  CLIENTES.NOME AS ''Nome do Cliente'', ' +
           '  PEDIDOS.VALOR_TOTAL AS ''Valor Total'' ' +
           'FROM ' +
           '	PEDIDOS ' +
           'INNER JOIN ' +
           '	CLIENTES ON CLIENTES.CODIGO = PEDIDOS.CODIGO_CLIENTE ';
begin
  Result := TFDQuery.Create(nil);
  try
    try
      FConexaoMySQLDAO.StartTransaction();
      Result.Connection := FConexaoMySQLDAO.FConexaoPrincipal;
      Result.SQL.Add(QUERY);
      Result.Open();
    except
      on E: Exception do
      begin
        FConexaoMySQLDAO.Rollback();
        ShowMessage('Erro: ' + E.Message);
      end;
    end;
  finally
    FConexaoMySQLDAO.Commit();
  end;
end;

class function TPedidoModel.GetById(pCodigo: Integer): TPedidoModel;
const
   QUERY = 'SELECT ' +
           '  PEDIDOS.NUMERO_PEDIDO AS ''N�mero do Pedido'', ' +
           '  PEDIDOS.DATA_EMISSAO AS ''Data de Emiss�o'', ' +
           '  CLIENTES.CODIGO AS ''C�digo do Cliente'', ' +
           '  CLIENTES.NOME AS ''Nome do Cliente'', ' +
           '  PEDIDOS.VALOR_TOTAL AS ''Valor Total'' ' +
           'FROM ' +
           '	PEDIDOS ' +
           'INNER JOIN ' +
           '	CLIENTES ON CLIENTES.CODIGO = PEDIDOS.CODIGO_CLIENTE ' +
           'WHERE ' +
           '	PEDIDOS.NUMERO_PEDIDO = %d ';
var
  lQueryPedido: TFDQuery;
begin
  lQueryPedido := Open(Format(QUERY, [pCodigo]));
  try
    Result := TPedidoModel.Create();
    Result.NumeroPedido := lQueryPedido.Fields.FieldByName('N�mero do Pedido').AsInteger;
    Result.DataEmissao := lQueryPedido.Fields.FieldByName('Data de Emiss�o').AsDateTime;
    Result.ValorTotal := lQueryPedido.Fields.FieldByName('Valor Total').AsInteger;
    Result.Cliente.Codigo := lQueryPedido.Fields.FieldByName('C�digo do Cliente').AsInteger;
    Result.Cliente.Nome := lQueryPedido.Fields.FieldByName('Nome do Cliente').AsString;
  finally
    lQueryPedido.Free();
  end;
end;

function TPedidoModel.Remover(): Boolean;
const
  CONSULTA = 'DELETE FROM PEDIDOS WHERE NUMERO_PEDIDO = %d';
begin
  Result := ExecSQL(Format(CONSULTA, [Self.NumeroPedido]));
end;

end.
