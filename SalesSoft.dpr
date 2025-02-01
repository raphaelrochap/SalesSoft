program SalesSoft;

uses
  Vcl.Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {FrmTelaPrincipal},
  ConexaoMySQLDAO in 'DAO\ConexaoMySQLDAO.pas',
  ClienteModel in 'Model\ClienteModel.pas',
  ProdutoModel in 'Model\ProdutoModel.pas',
  PedidoModel in 'Model\PedidoModel.pas',
  ItemPedidoModel in 'Model\ItemPedidoModel.pas',
  PedidoVenda in 'View\PedidoVenda.pas' {FrmPedidoVenda},
  Selecao in 'View\Selecao.pas' {FrmSelecao},
  ClienteController in 'Controller\ClienteController.pas',
  SalesSoftUtils in 'Classes\SalesSoftUtils.pas',
  SelecaoModel in 'Model\SelecaoModel.pas',
  SelecaoController in 'Controller\SelecaoController.pas',
  PedidoVendaController in 'Controller\PedidoVendaController.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  TelaPrincipalController in 'Controller\TelaPrincipalController.pas',
  ConexaoMySQLModel in 'Model\ConexaoMySQLModel.pas',
  BaseModel in 'Model\BaseModel.pas',
  PedidoController in 'Controller\PedidoController.pas',
  ItemPedidoController in 'Controller\ItemPedidoController.pas';

{$R *.res}

function ConectouAoBancoDeDados(): Boolean;
begin
  Result := TTelaPrincipalController.ConectarAoBancoDeDados();
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SalesSoft';
  Application.CreateForm(TFrmTelaPrincipal, FrmTelaPrincipal);
  if ConectouAoBancoDeDados() then
    Application.Run
  else
    Application.Terminate;
end.
