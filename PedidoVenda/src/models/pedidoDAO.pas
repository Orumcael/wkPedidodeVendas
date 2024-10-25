unit pedidoDAO;

interface

uses db_connection, pedido, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TPedidoDAO = class
  Private
    FDBConnection: TDBConnection;
  public
    Constructor Create;
    function getLast(): TPedido;
    function getByNumeroPedido(numeroPedido: Integer): TPedido;
    function getAll(): TList<TPedido>;
    procedure addPedido(dataEmissao: TDateTime; codigoCliente: Integer;
      valorTotal: Currency);
    procedure deletePedido(numeroPedido: Integer);
    procedure updatePedido(numeroPedido: Integer; dataEmissao: TDateTime; codigoCliente: Integer;  valorTotal: Currency);
  end;

implementation

{ TPedidoDAO }

constructor TPedidoDAO.Create;
begin
  FDBConnection := TDBConnection.Create;
end;

function TPedidoDAO.getByNumeroPedido(numeroPedido: Integer): TPedido;
var qry: TFDQuery;
    connection: TFDConnection;
    pedido: TPedido;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pedido := TPedido.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM pedido_dados_gerais WHERE numeroPedido = ' + IntToStr(numeroPedido);
    qry.Open;
    if not qry.IsEmpty then
      begin
        pedido.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
        pedido.dataEmissao := qry.FieldByName('dataEmissao').AsDateTime;
        pedido.codigoCliente := qry.FieldByName('codigoCliente').AsInteger;
        pedido.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
      end
    else
      Writeln('Pedido não encontrado.');
    Result := pedido;
  finally
    qry.Free;

  end;
end;


function TPedidoDAO.getLast: TPedido;
var qry: TFDQuery;
    connection: TFDConnection;
    Pedido: TPedido;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  Pedido := TPedido.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM pedido_dados_gerais WHERE numeroPedido = (SELECT MAX(numeroPedido) FROM pedido_dados_gerais)';
    qry.Open;
    if not qry.IsEmpty then
      begin
        pedido.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
        pedido.dataEmissao := qry.FieldByName('dataEmissao').AsDateTime;
        pedido.codigoCliente := qry.FieldByName('codigoCliente').AsInteger;
        pedido.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
      end
    else
      Writeln('Pedido não encontrado.');
    Result := pedido;
  finally
    qry.Free;
  end;
end;


function TPedidoDAO.getAll: TList<TPedido>;
var qry: TFDQuery;
    connection: TFDConnection;
    pedido: TPedido;
    pedidos: TList<TPedido>;
    i: Integer;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pedidos := TList<TPedido>.Create;

  try
      qry.Connection := connection;
      qry.SQL.Text := 'SELECT * FROM pedido_dados_gerais';
      qry.Open;

       if not qry.IsEmpty then
        begin
          pedido := TPedido.Create;
          for i := 0 to qry.RecordCount do
            begin
              pedido.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
              pedido.dataEmissao := qry.FieldByName('dataEmissao').AsDateTime;
              pedido.codigoCliente := qry.FieldByName('codigoCliente').AsInteger;
              pedido.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
              pedidos.Add(pedido);
            end;
        end
      else
        Writeln('Nenhum pedido cadastrado.');

      Result := pedidos;
  finally
    qry.Free;

  end;
end;

procedure TPedidoDAO.addPedido(dataEmissao: TDateTime; codigoCliente: Integer; valorTotal: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'INSERT INTO pedido_dados_gerais (dataEmissao, codigoCliente, valorTotal) values ('+ QuotedStr(FormatDateTime('yyyy-mm-dd', dataEmissao)) + ', ' +IntToStr(codigoCliente)+ ', ' + StringReplace(CurrToStr(valorTotal), ',', '.', []) + ')';
      qry.Execute;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao inserir pedido.');
    end;
  finally
    qry.Free;
  end;
end;


procedure TPedidoDAO.updatePedido(numeroPedido: Integer; dataEmissao: TDateTime; codigoCliente: Integer;  valorTotal: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'UPDATE pedido_dados_gerais SET dataEmissao = '+ Datetostr(dataEmissao)+ ', codigoCliente =' +IntToStr(codigoCliente)+ ', valorTotal = ' +CurrToStr(valorTotal) +'  WHERE numeroPedido = ' + IntToStr(numeroPedido);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao editar pedido.');
    end;
  finally
    qry.Free;
  end;
end;

procedure TPedidoDAO.deletePedido(numeroPedido: Integer);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'DELETE FROM pedido_dados_gerais WHERE numeroPedido = ' + IntToStr(numeroPedido);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao deletar pedido.');
    end;
  finally
    qry.Free;
  end;
end;

end.
