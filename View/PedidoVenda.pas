unit PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrmPedidoVenda = class(TForm)
    pnlHeader: TPanel;
    btnNovoPedido: TSpeedButton;
    btnVerPedidos: TSpeedButton;
    btnCancelarPedido: TSpeedButton;
    pnlContent: TPanel;
    tcItens: TTabControl;
    pnlBottom: TPanel;
    btnGravarPedido: TButton;
    TotalLabel: TLabel;
    TotalValor: TLabel;
    edtCodigoCliente: TEdit;
    btnPesquisarCliente: TBitBtn;
    edtNomeCliente: TEdit;
    pnlCliente: TPanel;
    pnlItens: TPanel;
    lblCliente: TLabel;
    pnlItensHeader: TPanel;
    pnlItensContent: TPanel;
    lblProduto: TLabel;
    edtCodigoProduto: TEdit;
    btnPesquisarProduto: TBitBtn;
    edtDescricaoProduto: TEdit;
    edtQuantidade: TEdit;
    lblQuantidade: TLabel;
    edtValorUnitario: TEdit;
    lblValorUnitario: TLabel;
    btnAdicionarItem: TBitBtn;
    grdItensPedido: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

end.
