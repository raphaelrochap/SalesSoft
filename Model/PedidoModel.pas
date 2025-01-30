unit PedidoModel;

interface

type
  TPedidoModel = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: String;
    FCodigoCliente: String;
    FValorTotal: Double;
  public
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property CodigoCliente: String read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

end.
