unit PedidoVendaController;

interface

uses
  SelecaoModel, ClienteController, ProdutoController;

type
  TPedidoVendaController = class
  private
  public
    function ExibirERetornarSelecaoCliente(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
    function ExibirERetornarSelecaoProduto(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
    function PesquisaERetornaClientePorCodigo(pCodigo: Integer): TSelecaoModel;
    function PesquisaERetornaProdutoPorCodigo(pCodigo: Integer): TSelecaoModel;
  end;

implementation

function TPedidoVendaController.ExibirERetornarSelecaoCliente(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
var
  lClienteController: TClienteController;
begin
  lClienteController := TClienteController.Create();
  try
    Result := lClienteController.ExibirERetornarSelecao(pSelecaoAtual);
  finally
    lClienteController.Free();
  end;
end;

function TPedidoVendaController.PesquisaERetornaClientePorCodigo(pCodigo: Integer): TSelecaoModel;
var
  lClienteController: TClienteController;
begin
  lClienteController := TClienteController.Create();
  try
    Result := lClienteController.PesquisaERetornaPorCodigo(pCodigo);
  finally
    lClienteController.Free();
  end;
end;

function TPedidoVendaController.ExibirERetornarSelecaoProduto(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
var
  lProdutoController: TProdutoController;
begin
  lProdutoController := TProdutoController.Create();
  try
    Result := lProdutoController.ExibirERetornarSelecao(pSelecaoAtual);
  finally
    lProdutoController.Free();
  end;
end;

function TPedidoVendaController.PesquisaERetornaProdutoPorCodigo(pCodigo: Integer): TSelecaoModel;
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
