unit produtoDAO;

interface

uses db_connection, produto, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections, firedac.DApt;

type
  TProdutoDAO = class
  Private
    FDBConnection: TDBConnection;
  public
    Constructor Create;
    function getByCodigo(codigo: Integer): TProduto;
    function getAll(): TList<TProduto>;
    procedure addproduto(descricao: String; precoVenda: Currency);
    procedure updateProduto(codigo: Integer; descricao: String;
      precoVenda: Currency);
    procedure deleteProduto(codigo: Integer);
    function getLast: TProduto;
  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  FDBConnection := TDBConnection.Create;
end;

function TProdutoDAO.getByCodigo(codigo: Integer): TProduto;
var qry: TFDQuery;
    connection: TFDConnection;
    produto: TProduto;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  produto := TProduto.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM produto WHERE codigo = ' + IntToStr(codigo);
    qry.Open;
    qry.First;

    if not qry.IsEmpty then
      begin
        produto.codigo := qry.FieldByName('codigo').AsInteger;
        produto.descricao := qry.FieldByName('descricao').AsString;
        produto.precoVenda := qry.FieldByName('precoVenda').AsCurrency;
      end
    else
      Writeln('Produto não encontrado.');

    Result := produto;
  finally
    qry.Free;
  end;
end;

function TProdutoDAO.getAll(): TList<TProduto>;
var qry: TFDQuery;
    connection: TFDConnection;
    produto: TProduto;
    produtos: TList<TProduto>;
    i: Integer;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  produtos := TList<TProduto>.Create;

  try
      qry.Connection := connection;
      qry.SQL.Text := 'SELECT * FROM produto';
      qry.Open;
      qry.First;

       if not qry.IsEmpty then
        begin
          while not qry.Eof do
            begin
              produto := TProduto.Create;

              produto.codigo := qry.FieldByName('codigo').AsInteger;
              produto.descricao := qry.FieldByName('descricao').AsString;
              produto.precoVenda := qry.FieldByName('precoVenda').AsCurrency;

              produtos.Add(produto);
              qry.Next;
            end;
        end
      else
        Writeln('Nenhum produto cadastrado.');

      Result := produtos;
  finally
    qry.Free;
  end;
end;

procedure TProdutoDAO.addproduto(descricao: String; precoVenda: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'INSERT INTO produto (descricao, precoVenda) values ( '+ descricao + ', ' + CurrToStr(precoVenda) + ')';
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao inserir produto.');
    end;
  finally
    qry.Free;
  end;
end;


procedure TProdutoDAO.updateProduto(codigo: Integer; descricao: String; precoVenda: Currency);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'UPDATE produto SET descricao = ' + descricao + ', precoVenda = ' + CurrToStr(precoVenda) + ' WHERE codigo = ' + IntToStr(codigo);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao editar produto.');
    end;
  finally
    qry.Free;
  end;
end;

function TProdutoDAO.getLast: TProduto;
var qry: TFDQuery;
    connection: TFDConnection;
    produto: TProduto;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);
  produto := TProduto.Create;

  try
    qry.Connection := connection;
    qry.SQL.Text := 'SELECT * FROM produto WHERE codigo = (SELECT MAX(codigo) FROM produto)';
    qry.Open;
    if not qry.IsEmpty then
      begin
        produto.codigo := qry.FieldByName('codigo').AsInteger;
        produto.descricao := qry.FieldByName('descricao').AsString;
        produto.precoVenda := qry.FieldByName('precoVenda').AsCurrency;
      end
    else
      Writeln('Produto não encontrado.');
    Result := produto;
  finally
    qry.Free;
  end;

end;

procedure TProdutoDAO.deleteProduto(codigo: Integer);
var qry: TFDQuery;
    connection: TFDConnection;
begin
  connection := FDBConnection.GetConnection;
  qry := TFDQuery.Create(nil);

  try
    connection.StartTransaction;
    try
      qry.Connection := connection;
      qry.SQL.Text := 'DELETE FROM produto WHERE codigo = ' + IntToStr(codigo);
      qry.Open;
      connection.Commit;
    except
      connection.Rollback;
      raise Exception.Create('Erro ao deletar produto.');
    end;
  finally
    qry.Free;
  end;
end;

end.

