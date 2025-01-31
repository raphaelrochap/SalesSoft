unit SelecaoModel;

interface

type
  TSelecaoModel = record
    Codigo: Integer;
    Nome: String;
    Descricao: String;

    class function ModeloZerado(): TSelecaoModel; static;
  end;

implementation

class function TSelecaoModel.ModeloZerado(): TSelecaoModel;
begin
  Result.Codigo := -1;
  Result.Nome := '';
  Result.Descricao := '';
end;

end.
