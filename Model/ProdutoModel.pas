unit ProdutoModel;

interface

uses
  SysUtils, Dialogs, FireDAC.Comp.Client, ConexaoMySQLDAO, BaseModel;

type
  TProdutoModel = class(TBaseModel)
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Double;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;

    class function GetAll(): TFDQuery;
    class function GetById(pCodigo: Integer): TProdutoModel;

    procedure ZerarModelo();
  end;

implementation

procedure TProdutoModel.ZerarModelo();
begin
  Self.Codigo := -1;
  Self.Descricao := '';
  Self.PrecoVenda := 0;
end;

class function TProdutoModel.GetAll(): TFDQuery;
const
   QUERY = 'SELECT CODIGO as ''Código'', DESCRICAO as ''Descrição'' FROM PRODUTOS';
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
        MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    FConexaoMySQLDAO.Commit();
  end;
end;

class function TProdutoModel.GetById(pCodigo: Integer): TProdutoModel;
const
   QUERY = 'SELECT CODIGO, DESCRICAO, PRECO_VENDA FROM PRODUTOS WHERE CODIGO = %d';
var
  lQuery: TFDQuery;
begin
  lQuery := Open(Format(QUERY, [pCodigo]));
  try
    Result := TProdutoModel.Create();
    Result.Codigo := lQuery.Fields.FieldByName('CODIGO').AsInteger;
    Result.Descricao := lQuery.Fields.FieldByName('DESCRICAO').AsString;
    Result.PrecoVenda := lQuery.Fields.FieldByName('PRECO_VENDA').AsFloat;
  finally
    lQuery.Free();
  end;
end;

end.
