unit pedido_produto_controller;

interface

uses pedido_produto, pedido_produtoDAO, System.Generics.Collections;

type
  TPedidoProdutoController = class
  Private
    pedidoProdutoDAO: TPedidoProdutoDAO;
  Public
    Constructor Create;
    function findAllPedidoProduto(): TList<TPedidoProduto>;
    function findPedidoProduto(codigo: Integer): TPedidoProduto;
    function findPedidoProdutoNumeroPedido(codigo: Integer): TList<TPedidoProduto>;
    function addPedidoProduto(numeroPedido, codigoProduto, quantidade: Integer;
      valorUnitario, valorTotal: Currency): TPedidoProduto;
    function editPedidoProduto(codigo, numeroPedido, codigoProduto,
      quantidade: Integer; valorUnitario, valorTotal: Currency): TPedidoProduto;
    procedure removePedidoProduto(codigo: Integer);
  end;

implementation

{ TClienteController }

constructor TPedidoProdutoController.Create;
begin
  pedidoProdutoDAO := TPedidoProdutoDAO.Create;
end;

function TPedidoProdutoController.findAllPedidoProduto: TList<TPedidoProduto>;
var PedidoProdutos: TList<TPedidoProduto>;
begin
  PedidoProdutos := pedidoProdutoDAO.getAll();
  Result := PedidoProdutos;
end;

function TPedidoProdutoController.findPedidoProdutoNumeroPedido(
  codigo: Integer): TList<TPedidoProduto>;
var pedidoProdutos: TList<TPedidoProduto>;
begin
  pedidoProdutos := pedidoProdutoDAO.getByNumeroPedido(codigo);
  Result := pedidoProdutos;
end;

function TPedidoProdutoController.findPedidoProduto(codigo: Integer): TPedidoProduto;
var PedidoProduto: TPedidoProduto;
begin
  PedidoProduto := PedidoProdutoDAO.getByCodigo(codigo);
  Result := PedidoProduto;
end;

function TPedidoProdutoController.addPedidoProduto(numeroPedido: Integer; codigoProduto: Integer; quantidade: Integer; valorUnitario: Currency; valorTotal: Currency): TPedidoProduto;
var PedidoProduto: TPedidoProduto;
begin
  PedidoProdutoDAO.addPedido_Produto(numeroPedido, codigoProduto, quantidade, valorUnitario, valorTotal);
  PedidoProduto := PedidoProdutoDAO.getLast();
  Result := PedidoProduto;
end;

function TPedidoProdutoController.editPedidoProduto(codigo: Integer; numeroPedido: Integer; codigoProduto: Integer; quantidade: Integer; valorUnitario: Currency; valorTotal: Currency): TPedidoProduto;
var PedidoProduto: TPedidoProduto;
begin
  PedidoProdutoDAO.updatePedido_Produto(codigo, numeroPedido, codigoProduto, quantidade, valorUnitario, valorTotal);
  PedidoProduto := PedidoProdutoDAO.getByCodigo(codigo);
  Result := PedidoProduto;
end;

procedure TPedidoProdutoController.removePedidoProduto(codigo: Integer);
begin
  PedidoProdutoDAO.deletePedido_Produto(codigo);
end;

end.
