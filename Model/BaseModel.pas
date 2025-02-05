unit BaseModel;

interface

uses
  SysUtils, Dialogs, FireDAC.Comp.Client, ConexaoMySQLDAO, UITypes;

type
  TBaseModel = class
  public
    class function Open(pQuery: String; pMensagemErro: String): TFDQuery;
    class function ExecSQL(pQuery: String; pMensagemErro: String): Boolean;
  end;

implementation

class function TBaseModel.Open(pQuery: String; pMensagemErro: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := FConexaoMySQLDAO.FConexaoPrincipal;
    Result.SQL.Text := pQuery;
    Result.Open();
  except
    on E: Exception do
    begin
      FConexaoMySQLDAO.Rollback(True, pMensagemErro);
      MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

class function TBaseModel.ExecSQL(pQuery: String; pMensagemErro: String): Boolean;
var
  lQuery: TFDQuery;
begin
  Result := False;
  lQuery := TFDQuery.Create(nil);
  try
    try
      lQuery.Connection := FConexaoMySQLDAO.FConexaoPrincipal;
      lQuery.SQL.Text := pQuery;
      lQuery.ExecSQL();
      Result := (lQuery.RowsAffected = 1);
    except on E: Exception do
        FConexaoMySQLDAO.Rollback(True, pMensagemErro);
    end;
  finally
    lQuery.Free();
  end;
end;

end.
