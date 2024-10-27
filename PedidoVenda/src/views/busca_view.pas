unit busca_view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, produto_controller,
  System.Generics.Collections, produto, cliente, cliente_controller, pedido, pedido_controller,
  Vcl.Mask, pedido_produto_controller, pedido_produto;

type
  TOperacao = (Cliente, Produto, Pedido);

type
  TfrmBusca = class(TForm)
    grdBusca: TStringGrid;
    pnlBottom: TPanel;
    btnSelecionar: TButton;
    btnCancelar: TButton;
    edtCodPedido: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure grdBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdBuscaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    produtoController: TProdutoController;
    clienteController: TClienteController;
    pedidoController: TPedidoController;
    ppController: TPedidoProdutoController;
    procedure excluir(codigo: Integer);
  public
    { Public declarations }    
    operacao: TOperacao;
    excluirPedido: Boolean;
    codigoConsulta: Integer;
  end;

var
  frmBusca: TfrmBusca;

implementation

{$R *.dfm}

procedure TfrmBusca.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBusca.btnSelecionarClick(Sender: TObject);
var pedidoProdutos: TList<TPedidoProduto>;
    i: Integer;
begin
  if excluirPedido then
    begin
      if Trim(edtCodPedido.Text) <> '' then
        excluir(StrToInt(Trim(edtCodPedido.Text)))
      else
        excluir(StrToInt(grdBusca.Cells[0, grdBusca.Row]))
    end
  else
    begin
      if Trim(edtCodPedido.Text) <> '' then
        codigoConsulta := StrToInt(Trim(edtCodPedido.Text))
      else
        codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);
    end;

  Close;
end;

procedure TfrmBusca.excluir(codigo: Integer);
var pedidoProdutos: TList<TPedidoProduto>;
    i: Integer;
begin
  pedidoProdutos := ppController.findPedidoProdutoNumeroPedido(codigo);

  for i := 0 to (pedidoProdutos.Count - 1) do
    begin
      ppController.removePedidoProduto(pedidoProdutos.Items[i].codigo);
    end;

  pedidoController.removePedido(codigo);
  ShowMessage('Pedido cancelado com sucesso!');
end;

procedure TfrmBusca.FormDestroy(Sender: TObject);
begin
  if produtoController <> nil then
    produtoController.Free;

  if clienteController <> nil then
    clienteController.Free;

  if pedidoController <> nil then
    pedidoController.Free;

  if ppController <> nil then
    ppController.Free;
end;

procedure TfrmBusca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmBusca.FormShow(Sender: TObject);
var lProduto: TList<TProduto>;
    lCliente: TList<TCliente>;
    lPedido: TList<TPedido>;
    i: Integer;
begin
  edtCodPedido.Clear;

  case (operacao) of
    Cliente:
      begin
        clienteController:= TClienteController.Create;
        
        grdBusca.RowCount:= 1;
        grdBusca.ColCount:= 4;

        grdBusca.Cells[0, 0] := 'Código';
        grdBusca.Cells[1, 0] := 'Nome';
        grdBusca.Cells[2, 0] := 'Cidade';
        grdBusca.Cells[3, 0] := 'UF';

        lCliente := clienteController.findAllCliente();

        grdBusca.RowCount:= (lCliente.Count + 1);
        
        for i := 0 to (lCliente.Count-1) do
          begin
            grdBusca.Cells[0, (i+1)] := InttoStr(lCliente.Items[i].codigo);
            grdBusca.Cells[1, (i+1)] := lCliente.Items[i].nome;
            grdBusca.Cells[2, (i+1)] := lCliente.Items[i].cidade;
            grdBusca.Cells[3, (i+1)] := lCliente.Items[i].uf;
          end;
      end;

    Produto:
      begin
        produtoController:= TProdutoController.Create;
        
        grdBusca.RowCount:= 1;
        grdBusca.ColCount:= 3;

        grdBusca.Cells[0, 0] := 'Código';
        grdBusca.Cells[1, 0] := 'Descrição';
        grdBusca.Cells[2, 0] := 'Preço Venda';

        lProduto := produtoController.findAllProduto();

        grdBusca.RowCount:= (lProduto.Count + 1);
        
        for i := 0 to (lProduto.Count-1) do
          begin
            grdBusca.Cells[0, (i+1)] := InttoStr(lProduto.Items[i].codigo);
            grdBusca.Cells[1, (i+1)] := lProduto.Items[i].descricao;
            grdBusca.Cells[2, (i+1)] := CurrtoStr(lProduto.Items[i].precoVenda);
          end;
      end;

      Pedido:
      begin
        pedidoController:= TPedidoController.Create;
        clienteController:= TClienteController.Create;
        ppController:= TPedidoProdutoController.Create;

        grdBusca.RowCount:= 1;
        grdBusca.ColCount:= 4;

        grdBusca.Cells[0, 0] := 'Número Pedido';
        grdBusca.Cells[1, 0] := 'Data Emissão';
        grdBusca.Cells[2, 0] := 'Cliente';
        grdBusca.Cells[3, 0] := 'Valor Total';

        lPedido := pedidoController.findAllPedido();

        grdBusca.RowCount:= (lPedido.Count + 1);

        for i := 0 to (lPedido.Count-1) do
          begin
            grdBusca.Cells[0, (i+1)] := InttoStr(lPedido.Items[i].numeropedido);
            grdBusca.Cells[1, (i+1)] := DateToStr(lPedido.Items[i].dataEmissao);

            // Busca o nome do cliente
            grdBusca.Cells[2, (i+1)] := clienteController.findCliente(lPedido.Items[i].codigoCliente).nome;

            grdBusca.Cells[3, (i+1)] := CurrtoStr(lPedido.Items[i].valorTotal);
          end;
      end;
  end;

  if grdBusca.RowCount > 1 then
    grdBusca.Row := 1;
end;

procedure TfrmBusca.grdBuscaDblClick(Sender: TObject);
begin
  if excluirPedido then
    excluir(StrToInt(grdBusca.Cells[0, grdBusca.Row]))
  else
    codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);

  Close;
end;

procedure TfrmBusca.grdBuscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      if excluirPedido then
        excluir(StrToInt(grdBusca.Cells[0, grdBusca.Row]))
      else
        codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);

      Close;
    end;
end;

end.
