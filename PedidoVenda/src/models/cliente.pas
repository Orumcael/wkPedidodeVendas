unit cliente;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FCidade: string;
    FUF: string;
  public
    property codigo: Integer read FCodigo write FCodigo;
    property nome: string read FNome write FNome;
    property cidade: string read FCidade write FCidade;
    property uf: string read FUF write FUF;
  end;

implementation

end.
