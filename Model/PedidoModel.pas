unit PedidoModel;

interface

uses
  Dialogs, SysUtils, BaseModel, FireDac.Comp.Client, ConexaoMySQLDAO, ClienteModel, ItemPedidoModel;

type
  TPedidoModel = class(TBaseModel)
  private
    FNumeroPedido: Integer;
    FDataEmissao: String;
    FCliente: TClienteModel;
    FValorTotal: Double;
    FItens: TArray<TItemPedidoModel>;
  public
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property Cliente: TClienteModel read FCliente write FCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Itens: TArray<TItemPedidoModel> read FItens write FItens;

    function Salvar(): Boolean;
    constructor Create();
  end;

implementation

constructor TPedidoModel.Create();
begin
  Self.FCliente := TClienteModel.Create();
  SetLength(FItens, 0);
end;

function TPedidoModel.Salvar(): Boolean;
const
  CONSULTA = 'INSERT INTO PEDIDOS ' +
             '   (CODIGO_CLIENTE, VALOR_TOTAL) ' +
             ' VALUES ' +
             '   (%d, %s)';
begin
  Result := ExecSQL(Format(
    CONSULTA, [
      Self.Cliente.Codigo,
      StringReplace(FloatToStr(ValorTotal), ',', '.', [rfReplaceAll])
    ]));
end;

end.
