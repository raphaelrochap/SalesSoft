unit ConexaoMySQLDAO;

interface

uses
  System.UITypes, FireDAC.Comp.Client, SysUtils, Vcl.Dialogs, FireDac.Stan.Def, FireDAC.DApt, FireDAC.Comp.UI;

type
  TConexaoMySQLDAO = class
  private
    {$hints off}
    waitCursor: TFDGUIxWaitCursor;
    {$hints on}
  public
    FConexaoPrincipal: TFDConnection;

    function ConectarAoBancoDeDados(): Boolean;
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback(pMessage: String = '');
    class function GetInstance(): TConexaoMySQLDAO;
  end;

var
  FConexaoMySQLDAO: TConexaoMySQLDAO;

implementation

class function TConexaoMySQLDAO.GetInstance(): TConexaoMySQLDAO;
begin
  if not Assigned(FConexaoMySQLDAO) then
    FConexaoMySQLDAO := TConexaoMySQLDAO.Create();

  Result := FConexaoMySQLDAO;
end;

procedure TConexaoMySQLDAO.StartTransaction();
begin
  FConexaoPrincipal.StartTransaction();
end;

procedure TConexaoMySQLDAO.Commit();
begin
  FConexaoPrincipal.Commit();
end;

procedure TConexaoMySQLDAO.Rollback(pMessage: String = '');
begin
  if pMessage = '' then
    pMessage := 'Houve um problema com sua última transação de dados, por favor verifique sua conexão com o Banco de Dados e tente novamente';

  FConexaoPrincipal.Rollback();
  MessageDlg(pMessage, mtInformation, [mbOk], 0);
end;

function TConexaoMySQLDAO.ConectarAoBancoDeDados(): Boolean;
begin
  Result := False;

  try
    FConexaoPrincipal := TFDConnection.Create(nil);

    FConexaoPrincipal.DriverName := 'MySQL';
    FConexaoPrincipal.Params.Database := 'salessoft';
    FConexaoPrincipal.Params.UserName := 'root';
    FConexaoPrincipal.Params.Password := 'root';

    FConexaoPrincipal.Connected := True;

    Result := FConexaoPrincipal.Connected;
  except
    on E: Exception do
    begin
      MessageDlg('Não foi possível realizar a conexão com a base de Dados:' + #10#13 + #10#13 + 'Detalhes:' + E.Message, mtInformation, [mbOK], 0);
    end;
  end;
end;

initialization
  FConexaoMySQLDAO := TConexaoMySQLDAO.GetInstance();

finalization
  if Assigned(FConexaoMySQLDAO) then
    FreeAndNil(FConexaoMySQLDAO);
end.
