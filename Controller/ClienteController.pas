unit ClienteController;

interface

uses
  FireDAC.Comp.Client, ClienteModel, SelecaoModel, Dialogs;

type
  TClienteController = class
  private

  public
    function GetAll(): TFDQuery;
    function ExibirERetornarSelecao(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
    function PesquisaERetornaPorCodigo(pCodigo: Integer): TSelecaoModel;
  end;

implementation

uses
  SelecaoController;

function TClienteController.ExibirERetornarSelecao(pSelecaoAtual: TSelecaoModel): TSelecaoModel;
var
  lSelecaoController: TSelecaoController;
  lDsClientes: TFDQuery;
begin
  lSelecaoController := TSelecaoController.Create();
  lDsClientes := GetAll();
  try
    Result := lSelecaoController.ExibirERetornarSelecaoCliente(pSelecaoAtual, lDsClientes);
  finally
    lSelecaoController.Free();
    lDsClientes.Free();
  end;
end;

function TClienteController.GetAll(): TFDQuery;
begin
  Result := TClienteModel.GetAll();
end;

function TClienteController.PesquisaERetornaPorCodigo(pCodigo: Integer): TSelecaoModel;
var
  lDsClientes: TFDQuery;
begin
  lDsClientes := GetAll();
  try
    Result := TSelecaoModel.ModeloZerado();

    if lDsClientes.Locate('codigo', pCodigo) then
      begin
        Result.Codigo := lDsClientes.fields.FieldByName('codigo').AsInteger;
        Result.Nome := lDsClientes.fields.FieldByName('descricao').AsString;
      end
    else
      ShowMessage('Não foi encontrado um Cliente com esse código.');
  finally
    lDsClientes.Free();
  end;
end;

end.
