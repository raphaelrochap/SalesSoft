unit SelecaoController;

interface

uses
   Vcl.Controls, SysUtils, Dialogs, SelecaoModel, Selecao, FireDac.Comp.Client;

type
  TSelecaoController = class
  private
  public
    function ExibirERetornarSelecaoCliente(pDsClientes: TFDQuery): TSelecaoModel;
    function ExibirERetornarSelecaoProduto(pDsProdutos: TFDQuery): TSelecaoModel;
  end;

implementation

function TSelecaoController.ExibirERetornarSelecaoCliente(pDsClientes: TFDQuery): TSelecaoModel;
var
  lCliente: TSelecaoModel;
begin
  lCliente := TSelecaoModel.ModeloZerado();

  if TFrmSelecao.ExibirTelaDeSelecao(pDsClientes, 'clientes') = mrOK then
  begin
    lCliente.Codigo := pDsClientes.fields.FieldByName('Código').AsInteger;
    lCliente.Nome := pDsClientes.fields.FieldByName('Nome').AsString;
  end;

  Result := lCliente;
end;

function TSelecaoController.ExibirERetornarSelecaoProduto(pDsProdutos: TFDQuery): TSelecaoModel;
var
  lProduto: TSelecaoModel;
begin
  lProduto := TSelecaoModel.ModeloZerado();

  if TFrmSelecao.ExibirTelaDeSelecao(pDsProdutos, 'produtos') = mrOK then
  begin
    lProduto.Codigo := pDsProdutos.fields.FieldByName('Código').AsInteger;
    lProduto.Descricao := pDsProdutos.fields.FieldByName('Descrição').AsString;
  end;

  Result := lProduto;
end;

end.
