unit ItemPedidoController;

interface

uses
  ItemPedidoModel;

type
  TItemPedidoController = class
  public
    function Salvar(pNumeroPedido, pCodigoProduto, pQuantidade: Integer; pValorUnitario, pValorTotal: Double): Boolean;
  end;

implementation

function TItemPedidoController.Salvar(pNumeroPedido, pCodigoProduto, pQuantidade: Integer; pValorUnitario, pValorTotal: Double): Boolean;
var
  lPedidoModel: TItemPedidoModel;
begin
  lPedidoModel := TItemPedidoModel.Create();
  try
    lPedidoModel.NumeroPedido := pNumeroPedido;
    lPedidoModel.Produto.Codigo := pCodigoProduto;
    lPedidoModel.Quantidade := pQuantidade;
    lPedidoModel.ValorUnitario := pValorUnitario;
    lPedidoModel.ValorTotal := pValorTotal;

    Result := lPedidoModel.Salvar();
  finally
    lPedidoModel.Free();
  end;
end;

end.
