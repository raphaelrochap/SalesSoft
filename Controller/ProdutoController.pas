unit ProdutoController;

interface

uses
  SysUtils, FireDAC.Comp.Client, ProdutoModel, SelecaoModel, Dialogs;

type
  TProdutoController = class
  private

  public
    function GetAll(): TFDQuery;
    function ExibirERetornarSelecao(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
    function PesquisaERetornaPorCodigo(pCodigo: Integer): TSelecaoModel;
  end;

implementation

uses
  SelecaoController;

function TProdutoController.ExibirERetornarSelecao(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
var
  lSelecaoController: TSelecaoController;
  lDsProdutos: TFDQuery;
begin
  lDsProdutos := GetAll();
  lSelecaoController := TSelecaoController.Create();
  try
    Result := lSelecaoController.ExibirERetornarSelecaoProduto(pSelecaoAtual, lDsProdutos);
  finally
    lDsProdutos.Free();
    lSelecaoController.Free();
  end;
end;

function TProdutoController.GetAll(): TFDQuery;
begin
  Result := TProdutoModel.GetAll();
end;

function TProdutoController.PesquisaERetornaPorCodigo(pCodigo: Integer): TSelecaoModel;
var
  lDsProdutos: TFDQuery;
begin
  lDsProdutos := GetAll();
  try
    Result := TSelecaoModel.ModeloZerado();

    if lDsProdutos.Locate('codigo', pCodigo) then
      begin
        Result.Codigo := lDsProdutos.fields.FieldByName('codigo').AsInteger;
        Result.Descricao := lDsProdutos.fields.FieldByName('descricao').AsString;
      end
    else
      ShowMessage('Não foi encontrado um Produto com esse código.');
  finally
    lDsProdutos.Free();
  end;
end;

end.
