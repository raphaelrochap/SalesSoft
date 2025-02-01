unit TelaPrincipalController;

interface

uses
  SysUtils, Dialogs, ConexaoMySQLDAO, IniFiles, ConexaoMySQLModel;

type
  TTelaPrincipalController = class
  private
  public
    const SECTION = 'BancoDeDados';

    class procedure VerificaECriaArquivoINI();
    class procedure CriarArquivoINI();
    class function ConectarAoBancoDeDados(): Boolean;
  end;

implementation

class procedure TTelaPrincipalController.CriarArquivoINI();
var
  lArquivoINI: TIniFile;
begin
  lArquivoINI := TIniFile.Create('.\SalesSoft.ini');
  try
    lArquivoINI.WriteString(SECTION, 'Database', 'salessoft');
    lArquivoINI.WriteString(SECTION, 'Username', 'root');
    lArquivoINI.WriteString(SECTION, 'Server', 'localhost');
    lArquivoINI.WriteString(SECTION, 'Port', '3306');
    lArquivoINI.WriteString(SECTION, 'Password', 'root');
    lArquivoINI.WriteString(SECTION, 'CaminhoLib', 'C:\LIBMYSQL.DLL');
  finally
    lArquivoINI.Free;
  end;
end;

class procedure TTelaPrincipalController.VerificaECriaArquivoINI();
begin
  if not FileExists('.\SalesSoft.ini') then
    CriarArquivoINI();
end;

class function TTelaPrincipalController.ConectarAoBancoDeDados(): Boolean;
var
  lArquivoINI: TIniFile;
  lModeloConexao: TConexaoMySQLModel;
begin
  VerificaECriaArquivoINI();
  lArquivoINI := TIniFile.Create('.\SalesSoft.ini');
  try
    lModeloConexao.Database := lArquivoINI.ReadString(SECTION, 'Database', '');
    lModeloConexao.Username := lArquivoINI.ReadString(SECTION, 'Username', '');
    lModeloConexao.Server := lArquivoINI.ReadString(SECTION, 'Server', '');
    lModeloConexao.Port := lArquivoINI.ReadString(SECTION, 'Port', '');
    lModeloConexao.Password := lArquivoINI.ReadString(SECTION, 'Password', '');
    lModeloConexao.CaminhoLib := lArquivoINI.ReadString(SECTION, 'CaminhoLib', '');

    VerificaECriaArquivoINI();
    Result := FConexaoMySQLDAO.ConectarAoBancoDeDados(lModeloConexao);
  finally
    lArquivoINI.Free();
  end;
end;

end.
