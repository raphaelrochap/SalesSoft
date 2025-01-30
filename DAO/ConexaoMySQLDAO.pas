unit ConexaoMySQLDAO;

interface

uses
  System.UITypes, FireDAC.Comp.Client, SysUtils, Dialogs, FireDac.Stan.Def, FireDAC.DApt, FireDAC.Comp.UI;

type
  TConexaoMySQLDAO = class
  private
    {$hints off}
    waitCursor: TFDGUIxWaitCursor;
    {$hints on}
  public
    FConexaoPrincipal: TFDConnection;

    function ConectarAoBancoDeDados(): Boolean;
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
