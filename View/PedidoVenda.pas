unit PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

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
    lblTotal: TLabel;
    lblTotalValor: TLabel;
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
    dsItensPedido: TDataSource;
    cdsItensPedido: TClientDataSet;
    cdsItensPedidoCodigo: TIntegerField;
    cdsItensPedidoDescricao: TStringField;
    cdsItensPedidoQuantidade: TIntegerField;
    cdsItensPedidoValorUnitario: TCurrencyField;
    cdsItensPedidoValorTotal: TCurrencyField;
    procedure btnAdicionarItemClick(Sender: TObject);
  private
    FTotal: Double;

    procedure AtualizarPrecoTotal();
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

procedure TFrmPedidoVenda.btnAdicionarItemClick(Sender: TObject);
begin
  cdsItensPedido.Append();
  cdsItensPedidoCodigo.Value := StrToInt(edtCodigoProduto.Text);
  cdsItensPedidoDescricao.Value := edtDescricaoProduto.Text;
  cdsItensPedidoQuantidade.Value := StrToInt(edtQuantidade.Text);
  cdsItensPedidoValorUnitario.Value := StrToFloat(edtValorUnitario.Text);
  cdsItensPedidoValorTotal.Value := StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text);
  cdsItensPedido.Post();

  AtualizarPrecoTotal();
end;

procedure TFrmPedidoVenda.AtualizarPrecoTotal();
var
  lBookMark: TBookmark;
  lTotal: Double;
begin
  if (cdsItensPedido.RecordCount > 0) then
    begin
      lBookMark := cdsItensPedido.GetBookmark;
      cdsItensPedido.DisableControls;
      try
        lTotal := 0;
        cdsItensPedido.First;
        while not cdsItensPedido.Eof do
        begin
          lTotal := lTotal + cdsItensPedidoValorTotal.Value;
          cdsItensPedido.Next;
        end;
        FTotal := lTotal;
        lblTotalValor.Caption := FormatFloat('#,##0.00', FTotal);
      finally
        cdsItensPedido.GotoBookmark(lBookMark);
        cdsItensPedido.EnableControls;
      end;
    end
  else if (cdsItensPedido.RecordCount = 0) then
    begin
      FTotal := 0;
      lblTotal.Caption := Format('Total: R$ %s', [FormatFloat('0.00', FTotal)]);
    end;
end;

end.
