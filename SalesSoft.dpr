program SalesSoft;

uses
  Vcl.Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {FrmTelaPrincipal},
  PedidoVenda in 'View\PedidoVenda.pas' {FrmPedidoVenda},
  Selecao in 'View\Selecao.pas' {FrmSelecao},
  ConexaoMySQLDAO in 'DAO\ConexaoMySQLDAO.pas',
  ClienteModel in 'Model\ClienteModel.pas',
  ProdutoModel in 'Model\ProdutoModel.pas',
  PedidoModel in 'Model\PedidoModel.pas',
  ItemPedidoModel in 'Model\ItemPedidoModel.pas',
  SelecaoModel in 'Model\SelecaoModel.pas',
  ConexaoMySQLModel in 'Model\ConexaoMySQLModel.pas',
  BaseModel in 'Model\BaseModel.pas',
  ClienteController in 'Controller\ClienteController.pas',
  SelecaoController in 'Controller\SelecaoController.pas',
  PedidoVendaController in 'Controller\PedidoVendaController.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  TelaPrincipalController in 'Controller\TelaPrincipalController.pas',
  PedidoController in 'Controller\PedidoController.pas',
  ItemPedidoController in 'Controller\ItemPedidoController.pas',
  SalesSoftUtils in 'Classes\SalesSoftUtils.pas';

{$R *.res}

function ConectouAoBancoDeDados(): Boolean;
begin
  Result := TTelaPrincipalController.ConectarAoBancoDeDados();
end;

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SalesSoft';
  Application.CreateForm(TFrmTelaPrincipal, FrmTelaPrincipal);

  if ConectouAoBancoDeDados() then
    Application.Run
  else
    Application.Terminate;
end.
