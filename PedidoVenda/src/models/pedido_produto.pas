unit pedido_produto;

interface

type
  TPedidoProduto = class
  private
    FCodigo: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
  public
    property codigo: Integer read FCodigo write FCodigo;
    property numeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property codigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
