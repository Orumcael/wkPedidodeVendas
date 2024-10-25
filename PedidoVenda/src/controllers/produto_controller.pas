unit produto_controller;

interface

uses produto, produtoDAO, System.Generics.Collections;

type
  TProdutoController = class
  Private
    produtoDAO: TProdutoDAO;
  Public
    Constructor Create;
    function findAllProduto(): TList<TProduto>;
    function findProduto(codigo: Integer): TProduto;
    function addProduto(descricao: String; precoVenda: Currency): TProduto;
    function editProduto(codigo: Integer; descricao: String;
      precoVenda: Currency): TProduto;
    procedure removeProduto(codigo: Integer);
  end;

implementation

{ TClienteController }

constructor TProdutoController.Create;
begin
  produtoDAO := TProdutoDAO.Create;
end;

function TProdutoController.findAllProduto: TList<TProduto>;
var Produtos: TList<TProduto>;
begin
  Produtos := produtoDAO.getAll();
  Result := Produtos;
end;

function TProdutoController.findProduto(codigo: Integer): TProduto;
var Produto: TProduto;
begin
  Produto := ProdutoDAO.getByCodigo(codigo);
  Result := Produto;
end;

function TProdutoController.addProduto(descricao: String; precoVenda: Currency): TProduto;
var Produto: TProduto;
begin
  ProdutoDAO.addProduto(descricao, precoVenda);
  Produto := ProdutoDAO.getLast();
  Result := Produto;
end;

function TProdutoController.editProduto(codigo: Integer; descricao: String;
      precoVenda: Currency): TProduto;
var Produto: TProduto;
begin
  ProdutoDAO.updateProduto(codigo, descricao,precoVenda);
  Produto := ProdutoDAO.getByCodigo(codigo);
  Result := Produto;
end;

procedure TProdutoController.removeProduto(codigo: Integer);
begin
  ProdutoDAO.deleteProduto(codigo);
end;

end.
