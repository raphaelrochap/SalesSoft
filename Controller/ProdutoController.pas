unit ProdutoController;

interface

uses
  SysUtils, FireDAC.Comp.Client, ProdutoModel, SelecaoModel, Dialogs, ClienteModel;

type
  TProdutoController = class
  private

  public
    function GetAll(): TFDQuery;
    function GetById(pCodigo: Integer): TProdutoModel;
    function ExibirERetornarSelecao(): TProdutoModel;
    function PesquisaERetornaPorCodigo(pCodigo: Integer): TProdutoModel;
  end;

implementation

uses
  SelecaoController;

function TProdutoController.ExibirERetornarSelecao(): TProdutoModel;
var
  lSelecaoController: TSelecaoController;
  lSelecaoModelo: TSelecaoModel;
  lDsProdutos: TFDQuery;
begin
  lDsProdutos := GetAll();
  lSelecaoController := TSelecaoController.Create();
  try
    lSelecaoModelo := lSelecaoController.ExibirERetornarSelecaoProduto(lDsProdutos);
    Result := GetById(lSelecaoModelo.Codigo);
  finally
    lDsProdutos.Free();
    lSelecaoController.Free();
  end;
end;

function TProdutoController.GetAll(): TFDQuery;
begin
  Result := TProdutoModel.GetAll();
end;

function TProdutoController.GetById(pCodigo: Integer): TProdutoModel;
begin
  Result := TProdutoModel.Create();
  Result.ZerarModelo();

  if (pCodigo <> -1) then
    Result := TProdutoModel.GetById(pCodigo);
end;

function TProdutoController.PesquisaERetornaPorCodigo(pCodigo: Integer): TProdutoModel;
var
  lDsProdutos: TFDQuery;
  lSelecaoModelo: TSelecaoModel;
begin
  lDsProdutos := GetAll();
  try
    lSelecaoModelo := TSelecaoModel.ModeloZerado();

    if lDsProdutos.Locate('Código', pCodigo) then
      begin
        lSelecaoModelo.Codigo := lDsProdutos.fields.FieldByName('Código').AsInteger;
        Result := GetById(lSelecaoModelo.Codigo);
      end
    else
      begin
        Result := TProdutoModel.Create();
        Result.ZerarModelo();
        MessageDlg('Não foi encontrado um Produto com esse código.', mtInformation, [mbOK], 0)
      end;
  finally
    lDsProdutos.Free();
  end;
end;

end.
