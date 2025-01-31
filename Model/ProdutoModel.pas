unit ProdutoModel;

interface

uses
  SysUtils, Dialogs, FireDAC.Comp.Client, ConexaoMySQLDAO;

type
  TProdutoModel = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Double;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;

    class function GetAll(): TFDQuery;
  end;

implementation

class function TProdutoModel.GetAll(): TFDQuery;
const
   QUERY = 'SELECT CODIGO, DESCRICAO FROM PRODUTOS';
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
