unit produto;

interface

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FPrecoVenda: Currency;
  public
    property codigo: Integer read FCodigo write FCodigo;
    property descricao: string read FDescricao write FDescricao;
    property precoVenda: Currency read FPrecoVenda write FPrecoVenda;
  end;

implementation

end.
