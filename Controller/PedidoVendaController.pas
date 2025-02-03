unit PedidoVendaController;

interface

uses
  SelecaoModel, ClienteModel, ProdutoModel, PedidoModel, ClienteController, ProdutoController, PedidoController;

type
  TPedidoVendaController = class
  private
  public
    function RemoverPedido(pPedidoModelo: TPedidoModel): Boolean;
    function ExibirERetornarSelecaoCliente(): TClienteModel;
    function ExibirERetornarSelecaoProduto(): TProdutoModel;
    function ExibirERetornarSelecaoPedido(): TPedidoModel;
    function PesquisaERetornaClientePorCodigo(pClienteSelecionado: TClienteModel; pCodigo: Integer): TClienteModel;
    function PesquisaERetornaProdutoPorCodigo(pCodigo: Integer): TProdutoModel;
  end;

implementation

function TPedidoVendaController.ExibirERetornarSelecaoCliente(): TClienteModel;
var
  lClienteController: TClienteController;
begin
  lClienteController := TClienteController.Create();
  try
    Result := lClienteController.ExibirERetornarSelecao();
  finally
    lClienteController.Free();
  end;
end;

function TPedidoVendaController.ExibirERetornarSelecaoProduto(): TProdutoModel;
var
  lProdutoController: TProdutoController;
begin
  lProdutoController := TProdutoController.Create();
  try
    Result := lProdutoController.ExibirERetornarSelecao();
  finally
    lProdutoController.Free();
  end;
end;

function TPedidoVendaController.ExibirERetornarSelecaoPedido(): TPedidoModel;
var
  lPedidoController: TPedidoController;
begin
  lPedidoController := TPedidoController.Create();
  try
    Result := lPedidoController.ExibirERetornarSelecao();
  finally
    lPedidoController.Free();
  end;
end;

function TPedidoVendaController.PesquisaERetornaClientePorCodigo(pClienteSelecionado: TClienteModel; pCodigo: Integer): TClienteModel;
var
  lClienteController: TClienteController;
begin
  lClienteController := TClienteController.Create();
  try
    Result := lClienteController.PesquisaERetornaPorCodigo(pClienteSelecionado, pCodigo);
  finally
    lClienteController.Free();
  end;
end;

function TPedidoVendaController.PesquisaERetornaProdutoPorCodigo(pCodigo: Integer): TProdutoModel;
var
  lProdutoController: TProdutoController;
begin
  lProdutoController := TProdutoController.Create();
  try
    Result := lProdutoController.PesquisaERetornaPorCodigo(pCodigo);
  finally
    lProdutoController.Free();
  end;
end;

function TPedidoVendaController.RemoverPedido(pPedidoModelo: TPedidoModel): Boolean;
begin
  Result := TPedidoController.Remover(pPedidoModelo);
end;

end.
