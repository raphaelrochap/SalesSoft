unit ClienteController;

interface

uses
  SysUtils, FireDAC.Comp.Client, ClienteModel, SelecaoModel, Dialogs, UITypes;

type
  TClienteController = class
  private

  public
    function GetAll(): TFDQuery;
    function GetById(pCodigo: Integer): TClienteModel;
    function ExibirERetornarSelecao(): TClienteModel;
    function PesquisaERetornaPorCodigo(pClienteSelecionado: TClienteModel; pCodigo: Integer): TClienteModel;
  end;

implementation

uses
  SelecaoController;

function TClienteController.ExibirERetornarSelecao(): TClienteModel;
var
  lSelecaoController: TSelecaoController;
  lSelecaoModelo: TSelecaoModel;
  lDsClientes: TFDQuery;
begin
  lSelecaoController := TSelecaoController.Create();
  lDsClientes := GetAll();
  try
    lSelecaoModelo := lSelecaoController.ExibirERetornarSelecaoCliente(lDsClientes);
    Result := GetById(lSelecaoModelo.Codigo);
  finally
    lSelecaoController.Free();
    lDsClientes.Free();
  end;
end;

function TClienteController.GetAll(): TFDQuery;
begin
  Result := TClienteModel.GetAll();
end;

function TClienteController.GetById(pCodigo: Integer): TClienteModel;
begin
  if (pCodigo <> -1) then
    Result := TClienteModel.GetById(pCodigo)
  else
  begin
    Result := TClienteModel.Create();
    Result.ZerarModelo();
  end;
end;

function TClienteController.PesquisaERetornaPorCodigo(pClienteSelecionado: TClienteModel; pCodigo: Integer): TClienteModel;
var
  lDsClientes: TFDQuery;
  lSelecaoModelo: TSelecaoModel;
begin
  lDsClientes := GetAll();
  try
    lSelecaoModelo := TSelecaoModel.ModeloZerado();

    if lDsClientes.Locate('Código', pCodigo) then
      begin
        lSelecaoModelo.Codigo := lDsClientes.fields.FieldByName('Código').AsInteger;
        Result := GetById(lSelecaoModelo.Codigo);
        FreeAndNil(pClienteSelecionado);
      end
    else
      begin
        MessageDlg('Não foi encontrado um Cliente com esse código.', mtInformation, [mbOK], 0);
        Result := pClienteSelecionado;
      end;
  finally
    lDsClientes.Free();
  end;
end;

end.
