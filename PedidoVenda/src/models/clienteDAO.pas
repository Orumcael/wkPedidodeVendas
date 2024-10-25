unit clienteDAO;

interface

uses db_connection, cliente, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TClienteDAO = class
  Private
    FDBConnection: TDBConnection;
  public
    Constructor Create;
    function getByCodigo(codigo: Integer): TCliente;
    function getLast(): TCliente;
    function getAll(): TList<TCliente>;
    procedure addCliente(nome: string; cidade: string; uf: String);
    procedure updateCliente(codigo: Integer; nome: string; cidade: string; uf: String);
    procedure deleteCliente(codigo: Integer);
  end;

implementation

{ TClienteDAO }

constructor TClienteDAO.Create;
begin
  FDBConnection := TDBConnection.Create;
end;

function TClienteDAO.getByCodigo(codigo: Integer): TCliente;
var qry: TFDQuery;
    connection: TFDConnection;
    cliente: TCliente;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  cliente := TCliente.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM cliente WHERE codigo = ' + IntToStr(codigo);
    qry.Open;
    qry.First;

    if not qry.IsEmpty then
      begin
        cliente.codigo := qry.FieldByName('codigo').AsInteger;
        cliente.nome := qry.FieldByName('nome').AsString;
        cliente.cidade := qry.FieldByName('cidade').AsString;
        cliente.uf := qry.FieldByName('uf').AsString;
      end
    else
      Writeln('Cliente não encontrado.');

    Result := cliente;
  finally
    qry.Free;
  end;
end;

function TClienteDAO.getLast: TCliente;
var qry: TFDQuery;
    connection: TFDConnection;
    cliente: TCliente;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  cliente := TCliente.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM cliente WHERE codigo = (SELECT MAX(codigo) FROM cliente)';
    qry.Open;
    if not qry.IsEmpty then
      begin
        cliente.codigo := qry.FieldByName('codigo').AsInteger;
        cliente.nome := qry.FieldByName('nome').AsString;
        cliente.cidade := qry.FieldByName('cidade').AsString;
        cliente.uf := qry.FieldByName('uf').AsString;
      end
    else
      Writeln('Cliente não encontrado.');
    Result := cliente;
  finally
    qry.Free;
  end;

end;

function TClienteDAO.getAll: TList<TCliente>;
var qry: TFDQuery;
    connection: TFDConnection;
    cliente: TCliente;
    clientes: TList<TCliente>;
    i: Integer;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  clientes := TList<TCliente>.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM cliente';
    qry.Open;
    qry.First;

     if not qry.IsEmpty then
      begin
        while not qry.Eof do
          begin
            cliente := TCliente.Create;

            cliente.codigo := qry.FieldByName('codigo').AsInteger;
            cliente.nome := qry.FieldByName('nome').AsString;
            cliente.cidade := qry.FieldByName('cidade').AsString;
            cliente.uf := qry.FieldByName('uf').AsString;

            clientes.Add(cliente);
            qry.Next;
          end;
      end
    else
      Writeln('Nenhum cliente cadastrado.');

    Result := clientes;
  finally
    qry.Free;
  end;
end;

procedure TClienteDAO.addCliente(nome, cidade, uf: String);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'INSERT INTO cliente (nome, cidade, uf) values (' + nome + ', ' + cidade +', ' + uf +')';
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao inserir cliente.');
    end;
  finally
    qry.Free;
  end;
end;

procedure TClienteDAO.updateCliente(codigo: Integer; nome, cidade, uf: String);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'UPDATE cliente SET nome = ' + nome + ', cidade = ' + cidade +', uf = ' + uf +' WHERE codigo = ' + IntToStr(codigo);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao editar cliente.');
    end;
  finally
    qry.Free;
  end;
end;

procedure TClienteDAO.deleteCliente(codigo: Integer);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'DELETE FROM cliente WHERE codigo = ' + IntToStr(codigo);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao deletar cliente.');
    end;
  finally
    qry.Free;
  end;
end;

end.
