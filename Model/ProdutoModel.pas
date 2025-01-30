unit ProdutoModel;

interface

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
  end;

implementation

end.
