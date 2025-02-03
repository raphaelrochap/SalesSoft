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

end.
