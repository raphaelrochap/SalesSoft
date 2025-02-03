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
    function ExibirERetornarSelecaoPedido(pDsPedidos: TFDQuery): TSelecaoModel;
  end;

implementation

function TSelecaoController.ExibirERetornarSelecaoCliente(pDsClientes: TFDQuery): TSelecaoModel;
var
  lCliente: TSelecaoModel;
begin
  lCliente := TSelecaoModel.ModeloZerado();

  if TFrmSelecao.ExibirTelaDeSelecao(pDsClientes, 'clientes') = mrOK then
    lCliente.Codigo := pDsClientes.fields.FieldByName('Código').AsInteger;

  Result := lCliente;
end;

function TSelecaoController.ExibirERetornarSelecaoProduto(pDsProdutos: TFDQuery): TSelecaoModel;
var
  lProduto: TSelecaoModel;
begin
  lProduto := TSelecaoModel.ModeloZerado();

  if TFrmSelecao.ExibirTelaDeSelecao(pDsProdutos, 'produtos') = mrOK then
    lProduto.Codigo := pDsProdutos.fields.FieldByName('Código').AsInteger;

  Result := lProduto;
end;

function TSelecaoController.ExibirERetornarSelecaoPedido(pDsPedidos: TFDQuery): TSelecaoModel;
var
  lPedido: TSelecaoModel;
begin
  lPedido := TSelecaoModel.ModeloZerado();

  if TFrmSelecao.ExibirTelaDeSelecao(pDsPedidos, 'produtos') = mrOK then
    lPedido.Codigo := pDsPedidos.fields.FieldByName('Número do Pedido').AsInteger;

  Result := lPedido;
end;

end.
