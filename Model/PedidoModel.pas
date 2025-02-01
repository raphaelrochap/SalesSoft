unit PedidoModel;

interface

uses
  Dialogs, SysUtils, BaseModel, FireDac.Comp.Client, ConexaoMySQLDAO;

type
  TPedidoModel = class(TBaseModel)
  private
    FNumeroPedido: Integer;
    FDataEmissao: String;
    FCodigoCliente: Integer;
    FValorTotal: Double;
  public
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;

    function Salvar(): Boolean;
  end;

implementation

function TPedidoModel.Salvar(): Boolean;
const
  CONSULTA = 'INSERT INTO PEDIDOS ' +
             '   (CODIGO_CLIENTE, VALOR_TOTAL) ' +
             ' VALUES ' +
             '   (%d, %s)';
begin
  Result := ExecSQL(Format(
    CONSULTA, [
      Self.CodigoCliente,
      StringReplace(FloatToStr(ValorTotal), ',', '.', [rfReplaceAll])
    ]));
end;

end.
