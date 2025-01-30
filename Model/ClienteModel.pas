unit ClienteModel;

interface

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
  end;

implementation

end.
