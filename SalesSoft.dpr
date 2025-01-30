program SalesSoft;

uses
  Vcl.Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {FrmTelaPrincipal},
  ConexaoMySQLDAO in 'DAO\ConexaoMySQLDAO.pas',
  ClienteModel in 'Model\ClienteModel.pas',
  ProdutoModel in 'Model\ProdutoModel.pas',
  PedidoModel in 'Model\PedidoModel.pas',
  ItemPedidoModel in 'Model\ItemPedidoModel.pas',
  PedidoVenda in 'View\PedidoVenda.pas' {FrmPedidoVenda};

{$R *.res}

function ConectouAoBancoDeDados(): Boolean;
begin
  Result := FConexaoMySQLDAO.ConectarAoBancoDeDados();
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
