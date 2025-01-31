unit Selecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TFrmSelecao = class(TForm)
    Panel1: TPanel;
    GridSelecao: TDBGrid;
    btnSelecionar: TButton;
    dsSelecao: TDataSource;
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridSelecaoDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function ExibirTelaDeSelecao(pDataSet: TFDQuery; pEntidade: String): TModalResult; static;
    constructor Create(AOwner: TComponent; pDataSet: TFDQuery); reintroduce; overload;
  end;

var
  FrmSelecao: TFrmSelecao;

implementation

{$R *.dfm}

{ TFrmSelecao }

procedure TFrmSelecao.btnSelecionarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

constructor TFrmSelecao.Create(AOwner: TComponent; pDataSet: TFDQuery);
begin
  inherited Create(AOwner);

  dsSelecao.DataSet := pDataSet;
end;

class function TFrmSelecao.ExibirTelaDeSelecao(pDataSet: TFDQuery; pEntidade: String): TModalResult;
var
  lTelaDeSelecao: TFrmSelecao;
begin
  lTelaDeSelecao := TFrmSelecao.Create(nil, pDataSet);
  lTelaDeSelecao.Caption := 'Seleção de ' + pEntidade;

  try
    Result := lTelaDeSelecao.ShowModal();
  finally
    FreeAndNil(lTelaDeSelecao);
  end;
end;

procedure TFrmSelecao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
    ModalResult := mrCancel;
end;

procedure TFrmSelecao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ModalResult := mrOk;

  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TFrmSelecao.GridSelecaoDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
