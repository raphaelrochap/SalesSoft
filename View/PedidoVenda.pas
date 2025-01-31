unit PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, FireDAC.Comp.Client, Selecao, ClienteController, SalesSoftUtils, PedidoVendaController,
  SelecaoModel, UITypes, Vcl.Mask, Vcl.Samples.Spin;

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
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
  private
    FTotal: Double;
    FClienteSelecionado: TSelecaoModel;
    FProdutoSelecionado: TSelecaoModel;

    procedure AtualizarPrecoTotal();
    procedure SetarValoresCamposCliente();
    procedure SetarValoresCamposProduto();
    procedure LimparDadosProduto();
    function CamposValidos(): Boolean;
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

function TFrmPedidoVenda.CamposValidos(): Boolean;
begin
  Result := (edtCodigoCliente.Text <> '') and (edtCodigoProduto.Text <> '') and (edtQuantidade.Text <> '') and (edtValorUnitario.Text <> '');
end;

procedure TFrmPedidoVenda.btnAdicionarItemClick(Sender: TObject);
begin
  if not CamposValidos() then
  begin
    MessageDlg('Certifique-se de que todos os campos estão devidamente preenchidos.', mtInformation, [mbOK], 0);
    Exit;
  end;

  cdsItensPedido.Append();
  cdsItensPedidoCodigo.Value := StrToInt(edtCodigoProduto.Text);
  cdsItensPedidoDescricao.AsString := edtDescricaoProduto.Text;
  cdsItensPedidoQuantidade.Value := StrToInt(edtQuantidade.Text);
  cdsItensPedidoValorUnitario.Value := StrToFloat(edtValorUnitario.Text);
  cdsItensPedidoValorTotal.Value := StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text);
  cdsItensPedido.Post();

  AtualizarPrecoTotal();
  LimparDadosProduto();
end;

procedure TFrmPedidoVenda.SetarValoresCamposCliente();
var
  lCodigoTratado: String;
begin
  lCodigoTratado := TSalesSoftUtils.IIF(FClienteSelecionado.Codigo = -1, '', FClienteSelecionado.Codigo);

  edtCodigoCliente.Text := lCodigoTratado;
  edtNomeCliente.Text := FClienteSelecionado.Nome;
end;

procedure TFrmPedidoVenda.SetarValoresCamposProduto();
var
  lCodigoTratado: String;
begin
  lCodigoTratado := TSalesSoftUtils.IIF(FProdutoSelecionado.Codigo = -1, '', FProdutoSelecionado.Codigo);

  edtCodigoProduto.Text := lCodigoTratado;
  edtDescricaoProduto.Text := FProdutoSelecionado.Descricao;
end;

procedure TFrmPedidoVenda.btnPesquisarClienteClick(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
  lNovoClienteSelecionado: TSelecaoModel;
begin
  lPedidoVendaController := TPedidoVendaController.Create();
  try
    lNovoClienteSelecionado := lPedidoVendaController.ExibirERetornarSelecaoCliente(FClienteSelecionado);

    if ((lNovoClienteSelecionado.Codigo <> -1) and (lNovoClienteSelecionado.Codigo <> FClienteSelecionado.Codigo)) then
      FClienteSelecionado := lNovoClienteSelecionado;

    SetarValoresCamposCliente();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.btnPesquisarProdutoClick(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
  lNovoProdutoSelecionado: TSelecaoModel;
begin
  lPedidoVendaController := TPedidoVendaController.Create();
  try
    lNovoProdutoSelecionado := lPedidoVendaController.ExibirERetornarSelecaoProduto(FProdutoSelecionado);

    if ((lNovoProdutoSelecionado.Codigo <> -1) and (lNovoProdutoSelecionado.Codigo <> FProdutoSelecionado.Codigo)) then
      FProdutoSelecionado := lNovoProdutoSelecionado;

    SetarValoresCamposProduto();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.edtCodigoClienteExit(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
begin
  if ((FClienteSelecionado.Codigo = -1) and (edtCodigoCliente.Text = '')) then
    exit;

  lPedidoVendaController := TPedidoVendaController.Create();
  try
    FClienteSelecionado := lPedidoVendaController.PesquisaERetornaClientePorCodigo(StrToIntDef(edtCodigoCliente.Text, -1));
    SetarValoresCamposCliente();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.edtCodigoProdutoExit(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
begin
  if ((FProdutoSelecionado.Codigo = -1) and (edtCodigoProduto.Text = '')) then
    exit;

  lPedidoVendaController := TPedidoVendaController.Create();
  try
    FProdutoSelecionado := lPedidoVendaController.PesquisaERetornaProdutoPorCodigo(StrToIntDef(edtCodigoProduto.Text, -1));
    SetarValoresCamposProduto();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
var
  lVirgula: Char;
  lPos: Integer;
  lQtdVirgula: Integer;
begin
  lVirgula := FormatSettings.DecimalSeparator;
  lPos := Pos(lVirgula, TEdit(Sender).Text);

  if (not System.SysUtils.CharInSet(Key, ['0'..'9', #8, lVirgula])) or (Key = lVirgula) and (lPos > 0) then
  begin
    Key := #0;
    Exit;
  end;

  if (lPos > 0) and (System.SysUtils.CharInSet(Key, ['0'..'9'])) then
  begin
    lQtdVirgula := Length(Copy(TEdit(Sender).Text, lPos + 1, Length(TEdit(Sender).Text)));
    if (lQtdVirgula >= 2) and (edtValorUnitario.SelLength = 0) then
      Key := #0;
  end;
end;

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  FClienteSelecionado := TSelecaoModel.ModeloZerado();
  FProdutoSelecionado := TSelecaoModel.ModeloZerado();
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

procedure TFrmPedidoVenda.LimparDadosProduto();
begin
  FProdutoSelecionado := TSelecaoModel.ModeloZerado();

  SetarValoresCamposProduto();

  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';

  TSalesSoftUtils.SetarFoco(edtCodigoProduto);
end;

end.
