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
    btnAdicionarEditarItem: TBitBtn;
    grdItensPedido: TDBGrid;
    dsItensPedido: TDataSource;
    cdsItensPedido: TClientDataSet;
    cdsItensPedidoCodigo: TIntegerField;
    cdsItensPedidoDescricao: TStringField;
    cdsItensPedidoQuantidade: TIntegerField;
    cdsItensPedidoValorUnitario: TCurrencyField;
    cdsItensPedidoValorTotal: TCurrencyField;
    procedure btnAdicionarEditarItemClick(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTotal: Double;
    FItensInsercao: Boolean;
    FClienteSelecionado: TSelecaoModel;
    FProdutoSelecionado: TSelecaoModel;

    procedure AtualizarPrecoTotal();
    procedure SetarValoresCamposCliente();
    procedure SetarValoresCamposProduto();
    procedure LimparDadosProduto();
    procedure ValidaRemocaoDeItemDoCarrinho(Key: Word);
    procedure ValidaEdicaoDeItemDoCarrinho(Key: Word);
    procedure SetarCamposItensComo(pVisibilidade: Boolean);
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

procedure TFrmPedidoVenda.btnAdicionarEditarItemClick(Sender: TObject);
begin
  if not CamposValidos() then
  begin
    MessageDlg('� necess�rio que todos os campos estejam devidamente preenchidos.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if FItensInsercao then
    begin
      cdsItensPedido.Append()
    end
  else
    begin
      cdsItensPedido.Edit();
      SetarCamposItensComo(True);
    end;

  cdsItensPedidoCodigo.Value := StrToInt(edtCodigoProduto.Text);
  cdsItensPedidoDescricao.AsString := edtDescricaoProduto.Text;
  cdsItensPedidoQuantidade.Value := StrToInt(edtQuantidade.Text);
  cdsItensPedidoValorUnitario.Value := StrToFloat(edtValorUnitario.Text);
  cdsItensPedidoValorTotal.Value := StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text);

  cdsItensPedido.Post();

  AtualizarPrecoTotal();
  LimparDadosProduto();
  btnAdicionarEditarItem.Glyph.LoadFromResourceName(HInstance, 'ADDICON');
end;

procedure TFrmPedidoVenda.SetarValoresCamposCliente();
var
  lCodigoTratado: String;
begin
  lCodigoTratado := TSalesSoftUtils.IIF(FClienteSelecionado.Codigo = -1, '', FClienteSelecionado.Codigo);

  edtCodigoCliente.Text := lCodigoTratado;
  edtNomeCliente.Text := FClienteSelecionado.Nome;

  btnVerPedidos.Enabled := FClienteSelecionado.Codigo = -1;
  btnCancelarPedido.Enabled := FClienteSelecionado.Codigo = -1;
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
const
  MENSAGEM = 'Ao remover o cliente, voc� est� cancelando o lan�amento deste pedido e todos os itens inclu�dos abaixo ser�o retirados da tabela.' + TSalesSoftUtils.CRLF
    + TSalesSoftUtils.CRLF + 'Deseja prosseguir?';
var
  lPedidoVendaController: TPedidoVendaController;
begin
  if ((FClienteSelecionado.Codigo = -1) and (edtCodigoCliente.Text = '')) then
    Exit;

  if ((FClienteSelecionado.Codigo <> -1) and (edtCodigoCliente.Text = '')) then
    begin
      if (MessageDlg(MENSAGEM, mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes) then
      begin
        FClienteSelecionado := TSelecaoModel.ModeloZerado();
        FProdutoSelecionado := TSelecaoModel.ModeloZerado();
        SetarValoresCamposCliente();
        SetarValoresCamposProduto();
        cdsItensPedido.EmptyDataSet();
        AtualizarPrecoTotal();

        TSalesSoftUtils.SetarFoco(edtCodigoCliente);
      end
      else
        edtCodigoCliente.Text := IntToStr(FClienteSelecionado.Codigo);
    end
  else
    begin
      lPedidoVendaController := TPedidoVendaController.Create();
      try
        FClienteSelecionado := lPedidoVendaController.PesquisaERetornaClientePorCodigo(StrToIntDef(edtCodigoCliente.Text, -1));
        SetarValoresCamposCliente();
      finally
        lPedidoVendaController.Free();
      end;
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
  FItensInsercao := True;
  FClienteSelecionado := TSelecaoModel.ModeloZerado();
  FProdutoSelecionado := TSelecaoModel.ModeloZerado();
end;

procedure TFrmPedidoVenda.SetarCamposItensComo(pVisibilidade: Boolean);
begin
  FItensInsercao := pVisibilidade;
  grdItensPedido.Enabled := pVisibilidade;
  edtCodigoProduto.Enabled:= pVisibilidade;
  btnPesquisarProduto.Enabled := pVisibilidade;
end;

procedure TFrmPedidoVenda.ValidaEdicaoDeItemDoCarrinho(Key: Word);
begin
  if (Key = VK_RETURN) then
  begin
    SetarCamposItensComo(False);

    cdsItensPedido.DisableControls();
    edtCodigoProduto.Text := IntToStr(cdsItensPedidoCodigo.Value);
    edtDescricaoProduto.Text := cdsItensPedidoDescricao.AsString;
    edtQuantidade.Text := IntToStr(cdsItensPedidoQuantidade.Value);
    edtValorUnitario.Text := FloatToStr(cdsItensPedidoValorUnitario.Value);
    cdsItensPedido.EnableControls();

    btnAdicionarEditarItem.Glyph.LoadFromResourceName(HInstance, 'EDITICON');
    TSalesSoftUtils.SetarFoco(edtQuantidade);
  end;
end;

procedure TFrmPedidoVenda.ValidaRemocaoDeItemDoCarrinho(Key: Word);
const
  MENSAGEM = 'Produto: %d - %s' + TSalesSoftUtils.CRLF + 'Quantidade: %d' + TSalesSoftUtils.CRLF + 'Valor Unit�rio: R$ %f' + TSalesSoftUtils.CRLF + 'Valor Total: R$ %f'
    + TSalesSoftUtils.CRLF + TSalesSoftUtils.CRLF + 'Voc� tem certeza que quer remover esse item do pedido?';
var
  lDescricao: AnsiString;
  lCodigo, lQuantidade: Integer;
  lValorUnitario, lValorTotal: Double;
begin
  lCodigo := cdsItensPedidoCodigo.Value;
  lDescricao := cdsItensPedidoDescricao.Value;
  lQuantidade := cdsItensPedidoQuantidade.Value;
  lValorUnitario := cdsItensPedidoValorUnitario.Value;
  lValorTotal := cdsItensPedidoValorTotal.Value;

  if (Key = VK_DELETE) and
    (MessageDlg(Format(MENSAGEM, [lCodigo, lDescricao, lQuantidade, lValorUnitario, lValorTotal]), mtInformation, [mbYes, mbNo], 0, mbNo) = mrYes)
  then
    cdsItensPedido.Delete();
end;

procedure TFrmPedidoVenda.grdItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ValidaRemocaoDeItemDoCarrinho(Key);
  ValidaEdicaoDeItemDoCarrinho(Key);
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
      lblTotalValor.Caption := FormatFloat('#,##0.00', FTotal);
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
