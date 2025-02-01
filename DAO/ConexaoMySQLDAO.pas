unit ConexaoMySQLDAO;

interface

uses
  System.UITypes, FireDAC.Comp.Client, SysUtils, Vcl.Dialogs, FireDac.Stan.Def, FireDAC.DApt, FireDAC.Comp.UI, SalesSoftUtils, ConexaoMySQLModel, FireDAC.Phys.MySQL;

type
  TConexaoMySQLDAO = class
  private
    {$hints off}
    FFDGUIxWaitCursor: TFDGUIxWaitCursor;
    {$hints on}
  public
    FConexaoPrincipal: TFDConnection;
    FFDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;

    function ConectarAoBancoDeDados(pModeloConexao: TConexaoMySQLModel): Boolean;
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback(pMessage: String = '');
    class function GetInstance(): TConexaoMySQLDAO;
    constructor Create();
  end;

var
  FConexaoMySQLDAO: TConexaoMySQLDAO;

implementation

constructor TConexaoMySQLDAO.Create();
begin
  FFDPhysMySQLDriverLink := TFDPhysMySQLDriverLink.Create(nil);
  FFDGUIxWaitCursor := TFDGUIxWaitCursor.Create(nil);
end;

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
    pMessage := 'Houve um problema com sua �ltima transa��o de dados, por favor verifique sua conex�o com o Banco de Dados e tente novamente';

  FConexaoPrincipal.Rollback();
  MessageDlg(pMessage, mtInformation, [mbOk], 0);
end;

function TConexaoMySQLDAO.ConectarAoBancoDeDados(pModeloConexao: TConexaoMySQLModel): Boolean;
begin
  Result := False;

  try
    FConexaoPrincipal := TFDConnection.Create(nil);

    FConexaoPrincipal.DriverName := 'MySQL';
    FConexaoPrincipal.Params.Database := pModeloConexao.Database;
    FConexaoPrincipal.Params.UserName := pModeloConexao.Username;
    FConexaoPrincipal.Params.Password := pModeloConexao.Password;
    FConexaoPrincipal.Params.AddPair('Server', pModeloConexao.Server);
    FConexaoPrincipal.Params.AddPair('Port', pModeloConexao.Port);
    FFDPhysMySQLDriverLink.VendorLib := pModeloConexao.CaminhoLib;

    FConexaoPrincipal.Connected := True;

    Result := FConexaoPrincipal.Connected;
  except
    on E: Exception do
    begin
      MessageDlg('N�o foi poss�vel realizar a conex�o com a base de Dados:' + TSalesSoftUtils.CRLF + TSalesSoftUtils.CRLF + 'Detalhes:' + E.Message, mtInformation, [mbOK], 0);
    end;
  end;
end;

initialization
  FConexaoMySQLDAO := TConexaoMySQLDAO.GetInstance();

finalization
  if Assigned(FConexaoMySQLDAO) then
    FreeAndNil(FConexaoMySQLDAO);
end.
