unit pedido_view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Def, pedido_controller, pedido, produto,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, Vcl.Mask, busca_view, produto_controller, cliente,
  cliente_controller, pedido_produto_controller, pedido_produto, System.Generics.Collections;

type
  TPedidoView = class(TForm)
    grdProdutos: TStringGrid;
    pnlLeft: TPanel;
    edtCodProduto: TLabeledEdit;
    btnCodProduto: TButton;
    edtProduto: TLabeledEdit;
    btnInserirProduto: TButton;
    edtQtd: TLabeledEdit;
    edtVlUnitario: TLabeledEdit;
    btnGravarPedido: TButton;
    btnCarregarPedido: TButton;
    RadioGroup2: TRadioGroup;
    edtCodCliente: TLabeledEdit;
    btnCodCliente: TButton;
    edtCliente: TLabeledEdit;
    lblTotal: TLabel;
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCodProdutoClick(Sender: TObject);
    procedure btnCodClienteClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    //procedure btnGravarPedidoClick(Sender: TObject);
    //procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
    //  Shift: TShiftState);
    //procedure edtCodigoClienteChange(Sender: TObject);
    //procedure btnCarregarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    editarItem: Integer;
    produtoController: TProdutoController;
    clienteController: TClienteController;
    pedidoController: TPedidoController;
    ppController: TPedidoProdutoController;
    procedure MoveToNextCell();
    procedure MoveToPreviousCell();
    //procedure AtualizarGrid;
    procedure CalcularTotalPedido;
    procedure RemoverLinhaGrid(Index: Integer);
  public
    { Public declarations }
  end;

var
  PedidoView: TPedidoView;

implementation

{$R *.dfm}

procedure TPedidoView.FormShow(Sender: TObject);
begin
  produtoController := TProdutoController.Create;
  clienteController := TClienteController.Create;
  pedidoController := TPedidoController.Create;
  ppController := TPedidoProdutoController.Create;

  editarItem := 0;

  grdProdutos.RowCount:= 1;
  grdProdutos.ColCount:= 5;

  grdProdutos.Cells[0, 0] := 'Código';
  grdProdutos.Cells[1, 0] := 'Descrição';
  grdProdutos.Cells[2, 0] := 'Quantidade';
  grdProdutos.Cells[3, 0] := 'Valor Unitário';
  grdProdutos.Cells[4, 0] := 'Valor Total';
end;

procedure TPedidoView.CalcularTotalPedido();
var Total: Currency;
    i: Integer;
begin
  Total := 0;

  for i := 1 to (grdProdutos.RowCount - 1) do
    Total := Total + StrToCurr(grdProdutos.Cells[4, i]);

  lblTotal.Caption := 'Total do Pedido: R$' + CurrToStr(Total);
end;

procedure TPedidoView.RemoverLinhaGrid(Index: Integer);
var I: Integer;
begin
  for I := Index to grdProdutos.RowCount - 2 do
    grdProdutos.Rows[I].Assign(grdProdutos.Rows[I + 1]);

  grdProdutos.RowCount := grdProdutos.RowCount - 1;
end;

procedure TPedidoView.MoveToNextCell();
begin
	if grdProdutos.Row < (grdProdutos.RowCount - 1) then
		grdProdutos.Row := (grdProdutos.Row + 1);

	grdProdutos.SetFocus;
end;

procedure TPedidoView.MoveToPreviousCell();
begin
	if grdProdutos.Row > 0 then
		grdProdutos.Row := (grdProdutos.Row - 1);

	grdProdutos.SetFocus;
end;

procedure TPedidoView.grdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	case Key of
		//VK_UP:	MoveToPreviousCell();
	  //VK_DOWN: MoveToNextCell();
    VK_RETURN:
			begin
        editarItem := grdProdutos.Row;

				edtCodProduto.Text := grdProdutos.Cells[0, grdProdutos.Row];
				edtProduto.Text := grdProdutos.Cells[1, grdProdutos.Row];
				edtQtd.Text := grdProdutos.Cells[2, grdProdutos.Row];
				edtVlUnitario.Text := grdProdutos.Cells[3, grdProdutos.Row];
			end;
		VK_DELETE:
			begin
        if grdProdutos.Row > 0 then
          begin
            if MessageDlg('Deseja realmente apagar o produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              RemoverLinhaGrid(grdProdutos.Row);
              CalcularTotalPedido;
            end;
          end;
			end;
	end;
end;

procedure TPedidoView.btnCarregarPedidoClick(Sender: TObject);
var pedido: TPedido;
    produto: TProduto;
    pedidoProdutos: TList<TPedidoProduto>;
    i: Integer;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.operacao := TOperacao.Pedido;
  frmBusca.ShowModal;
  pedido := pedidoController.findPedido(frmBusca.codigoConsulta);
  frmBusca.Free;

  pedidoProdutos := ppController.findPedidoProdutoNumeroPedido(pedido.numeroPedido);

  for i := 1 to (grdProdutos.RowCount - 1) do
    begin
      produto := produtoController.findProduto(pedidoProdutos.Items[i].codigoProduto);

      grdProdutos.Cells[0, i] := IntToStr(produto.codigo);
      grdProdutos.Cells[1, i] := produto.descricao;
      grdProdutos.Cells[2, i] := IntToStr(pedidoProdutos.Items[i].Quantidade);
      grdProdutos.Cells[3, i] := CurrToStr(pedidoProdutos.Items[i].ValorUnitario);
      grdProdutos.Cells[4, i] := CurrToStr(pedidoProdutos.Items[i].ValorTotal);
    end;
end;

procedure TPedidoView.btnCodClienteClick(Sender: TObject);
var cliente: TCliente;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.operacao := TOperacao.Cliente;
  frmBusca.ShowModal;
  cliente := clienteController.findCliente(frmBusca.codigoConsulta);
  frmBusca.free;

  edtCodCliente.Text := IntToStr(cliente.codigo);
  edtCliente.Text := cliente.nome;
end;

procedure TPedidoView.btnCodProdutoClick(Sender: TObject);
var produto: TProduto;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.operacao := TOperacao.Produto;
  frmBusca.ShowModal;
  produto := produtoController.findProduto(frmBusca.codigoConsulta);
  frmBusca.free;

  edtCodProduto.Text := IntToStr(produto.codigo);
  edtProduto.Text := produto.descricao;
  edtVlUnitario.Text := CurrToStr(produto.precoVenda);
end;

procedure TPedidoView.btnGravarPedidoClick(Sender: TObject);
var pedido: TPedido;
    i: Integer;
    total, vlunitario: String;
begin
  // Grava o pedido
  total := StringReplace(lblTotal.Caption, 'Total do Pedido: R$', '', []);
  pedido := pedidoController.addPedido(Now, StrToInt(edtCodCliente.Text), StrToCurr(total));

  // Grava o produto_pedido
  for i := 1 to (grdProdutos.RowCount - 1) do
    begin
      ppController.addPedidoProduto(pedido.numeroPedido, StrToInt(grdProdutos.Cells[0, i]), StrToInt(grdProdutos.Cells[2, i]), StrToCurr(grdProdutos.Cells[3, i]), StrToCurr(grdProdutos.Cells[4, i]));
    end;

  ShowMessage('Pedido gravado com sucesso!');
end;

procedure TPedidoView.btnInserirProdutoClick(Sender: TObject);
var pos: Integer;
begin
  if editarItem <> 0 then
    begin
      // Editando um produto
      pos := editarItem;
      editarItem := 0;
    end
  else
    begin
      // Adicionando novo produto
      grdProdutos.RowCount := grdProdutos.RowCount + 1;
      pos := (grdProdutos.RowCount-1);
    end;

    grdProdutos.Cells[0, pos] := edtCodProduto.Text;
    grdProdutos.Cells[1, pos] := edtProduto.Text;
    grdProdutos.Cells[2, pos] := edtQtd.Text;
    grdProdutos.Cells[3, pos] := edtVlUnitario.Text;
    grdProdutos.Cells[4, pos] := CurrToStr(StrToCurr(edtQtd.Text) *  StrToCurr(edtVlUnitario.Text));

    CalcularTotalPedido();



  {
  begin
  // Se o grid estiver sendo editado, atualize a linha atual com os novos valores
  if grdProdutos.Row > 0 then
    begin
      SelectedRow := grdProdutos.Row;
      grdProdutos.Cells[2, SelectedRow] := edtQuantidade.Text;
      grdProdutos.Cells[3, SelectedRow] := edtValorUnitario.Text;
      grdProdutos.Cells[4, SelectedRow] := CurrToStr(StrToInt(edtQuantidade.Text) * StrToCurr(edtValorUnitario.Text));
    end
  else
    begin
      // Adicionar novo produto
      CalcularTotalPedido;

    Produto := TProduto.Create;
    Produto.Codigo := StrToInt(edtCodigoProduto.Text);
    Produto.Descricao := 'Produto ' + IntToStr(Produto.Codigo); // Simular busca do produto
    Produto.PrecoVenda := StrToCurr(edtValorUnitario.Text);

    Item := TPedidoItem.Create;
    Item.codigoProduto := Produto;
    Item.Quantidade := StrToInt(edtQuantidade.Text);
    Item.ValorUnitario := Produto.PrecoVenda;
    Item.ValorTotal := Item.Quantidade * Item.ValorUnitario;

    FPedido.Itens.Add(Item);
    AtualizarGrid;
    CalcularTotalPedido;
    end;
  end;}
end;

{
procedure TPedidoView.btnCarregarPedidoClick(Sender: TObject);
var
  NumeroPedido: Integer;
  Qry: TFDQuery;
begin
  if InputQuery('Carregar Pedido', 'Informe o número do pedido:', NumeroPedido) then
  begin
    Qry := TFDQuery.Create(nil);
    try
      Qry.Connection := FController.FDBConnection.GetConnection;
      Qry.SQL.Text := 'SELECT * FROM pedidos WHERE Numero = :Numero';
      Qry.Params.ParamByName('Numero').AsInteger := NumeroPedido;
      Qry.Open;
      if not Qry.IsEmpty then
      begin
        // Carregar os dados do cliente e produtos aqui...
      end
      else
        ShowMessage('Pedido não encontrado.');
    finally
      Qry.Free;
    end;
  end;
end;

}


{


procedure TPedidoView.edtCodigoClienteChange(Sender: TObject);
begin
  btnCarregarPedido.Visible := edtCodigoCliente.Text = '';
end;

procedure TPedidoView.AtualizarGrid;
var
  I: Integer;
begin
  grdProdutos.RowCount := FPedido.Itens.Count + 1;
  for I := 0 to FPedido.Itens.Count - 1 do
  begin
    grdProdutos.Cells[0, I + 1] := IntToStr(FPedido.Itens[I].codigoProduto.Codigo);
    grdProdutos.Cells[1, I + 1] := FPedido.Itens[I].codigoProduto.Descricao;
    grdProdutos.Cells[2, I + 1] := IntToStr(FPedido.Itens[I].Quantidade);
    grdProdutos.Cells[3, I + 1] := CurrToStr(FPedido.Itens[I].ValorUnitario);
    grdProdutos.Cells[4, I + 1] := CurrToStr(FPedido.Itens[I].ValorTotal);
  end;
end;

procedure TPedidoView.grdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  SelectedRow: Integer;
begin
  if Key = VK_UP then
    grdProdutos.Row := grdProdutos.Row - 1
  else if Key = VK_DOWN then
    grdProdutos.Row := grdProdutos.Row + 1
  else if Key = VK_RETURN then
  begin
    begin
      SelectedRow := grdProdutos.Row;
      // Carregar os dados do produto selecionado para edição
      edtCodigoProduto.Text := grdProdutos.Cells[0, SelectedRow];
      edtQuantidade.Text := grdProdutos.Cells[2, SelectedRow];
      edtValorUnitario.Text := grdProdutos.Cells[3, SelectedRow];
    end;
  end
  else if Key = VK_DELETE then
  begin
    SelectedRow := grdProdutos.Row;
    if SelectedRow > 0 then
    begin
      if MessageDlg('Deseja realmente apagar o produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        RemoverLinhaGrid(SelectedRow); // Chama o método para remover a linha
        CalcularTotalPedido;
      end;
    end;
  end;
end;

   }

end.
