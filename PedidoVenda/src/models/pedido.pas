unit pedido;

interface

type
  TPedido = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FClienteCodigo: Integer;
    FValorTotal: Currency;
  public
    property numeroPedido: Integer read FNumero write FNumero;
    property dataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property codigoCliente: Integer read FClienteCodigo write FClienteCodigo;
    property valorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
