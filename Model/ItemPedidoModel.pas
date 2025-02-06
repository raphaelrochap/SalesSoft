unit ItemPedidoModel;

interface

uses
  SysUtils, FireDAC.Comp.Client, ConexaoMySQLDAO, BaseModel, ProdutoModel;

type
  TItemPedidoModel = class(TBaseModel)
  private
    FId: Integer;
    FNumeroPedido: Integer;
    FProduto: TProdutoModel;
    FQuantidade: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;
  public
    property Id: Integer read FId write FId;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property Produto: TProdutoModel read FProduto write FProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;

    class function GetById(pNumeroPedido: Integer): TArray<TItemPedidoModel>;

    function Remover(): Boolean;
    function Salvar(): Boolean;
    constructor Create();
    destructor Destroy; override;

  end;

implementation

constructor TItemPedidoModel.Create();
begin
  FProduto := TProdutoModel.Create();
end;

destructor TItemPedidoModel.Destroy();
begin
  FProduto.Free();
end;

function TItemPedidoModel.Salvar(): Boolean;
const
  CONSULTA = 'INSERT INTO PEDIDOITENS' +
             '   (NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) ' +
             ' VALUES ' +
             '   (%d, %d, %d, %s, %s);';
begin
  Result := ExecSQL(Format(CONSULTA,
    [
      Self.NumeroPedido,
      Self.Produto.Codigo,
      Self.Quantidade,
      StringReplace(FloatToStr(Self.ValorUnitario), ',', '.', [rfReplaceAll]),
      StringReplace(FloatToStr(Self.ValorTotal), ',', '.', [rfReplaceAll])
    ]), 'Erro ao inserir Item do Pedido.');
end;

class function TItemPedidoModel.GetById(pNumeroPedido: Integer): TArray<TItemPedidoModel>;
const
   QUERY = 'SELECT ' +
           '  PEDIDOITENS.ID, ' +
           '  PEDIDOITENS.NUMERO_PEDIDO, ' +
           '  PEDIDOITENS.CODIGO_PRODUTO, ' +
           '  PRODUTOS.DESCRICAO AS DESCRICAO_PRODUTO, ' +
           '  PRODUTOS.PRECO_VENDA, ' +
           '  PEDIDOITENS.QUANTIDADE, ' +
           '  PEDIDOITENS.VALOR_UNITARIO, ' +
           '  PEDIDOITENS.VALOR_TOTAL ' +
           'FROM ' +
           '  PEDIDOITENS ' +
           'INNER JOIN ' +
           '  PRODUTOS ON PRODUTOS.CODIGO = PEDIDOITENS.CODIGO_PRODUTO ' +
           'WHERE ' +
           '  NUMERO_PEDIDO = %d ';
var
  lQueryPedido: TFDQuery;
  lIndex: Integer;
begin
  lIndex := 0;
  SetLength(Result, lIndex);
  lQueryPedido := Open(Format(QUERY, [pNumeroPedido]), 'Erro ao obter os Itens do Pedido de Código: ' + IntToStr(pNumeroPedido) + '.');
  try
    lQueryPedido.First();
    while not lQueryPedido.Eof do
    begin
      lIndex := Length(Result);
      SetLength(Result, lIndex + 1);
      Result[lIndex] := TItemPedidoModel.Create();

      Result[lIndex].Id := lQueryPedido.Fields.FieldByName('ID').AsInteger;
      Result[lIndex].NumeroPedido := lQueryPedido.Fields.FieldByName('NUMERO_PEDIDO').AsInteger;
      Result[lIndex].Produto.Codigo := lQueryPedido.Fields.FieldByName('CODIGO_PRODUTO').AsInteger;
      Result[lIndex].Produto.Descricao := lQueryPedido.Fields.FieldByName('DESCRICAO_PRODUTO').AsString;
      Result[lIndex].Produto.PrecoVenda := lQueryPedido.Fields.FieldByName('PRECO_VENDA').AsInteger;
      Result[lIndex].Quantidade := lQueryPedido.Fields.FieldByName('QUANTIDADE').AsInteger;
      Result[lIndex].ValorUnitario := lQueryPedido.Fields.FieldByName('VALOR_UNITARIO').AsFloat;
      Result[lIndex].ValorTotal := lQueryPedido.Fields.FieldByName('VALOR_TOTAL').AsFloat;

      lQueryPedido.Next();
    end;
  finally
    lQueryPedido.Free();
  end;
end;

function TItemPedidoModel.Remover(): Boolean;
const
  CONSULTA = 'DELETE FROM PEDIDOITENS WHERE ID = %d';
begin
  Result := ExecSQL(Format(CONSULTA, [Self.FId]), 'Erro ao remover Item do Pedido. ID: ' + IntToStr(Self.FId) + '.');
end;

end.
