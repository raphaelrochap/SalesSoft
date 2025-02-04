unit ItemPedidoController;

interface

uses
  SysUtils, ItemPedidoModel, BaseModel, PedidoModel;

type
  TItemPedidoController = class(TBaseModel)
  public
    function Salvar(pNumeroPedido, pCodigoProduto, pQuantidade: Integer; pValorUnitario, pValorTotal: Double): Boolean;
    class function Remover(pItemPedidoModelo: TItemPedidoModel): Boolean;
    class function GetById(pCodigo: Integer): TArray<TItemPedidoModel>;
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

class function TItemPedidoController.GetById(pCodigo: Integer): TArray<TItemPedidoModel>;
begin
  Result := TItemPedidoModel.GetById(pCodigo);
end;

class function TItemPedidoController.Remover(pItemPedidoModelo: TItemPedidoModel): Boolean;
begin
  Result := pItemPedidoModelo.Remover();
end;

end.
