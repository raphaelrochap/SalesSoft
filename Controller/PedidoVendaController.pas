unit PedidoVendaController;

interface

uses
  SelecaoModel, ClienteModel, ClienteController, ProdutoController, ProdutoModel;

type
  TPedidoVendaController = class
  private
  public
    function ExibirERetornarSelecaoCliente(): TClienteModel;
    function ExibirERetornarSelecaoProduto(): TProdutoModel;
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

end.
