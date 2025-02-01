unit ClienteModel;

interface

uses
  SysUtils, Dialogs, FireDAC.Comp.Client, ConexaoMySQLDAO, BaseModel;

type
  TClienteModel = class(TBaseModel)
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
   QUERY = 'SELECT CODIGO, NOME AS DESCRICAO FROM CLIENTES';
begin
  Result := Open(Query);
end;

end.
