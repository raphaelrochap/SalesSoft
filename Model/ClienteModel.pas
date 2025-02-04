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
    class function GetById(pCodigo: Integer): TClienteModel;
    procedure ZerarModelo();
  end;

implementation

procedure TClienteModel.ZerarModelo();
begin
  Self.FCodigo := -1;
  Self.FNome := '';
  Self.FCidade := '';
  Self.FUF := '';
end;

class function TClienteModel.GetAll(): TFDQuery;
const
   QUERY = 'SELECT CODIGO AS ''Código'', NOME AS ''Nome'' FROM CLIENTES';
begin
  Result := Open(QUERY);
end;

class function TClienteModel.GetById(pCodigo: Integer): TClienteModel;
const
   QUERY = 'SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTES WHERE CODIGO = %d';
var
  lQuery: TFDQuery;
begin
  lQuery := Open(Format(QUERY, [pCodigo]));
  try
    Result := TClienteModel.Create();
    Result.Codigo := lQuery.Fields.FieldByName('CODIGO').AsInteger;
    Result.Nome := lQuery.Fields.FieldByName('NOME').AsString;
    Result.Cidade := lQuery.Fields.FieldByName('CIDADE').AsString;
    Result.UF := lQuery.Fields.FieldByName('UF').AsString;
  finally
    lQuery.Free();
  end;
end;

end.
