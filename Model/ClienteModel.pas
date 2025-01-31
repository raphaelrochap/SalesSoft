unit ClienteModel;

interface

uses
  SysUtils, Dialogs, FireDAC.Comp.Client, ConexaoMySQLDAO;

type
  TClienteModel = class
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;

    class function GetAll(): TFDQuery;
  end;

implementation

class function TClienteModel.GetAll(): TFDQuery;
const
   QUERY = 'SELECT CODIGO, NOME FROM CLIENTES';
begin
  Result := TFDQuery.Create(nil);
  try
    try
      FConexaoMySQLDAO.StartTransaction();
      Result.Connection := FConexaoMySQLDAO.FConexaoPrincipal;
      Result.SQL.Add(QUERY);
      Result.Open();
    except
      on E: Exception do
      begin
        FConexaoMySQLDAO.Rollback();
        ShowMessage('Erro: ' + E.Message);
      end;
    end;
  finally
    FConexaoMySQLDAO.Commit();
  end;
end;

end.
