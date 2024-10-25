unit cliente_controller;

interface

uses cliente, clienteDAO, System.Generics.Collections;

type
  TClienteController = class
  Private
    clienteDAO: TClienteDAO;
  Public
    Constructor Create;
    function findAllCliente(): TList<TCliente>;
    function findCliente(codigo: Integer): TCliente;
    function addCliente(nome: string; cidade: string; uf: String): TCliente;
    function editCliente(codigo: Integer; nome: string; cidade: string; uf: String): TCliente;
    procedure removeCliente(codigo: Integer);
  end;

implementation

{ TClienteController }

constructor TClienteController.Create;
begin
  clienteDAO := TClienteDAO.Create;
end;

function TClienteController.findAllCliente: TList<TCliente>;
var clientes: TList<TCliente>;
begin
  clientes := clienteDAO.getAll();
  Result := clientes;
end;

function TClienteController.findCliente(codigo: Integer): TCliente;
var cliente: TCliente;
begin
  cliente := clienteDAO.getByCodigo(codigo);
  Result := cliente;
end;

function TClienteController.addCliente(nome, cidade, uf: String): TCliente;
var cliente: TCliente;
begin
  clienteDAO.addCliente(nome, cidade, uf);
  cliente := clienteDAO.getLast();
  Result := cliente;
end;

function TClienteController.editCliente(codigo: Integer; nome, cidade, uf: String): TCliente;
var cliente: TCliente;
begin
  clienteDAO.updateCliente(codigo, nome, cidade, uf);
  cliente := clienteDAO.getByCodigo(codigo);
  Result := cliente;
end;

procedure TClienteController.removeCliente(codigo: Integer);
begin
  clienteDAO.deleteCliente(codigo);
end;

end.
