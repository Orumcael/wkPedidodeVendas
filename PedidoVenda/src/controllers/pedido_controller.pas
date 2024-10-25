unit pedido_controller;

interface

uses pedido, pedidoDAO, System.Generics.Collections;

type
  TPedidoController = class
  Private
    pedidoDAO: TPedidoDAO;
  Public
    Constructor Create;
    function findAllPedido(): TList<TPedido>;
    function findPedido(numeroPedido: Integer): TPedido;
    function addPedido(dataEmissao: TDateTime; codigoCliente: Integer; valorTotal: Currency): TPedido;
    function editPedido(numeroPedido: Integer; dataEmissao: TDateTime; codigoCliente: Integer;  valorTotal: Currency): TPedido;
    procedure removePedido(numeroPedido: Integer);
  end;

implementation

{ TClienteController }

constructor TPedidoController.Create;
begin
  pedidoDAO := TPedidoDAO.Create;
end;

function TPedidoController.findAllPedido: TList<TPedido>;
var Pedidos: TList<TPedido>;
begin
  Pedidos := PedidoDAO.getAll();
  Result := Pedidos;
end;

function TPedidoController.findPedido(numeroPedido: Integer): TPedido;
var Pedido: TPedido;
begin
  Pedido := PedidoDAO.getBynumeroPedido(numeroPedido);
  Result := Pedido;
end;

function TPedidoController.addPedido(dataEmissao: TDateTime; codigoCliente: Integer; valorTotal: Currency): TPedido;
var Pedido: TPedido;
begin
  PedidoDAO.addPedido(dataEmissao, codigoCliente, valorTotal);
  Pedido := PedidoDAO.getLast();
  Result := Pedido;
end;

function TPedidoController.editPedido(numeroPedido: Integer; dataEmissao: TDateTime; codigoCliente: Integer;  valorTotal: Currency): TPedido;
var Pedido: TPedido;
begin
  PedidoDAO.updatePedido(numeroPedido, dataEmissao, codigoCliente, valorTotal);
  Pedido := PedidoDAO.getByNumeroPedido(numeroPedido);
  Result := Pedido;
end;

procedure TPedidoController.removePedido(numeroPedido: Integer);
begin
  PedidoDAO.deletePedido(numeroPedido);
end;

end.
