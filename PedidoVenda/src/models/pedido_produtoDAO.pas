unit pedido_produtoDAO;

interface

uses db_connection, pedido_produto, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TPedidoProdutoDAO = class
  Private
    FDBConnection: TDBConnection;
  public
    Constructor Create;
    function getByCodigo(codigo: Integer): TPedidoProduto;
    function getByNumeroPedido(codigo: Integer): TList<TPedidoProduto>;
    function getAll(): TList<TPedidoProduto>;
    procedure addPedido_Produto(numeroPedido, codigoProduto,
      quantidade: Integer; valorUnitario, valorTotal: Currency);
    procedure deletePedido_Produto(codigo: Integer);
    procedure updatePedido_Produto(codigo, numeroPedido, codigoProduto,
      quantidade: Integer; valorUnitario, valorTotal: Currency);
      function getLast: TPedidoProduto;
  end;

implementation

{ TPedidoProdutoDAO }

constructor TPedidoProdutoDAO.Create;
begin
  FDBConnection := TDBConnection.Create;
end;

function TPedidoProdutoDAO.getByCodigo(codigo: Integer): TPedidoProduto;
var qry: TFDQuery;
    connection: TFDConnection;
    pproduto: TPedidoProduto;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pproduto := TPedidoProduto.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM pedido_produto WHERE codigo = ' + IntToStr(codigo);
    qry.Open;
    qry.First;

    if not qry.IsEmpty then
      begin
        pproduto.codigo := qry.FieldByName('codigo').AsInteger;
        pproduto.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
        pproduto.codigoProduto := qry.FieldByName('codigoProduto').AsInteger;
        pproduto.quantidade := qry.FieldByName('quantidade').AsInteger;
        pproduto.valorUnitario := qry.FieldByName('valorUnitario').AsCurrency;
        pproduto.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
      end
    else
      Writeln('Pedido_Produto não encontrado.');

    Result := pproduto;
  finally
    qry.Free;
  end;
end;

function TPedidoProdutoDAO.getByNumeroPedido(codigo: Integer): TList<TPedidoProduto>;
var qry: TFDQuery;
    connection: TFDConnection;
    pproduto: TPedidoProduto;
    pprodutos: TList<TPedidoProduto>;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pprodutos := TList<TPedidoProduto>.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM pedido_produto WHERE numeroPedido = ' + IntToStr(codigo);
    qry.Open;
    qry.First;

    if not qry.IsEmpty then
      begin
        while not qry.Eof do
          begin
            pproduto := TPedidoProduto.Create;

            pproduto.codigo := qry.FieldByName('codigo').AsInteger;
            pproduto.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
            pproduto.codigoProduto := qry.FieldByName('codigoProduto').AsInteger;
            pproduto.quantidade := qry.FieldByName('quantidade').AsInteger;
            pproduto.valorUnitario := qry.FieldByName('valorUnitario').AsCurrency;
            pproduto.valorTotal := qry.FieldByName('valorTotal').AsCurrency;

            pprodutos.Add(pproduto);
            qry.Next;
          end;
      end
    else
      Writeln('Pedido_Produto não encontrado.');

    Result := pprodutos;
  finally
    qry.Free;
  end;
end;

function TPedidoProdutoDAO.getLast: TPedidoProduto;
var qry: TFDQuery;
    connection: TFDConnection;
    pproduto: TPedidoProduto;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pproduto := TPedidoProduto.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM pedido_produto WHERE codigo = (SELECT MAX(codigo) FROM pedido_produto)';
    qry.Open;
    qry.First;

    if not qry.IsEmpty then
      begin
        pproduto.codigo := qry.FieldByName('codigo').AsInteger;
        pproduto.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
        pproduto.codigoProduto := qry.FieldByName('codigoProduto').AsInteger;
        pproduto.quantidade := qry.FieldByName('quantidade').AsInteger;
        pproduto.valorUnitario := qry.FieldByName('valorUnitario').AsCurrency;
        pproduto.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
      end
    else
      Writeln('Pedido de produto não encontrado.');

    Result := pproduto;
  finally
    qry.Free;
  end;

end;

function TPedidoProdutoDAO.getAll: TList<TPedidoProduto>;
var qry: TFDQuery;
    connection: TFDConnection;
    pproduto: TPedidoProduto;
    pprodutos: TList<TPedidoProduto>;
    i: Integer;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  pprodutos := TList<TPedidoProduto>.Create;

  try
      qry.Connection := connection;
      qry.SQL.Text := 'SELECT * FROM pedido_produto';
      qry.Open;
      qry.First;

       if not qry.IsEmpty then
        begin
          pproduto := TPedidoProduto.Create;

          for i := 0 to qry.RecordCount do
            begin
              pproduto.codigo := qry.FieldByName('codigo').AsInteger;
              pproduto.numeroPedido := qry.FieldByName('numeroPedido').AsInteger;
              pproduto.codigoProduto := qry.FieldByName('codigoProduto').AsInteger;
              pproduto.quantidade := qry.FieldByName('quantidade').AsInteger;
              pproduto.valorUnitario := qry.FieldByName('valorUnitario').AsCurrency;
              pproduto.valorTotal := qry.FieldByName('valorTotal').AsCurrency;
              pprodutos.Add(pproduto);
            end;
        end
      else
        Writeln('Nenhum pedido_produto cadastrado.');

      Result := pprodutos;
  finally
    qry.Free;
  end;
end;

procedure TPedidoProdutoDAO.addPedido_Produto(numeroPedido: Integer; codigoProduto: Integer; quantidade: Integer; valorUnitario: Currency; valorTotal: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'INSERT INTO pedido_produto (numeroPedido, codigoProduto, quantidade, valorUnitario, valorTotal) values ('+InttoStr(numeroPedido)+', '+InttoStr(codigoProduto)+', '+InttoStr(quantidade)+', '+ StringReplace(CurrtoStr(valorUnitario), ',', '.', []) +', '+ StringReplace(CurrtoStr(valorTotal), ',', '.', []) +')';
      qry.Execute;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao inserir pedido_produto.');
    end;
  finally
    qry.Free;
  end;
end;


procedure TPedidoProdutoDAO.updatePedido_Produto(codigo: Integer; numeroPedido: Integer; codigoProduto: Integer; quantidade: Integer; valorUnitario: Currency; valorTotal: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'UPDATE pedido_produto SET numeroPedido = '+InttoStr(numeroPedido)+', codigoProduto = '+InttoStr(codigoProduto)+', quantidade = '+InttoStr(quantidade)+', valorUnitario = '+ StringReplace(CurrtoStr(valorUnitario), ',', '.', []) +', valorTotal = '+ StringReplace(CurrtoStr(valorTotal), ',', '.', []) +'  WHERE codigo = ' + IntToStr(codigo);
      qry.Execute;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao editar pedido_produto.');
    end;
  finally
    qry.Free;
  end;
end;

procedure TPedidoProdutoDAO.deletePedido_Produto(codigo: Integer);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'DELETE FROM pedido_produto WHERE codigo = ' + IntToStr(codigo);
      qry.Execute;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao deletar pedido_produto.');
    end;
  finally
    qry.Free;
  end;
end;

end.
