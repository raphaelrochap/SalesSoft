unit TelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, PedidoVenda;

type
  TFrmTelaPrincipal = class(TForm)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    imgLogo: TImage;
    btnPedidoVenda: TButton;
    procedure btnPedidoVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTelaPrincipal: TFrmTelaPrincipal;

implementation

{$R *.dfm}

procedure TFrmTelaPrincipal.btnPedidoVendaClick(Sender: TObject);
var
  lFrmPedidoVenda: TFrmPedidoVenda;
begin
  lFrmPedidoVenda := TFrmPedidoVenda.Create(self);
  lFrmPedidoVenda.ShowModal();
end;

end.
