unit PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, FireDAC.Comp.Client, Selecao, ClienteController, SalesSoftUtils, PedidoVendaController,
  SelecaoModel, UITypes, Vcl.Mask, Vcl.Samples.Spin, PedidoController, ItemPedidoController, ConexaoMySQLDAO, ClienteModel, ProdutoModel, PedidoModel, ItemPedidoModel;

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
    lblPedidoTitulo: TLabel;
    lblNumeroPedidoValor: TLabel;
    lblDataEmissao: TLabel;
    lblEmitidoEm: TLabel;
    procedure btnAdicionarEditarItemClick(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnVerPedidosClick(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdItensPedidoKeyPress(Sender: TObject; var Key: Char);
  private
    FTotal: Double;
    FNovoPedido: Boolean;
    FItensInsercao: Boolean;
    FClienteSelecionado: TClienteModel;
    FProdutoSelecionado: TProdutoModel;

    procedure AtualizarPrecoTotal();
    procedure SetarValoresCamposCliente();
    procedure SetarValoresCamposProduto();
    procedure LimparDadosProduto();
    procedure ValidaRemocaoDeItemDoCarrinho(Key: Word);
    procedure ValidaEdicaoDeItemDoCarrinho(Key: Word);
    procedure SetarCamposItensComo(pVisibilidade: Boolean);
    procedure DesabilitarCamposProduto(pVisibilidade: Boolean);
    procedure SetNovoPedido(pValue: Boolean);
    procedure PreencheGridItensDoPedido(pItensDoPedido: TArray<TItemPedidoModel>);
    procedure IniciarNovoPedido();
    procedure LimparDadosDaTela();
    function GravarPedidoERetornarID(): Integer;
    function GravarItensDoPedido(pCodigoPedido: Integer): Boolean;
    function CamposValidos(): Boolean;
  public
    property NovoPedido: Boolean read FNovoPedido write SetNovoPedido;
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

function TFrmPedidoVenda.CamposValidos(): Boolean;
begin
  Result := True;

  if (edtCodigoCliente.Text = '') then
  begin
    TSalesSoftUtils.SetarFoco(edtCodigoCliente);
    Result := False;
    Exit;
  end;

  if (edtCodigoProduto.Text = '') then
  begin
    TSalesSoftUtils.SetarFoco(edtCodigoProduto);
    Result := False;
    Exit;
  end;

  if (edtQuantidade.Text = '') then
  begin
    TSalesSoftUtils.SetarFoco(edtQuantidade);
    Result := False;
    Exit;
  end;

  if (edtValorUnitario.Text = '') then
  begin
    TSalesSoftUtils.SetarFoco(edtValorUnitario);
    Result := False;
    Exit;
  end;
end;

procedure TFrmPedidoVenda.btnAdicionarEditarItemClick(Sender: TObject);
begin
  if not CamposValidos() then
  begin
    MessageDlg('É necessário que todos os campos estejam devidamente preenchidos.', mtInformation, [mbOK], 0);
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

procedure TFrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
const
  MENSAGEM = 'Número do pedido: %d' + TSalesSoftUtils.CRLF + 'Data de Emissao: %s' + TSalesSoftUtils.CRLF + 'Valor Total: R$ %f' + TSalesSoftUtils.CRLF + 'Cliente: %s'
    + TSalesSoftUtils.CRLF + TSalesSoftUtils.CRLF + 'Você tem certeza que quer remover esse Pedido?';
var
  lPedidoVendaController: TPedidoVendaController;
  lPedidoSelecionado: TPedidoModel;
begin
  lPedidoVendaController := TPedidoVendaController.Create();
  lPedidoSelecionado := lPedidoVendaController.ExibirERetornarSelecaoPedido();
    if (lPedidoSelecionado.NumeroPedido <> - 1)
      and (MessageDlg(Format(MENSAGEM,
        [
          lPedidoSelecionado.NumeroPedido,
          FormatDateTime('dd/mm/yyyy', lPedidoSelecionado.DataEmissao),
          lPedidoSelecionado.ValorTotal,
          lPedidoSelecionado.Cliente.Nome
        ]), TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo) then
      begin
        lPedidoVendaController.Free();
        lPedidoSelecionado.Free();
        Exit;
      end;
  try
    try
      FConexaoMySQLDAO.StartTransaction();
      if lPedidoVendaController.RemoverPedido(lPedidoSelecionado) then
        MessageDlg('Pedido cancelado com sucesso!', mtInformation, [mbOK], 0)
      else
        FConexaoMySQLDAO.Rollback(False);
    except on E: Exception do
      FConexaoMySQLDAO.Rollback();
    end;
  finally
    FConexaoMySQLDAO.Commit();
    lPedidoVendaController.Free();
    lPedidoSelecionado.Free();
  end;
end;

function TFrmPedidoVenda.GravarPedidoERetornarID(): Integer;
var
  lPedidoController: TPedidoController;
begin
  lPedidoController := TPedidoController.Create();
  Result := -1;
  try
    if lPedidoController.Salvar(FClienteSelecionado.Codigo, FTotal) then
      Result := lPedidoController.GetUltimoID();
  finally
    lPedidoController.Free();
  end;
end;

function TFrmPedidoVenda.GravarItensDoPedido(pCodigoPedido: Integer): Boolean;
var
  lItemPedidoController: TItemPedidoController;
begin
  lItemPedidoController := TItemPedidoController.Create();
  try
    Result := lItemPedidoController.Salvar(
      pCodigoPedido,
      cdsItensPedidoCodigo.Value,
      cdsItensPedidoQuantidade.Value,
      cdsItensPedidoValorUnitario.AsFloat,
      cdsItensPedidoValorTotal.AsFloat
    );
  finally
    lItemPedidoController.Free();
  end;
end;

procedure TFrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
const
  MENSAGEM_ERRO = 'Houve um erro ao gravar os pedidos, verifique sua conexão com o Banco de Dados e tente novamente.';
  MENSAGEM_SUCESSO = 'Pedido gravado com sucesso!';
var
  lCodigoPedido: Integer;
begin
  if cdsItensPedido.RecordCount <= 0 then
  begin
    MessageDlg('É necessário pelo menos um item para lançar este pedido.', mtInformation, [mbOK], 0);
    TSalesSoftUtils.SetarFoco(edtCodigoProduto);
    Exit;
  end;

  FConexaoMySQLDAO.StartTransaction();
  lCodigoPedido := GravarPedidoERetornarID();

  if lCodigoPedido = -1 then
  begin
    FConexaoMySQLDAO.Rollback();
    MessageDlg(MENSAGEM_ERRO, mtInformation, [mbOK], 0);
    Exit;
  end;

  cdsItensPedido.First();
  while not cdsItensPedido.Eof do
  begin
    GravarItensDoPedido(lCodigoPedido);
    cdsItensPedido.Next();
  end;

  FConexaoMySQLDAO.Commit();
  LimparDadosDaTela();
  MessageDlg(MENSAGEM_SUCESSO, mtInformation, [mbOK], 0);
end;

procedure TFrmPedidoVenda.btnNovoPedidoClick(Sender: TObject);
begin
  btnNovoPedido.Down := True;
  IniciarNovoPedido();
end;

procedure TFrmPedidoVenda.IniciarNovoPedido();
begin
  if (not FNovoPedido) then
  begin
    LimparDadosDaTela();
    lblPedidoTitulo.Visible := False;
    lblNumeroPedidoValor.Visible := False;

    lblEmitidoEm.Visible := False;
    lblDataEmissao.Visible := False;
  end;
end;

procedure TFrmPedidoVenda.SetarValoresCamposCliente();
var
  lHaClienteSelecionado: Boolean;
begin
  lHaClienteSelecionado := not (FClienteSelecionado.Codigo = -1);

  edtCodigoCliente.Text := TSalesSoftUtils.IIF(FClienteSelecionado.Codigo = -1, '', FClienteSelecionado.Codigo);;
  edtNomeCliente.Text := FClienteSelecionado.Nome;

  if (FNovoPedido) then
    begin
      btnVerPedidos.Enabled := not lHaClienteSelecionado;
      btnGravarPedido.Enabled := lHaClienteSelecionado;
      edtCodigoCliente.Enabled := True;
      btnPesquisarCliente.Enabled := True;
      edtNomeCliente.Enabled := True;
    end
  else
    begin
      btnVerPedidos.Enabled := True;
      btnGravarPedido.Enabled := False;
      edtCodigoCliente.Enabled := False;
      btnPesquisarCliente.Enabled := False;
      edtNomeCliente.Enabled := False;
    end;

  btnCancelarPedido.Enabled := not lHaClienteSelecionado;
  edtCodigoProduto.Enabled := lHaClienteSelecionado;
  btnPesquisarProduto.Enabled := lHaClienteSelecionado;
  edtDescricaoProduto.Enabled := lHaClienteSelecionado;
  edtQuantidade.Enabled := lHaClienteSelecionado;
  edtValorUnitario.Enabled := lHaClienteSelecionado;
  btnAdicionarEditarItem.Enabled := lHaClienteSelecionado;
  grdItensPedido.Enabled := lHaClienteSelecionado;
end;

procedure TFrmPedidoVenda.SetarValoresCamposProduto();
begin
  edtCodigoProduto.Text := TSalesSoftUtils.IIF(FProdutoSelecionado.Codigo = -1, '', FProdutoSelecionado.Codigo);;
  edtDescricaoProduto.Text := FProdutoSelecionado.Descricao;
  edtValorUnitario.Text := TSalesSoftUtils.IIF(FProdutoSelecionado.Codigo = -1, '', FloatToStr(FProdutoSelecionado.PrecoVenda));

  if (FProdutoSelecionado.Codigo = -1) then
    edtQuantidade.Text := '';
end;

procedure TFrmPedidoVenda.btnPesquisarClienteClick(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
  lNovoClienteSelecionado: TClienteModel;
begin
  lPedidoVendaController := TPedidoVendaController.Create();
  lNovoClienteSelecionado := lPedidoVendaController.ExibirERetornarSelecaoCliente();
  try
    if ((lNovoClienteSelecionado.Codigo <> -1) and (lNovoClienteSelecionado.Codigo <> FClienteSelecionado.Codigo)) then
    begin
      if Assigned(FClienteSelecionado) then
        FreeAndNil(FClienteSelecionado);

      FClienteSelecionado := lNovoClienteSelecionado;
      TSalesSoftUtils.SetarFoco(edtCodigoProduto);
    end;

    SetarValoresCamposCliente();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.btnPesquisarProdutoClick(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
  lNovoProdutoSelecionado: TProdutoModel;
begin
  lPedidoVendaController := TPedidoVendaController.Create();
  lNovoProdutoSelecionado := lPedidoVendaController.ExibirERetornarSelecaoProduto();
  try

    if ((lNovoProdutoSelecionado.Codigo <> -1) and (lNovoProdutoSelecionado.Codigo <> FProdutoSelecionado.Codigo)) then
    begin
      if Assigned(FProdutoSelecionado) then
        FreeAndNil(FProdutoSelecionado);

      FProdutoSelecionado := lNovoProdutoSelecionado;
      TSalesSoftUtils.SetarFoco(edtQuantidade);
    end;

    SetarValoresCamposProduto();
  finally
    lPedidoVendaController.Free();
  end;
end;

procedure TFrmPedidoVenda.DesabilitarCamposProduto(pVisibilidade: Boolean);
begin
  edtCodigoProduto.Enabled := pVisibilidade;
  btnPesquisarProduto.Enabled := pVisibilidade;
  edtDescricaoProduto.Enabled := pVisibilidade;
  edtQuantidade.Enabled := pVisibilidade;
  edtValorUnitario.Enabled := pVisibilidade;
  btnAdicionarEditarItem.Enabled := pVisibilidade;
  grdItensPedido.Enabled := pVisibilidade;
  btnGravarPedido.Enabled := pVisibilidade;
end;

procedure TFrmPedidoVenda.btnVerPedidosClick(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
  lPedidoSelecionado: TPedidoModel;
begin
  btnVerPedidos.Down := True;
  lPedidoVendaController := TPedidoVendaController.Create();
  lPedidoSelecionado := lPedidoVendaController.ExibirERetornarSelecaoPedido();
  try
    if lPedidoSelecionado.Cliente.Codigo = -1 then
      begin
        if FClienteSelecionado.Codigo = -1 then
          btnNovoPedido.Down := True;
      end
    else
      begin
        lblPedidoTitulo.Visible := True;
        lblNumeroPedidoValor.Visible := True;
        lblEmitidoEm.Visible := True;
        lblDataEmissao.Visible := True;
        lblNumeroPedidoValor.Caption := IntToStr(lPedidoSelecionado.NumeroPedido);
        lblDataEmissao.Caption := FormatDateTime('dd/mm/yyyy', lPedidoSelecionado.DataEmissao);
        FClienteSelecionado.Codigo := lPedidoSelecionado.Cliente.Codigo;
        FClienteSelecionado.Nome := lPedidoSelecionado.Cliente.Nome;
        FClienteSelecionado.Cidade := lPedidoSelecionado.Cliente.Cidade;
        FClienteSelecionado.UF := lPedidoSelecionado.Cliente.UF;
        NovoPedido := False;
        SetarValoresCamposCliente();
        DesabilitarCamposProduto(False);
        PreencheGridItensDoPedido(lPedidoSelecionado.Itens);
     end;
  finally
    lPedidoVendaController.Free();
    lPedidoSelecionado.Free();
  end;
end;

procedure TFrmPedidoVenda.PreencheGridItensDoPedido(pItensDoPedido: TArray<TItemPedidoModel>);
var
  I: Integer;
begin
  cdsItensPedido.EmptyDataSet();
  for I := 0 to Length(pItensDoPedido) -1 do
  begin

    cdsItensPedido.Append();
    cdsItensPedidoCodigo.Value := pItensDoPedido[I].Produto.Codigo;
    cdsItensPedidoDescricao.AsString := pItensDoPedido[I].Produto.Descricao;
    cdsItensPedidoQuantidade.Value := pItensDoPedido[I].Quantidade;
    cdsItensPedidoValorUnitario.Value := pItensDoPedido[I].ValorUnitario;
    cdsItensPedidoValorTotal.Value := pItensDoPedido[I].ValorTotal;
    cdsItensPedido.Post();
  end;
  AtualizarPrecoTotal();
end;

procedure TFrmPedidoVenda.edtCodigoClienteExit(Sender: TObject);
const
  MENSAGEM = 'Ao remover o cliente, você está cancelando o lançamento deste pedido e todos os itens incluídos abaixo serão retirados da tabela.' + TSalesSoftUtils.CRLF
    + TSalesSoftUtils.CRLF + 'Deseja prosseguir?';
var
  lPedidoVendaController: TPedidoVendaController;
begin
  if ((FClienteSelecionado.Codigo = -1) and (edtCodigoCliente.Text = '')) then
    Exit;

  if ((FClienteSelecionado.Codigo <> -1) and (edtCodigoCliente.Text = '')) then
    begin
      if (MessageDlg(MENSAGEM, mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes) then
        LimparDadosDaTela()
      else
        edtCodigoCliente.Text := IntToStr(FClienteSelecionado.Codigo);
    end
  else
    begin
      lPedidoVendaController := TPedidoVendaController.Create();
      try
        FClienteSelecionado := lPedidoVendaController.PesquisaERetornaClientePorCodigo(FClienteSelecionado, StrToIntDef(edtCodigoCliente.Text, -1));
        SetarValoresCamposCliente();

        if (FClienteSelecionado.Codigo <> -1) then
          TSalesSoftUtils.SetarFoco(edtCodigoProduto)
        else
          TSalesSoftUtils.SetarFoco(edtCodigoCliente)
      finally
        lPedidoVendaController.Free();
      end;
    end;
end;

procedure TFrmPedidoVenda.LimparDadosDaTela();
begin
  FNovoPedido := True;
  FClienteSelecionado.ZerarModelo();
  FProdutoSelecionado.ZerarModelo();
  SetarValoresCamposCliente();
  SetarValoresCamposProduto();
  cdsItensPedido.EmptyDataSet();
  AtualizarPrecoTotal();

  TSalesSoftUtils.SetarFoco(edtCodigoCliente);
end;

procedure TFrmPedidoVenda.edtCodigoProdutoExit(Sender: TObject);
var
  lPedidoVendaController: TPedidoVendaController;
begin
  if ((FProdutoSelecionado.Codigo = -1) and (edtCodigoProduto.Text = '')) then
    Exit;

  if ((FProdutoSelecionado.Codigo <> -1) and (edtCodigoProduto.Text = '')) then
  begin
    FProdutoSelecionado.ZerarModelo();
    SetarValoresCamposProduto();
    Exit;
  end;

  lPedidoVendaController := TPedidoVendaController.Create();
  try
    if Assigned(FProdutoSelecionado) then
      FreeAndNil(FProdutoSelecionado);

    FProdutoSelecionado := lPedidoVendaController.PesquisaERetornaProdutoPorCodigo(StrToIntDef(edtCodigoProduto.Text, -1));
    SetarValoresCamposProduto();

    if (FProdutoSelecionado.Codigo <> -1) then
      TSalesSoftUtils.SetarFoco(edtQuantidade)
    else
      TSalesSoftUtils.SetarFoco(edtCodigoProduto)
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
  FNovoPedido := True;
  FItensInsercao := True;
  FClienteSelecionado := TClienteModel.Create();
  FProdutoSelecionado := TProdutoModel.Create();
  FClienteSelecionado.ZerarModelo();
  FProdutoSelecionado.ZerarModelo();

  SetarValoresCamposCliente();
end;

procedure TFrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FClienteSelecionado);
  FreeAndNil(FProdutoSelecionado);
end;

procedure TFrmPedidoVenda.FormResize(Sender: TObject);
begin
  if ClientWidth < 1000 Then
  begin
    ClientWidth := 1000;
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  end;

  if ClientHeight < 700 Then
  begin
    ClientHeight := 700;
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  end;
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
  MENSAGEM = 'Produto: %d - %s' + TSalesSoftUtils.CRLF + 'Quantidade: %d' + TSalesSoftUtils.CRLF + 'Valor Unitário: R$ %f' + TSalesSoftUtils.CRLF + 'Valor Total: R$ %f'
    + TSalesSoftUtils.CRLF + TSalesSoftUtils.CRLF + 'Você tem certeza que quer remover esse item do pedido?';
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
  AtualizarPrecoTotal();
end;

procedure TFrmPedidoVenda.grdItensPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #9 then
    btnGravarPedido.SetFocus;
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
  FProdutoSelecionado.ZerarModelo();

  SetarValoresCamposProduto();

  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';

  TSalesSoftUtils.SetarFoco(edtCodigoProduto);
end;

procedure TFrmPedidoVenda.SetNovoPedido(pValue: Boolean);
begin
  FNovoPedido := pValue;

  if FNovoPedido then
  begin
    btnNovoPedido.Down := True;
    DesabilitarCamposProduto(False);
  end;
end;

end.
