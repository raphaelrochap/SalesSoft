unit ItemPedidoModel;

interface

uses
  SysUtils, FireDAC.Comp.Client, ConexaoMySQLDAO, BaseModel;

type
  TItemPedidoModel = class(TBaseModel)
  private
    FId: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;
  public
    property Id: Integer read FId write FId;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;

    function Salvar(): Boolean;
  end;

implementation

function TItemPedidoModel.Salvar(): Boolean;
const
  CONSULTA = 'INSERT INTO PEDIDOITENS' +
             '   (NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) ' +
             ' VALUES ' +
             '   (%d, %d, %d, %s, %s);';
begin
  Result := ExecSQL(Format(
    CONSULTA, [
      Self.NumeroPedido,
      Self.CodigoProduto,
      Self.Quantidade,
      StringReplace(FloatToStr(Self.ValorUnitario), ',', '.', [rfReplaceAll]),
      StringReplace(FloatToStr(Self.ValorTotal), ',', '.', [rfReplaceAll])
    ]));
end;

end.
