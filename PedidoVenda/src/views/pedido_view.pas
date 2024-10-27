unit pedido_view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Def, pedido_controller, pedido, produto,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, Vcl.Mask, busca_view, produto_controller, cliente,
  cliente_controller, pedido_produto_controller, pedido_produto, System.Generics.Collections,
  Vcl.Buttons;

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
    btnLimpar: TBitBtn;
    btnCancelarPedido: TButton;
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCodProdutoClick(Sender: TObject);
    procedure btnCodClienteClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure grdProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtCodClienteChange(Sender: TObject);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    codigoPedido: Integer;
    editarItem: Integer;
    produtoController: TProdutoController;
    clienteController: TClienteController;
    pedidoController: TPedidoController;
    ppController: TPedidoProdutoController;
    procedure MoveToNextCell();
    procedure MoveToPreviousCell();
    procedure limpaDadosGrid();
    procedure limpaDadosCliente();
    procedure limpaDadosProduto();
    procedure CalcularTotalPedido();
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

  codigoPedido := 0;
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

procedure TPedidoView.edtCodClienteChange(Sender: TObject);
begin
  if Trim(edtCodCliente.Text) <> '' then
    begin
      btnCarregarPedido.Enabled := False;
      btnCancelarPedido.Enabled := False;
    end
  else
    begin
      btnCarregarPedido.Enabled := True;
      btnCancelarPedido.Enabled := True;
    end;
end;

procedure TPedidoView.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cliente: TCliente;
begin
  if Key = VK_RETURN then
    begin
      if Trim(edtCodCliente.Text) <> '' then
        begin
          cliente := clienteController.findCliente(StrToInt(Trim(edtCodCliente.Text)));

          edtCodCliente.Text := IntToStr(cliente.codigo);
          edtCliente.Text := cliente.nome;
        end;
    end;
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

    VK_RETURN:
			begin
        btnCodProduto.Enabled := False;
        editarItem := grdProdutos.Row;

				edtCodProduto.Text := grdProdutos.Cells[0, grdProdutos.Row];
				edtProduto.Text := grdProdutos.Cells[1, grdProdutos.Row];
				edtQtd.Text := grdProdutos.Cells[2, grdProdutos.Row];
				edtVlUnitario.Text := grdProdutos.Cells[3, grdProdutos.Row];
        edtQtd.SetFocus;
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

procedure TPedidoView.grdProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if ARow = 0 then
    CanSelect := False
  else
    CanSelect := True;
end;

procedure TPedidoView.limpaDadosGrid();
var i: Integer;
begin
  grdProdutos.RowCount := 1;
end;

procedure TPedidoView.limpaDadosCliente;
begin
  edtCodCliente.Clear;
  edtCliente.Clear;
end;

procedure TPedidoView.limpaDadosProduto;
begin
  edtCodProduto.Clear;
  edtProduto.Clear;
  edtQtd.Clear;
  edtVlUnitario.Clear;
end;

procedure TPedidoView.btnCancelarPedidoClick(Sender: TObject);
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.operacao := TOperacao.Pedido;
  frmBusca.excluirPedido := True;
  frmBusca.ShowModal;
  frmBusca.Free;
  edtCodCliente.SetFocus;
end;

procedure TPedidoView.btnCarregarPedidoClick(Sender: TObject);
var pedido: TPedido;
    produto: TProduto;
    cliente: TCliente;
    pedidoProdutos: TList<TPedidoProduto>;
    i: Integer;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.excluirPedido := False;
  frmBusca.operacao := TOperacao.Pedido;
  frmBusca.ShowModal;

  if frmBusca.codigoConsulta <> 0 then
    begin
      pedido := pedidoController.findPedido(frmBusca.codigoConsulta);
      codigoPedido := pedido.numeroPedido;

      pedidoProdutos := ppController.findPedidoProdutoNumeroPedido(pedido.numeroPedido);
      cliente := clienteController.findCliente(pedido.codigoCliente);

      // Carrega o cliente
      edtCodCliente.Text := IntToStr(cliente.codigo);
      edtCliente.Text := cliente.nome;

      limpaDadosGrid();
      grdProdutos.RowCount := (pedidoProdutos.Count + 1);

      // Carrega os produtos
      for i := 0 to (pedidoProdutos.Count - 1) do
        begin
          produto := produtoController.findProduto(pedidoProdutos.Items[i].codigoProduto);

          grdProdutos.Cells[0, (i+1)] := IntToStr(produto.codigo);
          grdProdutos.Cells[1, (i+1)] := produto.descricao;
          grdProdutos.Cells[2, (i+1)] := IntToStr(pedidoProdutos.Items[i].Quantidade);
          grdProdutos.Cells[3, (i+1)] := CurrToStr(pedidoProdutos.Items[i].ValorUnitario);
          grdProdutos.Cells[4, (i+1)] := CurrToStr(pedidoProdutos.Items[i].ValorTotal);
        end;

      CalcularTotalPedido();
    end;

  frmBusca.Free;
  grdProdutos.Row := 1;
  grdProdutos.setfocus;
end;

procedure TPedidoView.btnCodClienteClick(Sender: TObject);
var cliente: TCliente;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.excluirPedido := False;
  frmBusca.operacao := TOperacao.Cliente;
  frmBusca.ShowModal;

  if frmBusca.codigoConsulta <> 0 then
    begin
      cliente := clienteController.findCliente(frmBusca.codigoConsulta);

      edtCodCliente.Text := IntToStr(cliente.codigo);
      edtCliente.Text := cliente.nome;
    end
  else
    begin
      edtCodCliente.Clear;
      edtCliente.Clear;
    end;

  frmBusca.free;
end;

procedure TPedidoView.btnCodProdutoClick(Sender: TObject);
var produto: TProduto;
begin
  frmBusca := TfrmBusca.Create(Self);
  frmBusca.excluirPedido := False;
  frmBusca.operacao := TOperacao.Produto;
  frmBusca.ShowModal;

  if frmBusca.codigoConsulta <> 0 then
    begin
      produto := produtoController.findProduto(frmBusca.codigoConsulta);

      edtCodProduto.Text := IntToStr(produto.codigo);
      edtProduto.Text := produto.descricao;
      edtVlUnitario.Text := CurrToStr(produto.precoVenda);
    end
  else
    begin
      edtCodProduto.Clear;
      edtProduto.Clear;
      edtVlUnitario.Clear;
    end;

  frmBusca.free;
  edtQtd.Text := '';
  edtQtd.SetFocus;

end;

procedure TPedidoView.btnGravarPedidoClick(Sender: TObject);
var pedido: TPedido;
    lPedidoProduto: TList<TPedidoProduto>;
    i: Integer;
    total: String;
begin
  if grdProdutos.RowCount = 1 then
  begin
    ShowMessage('Não há produtos para gravar o pedido!');
    Exit;
  end;

  if edtCodCliente.Text <> '' then
  begin
    if codigoPedido <> 0 then
      begin
        // Edita o pedido e produto_pedido
        total := StringReplace(lblTotal.Caption, 'Total do Pedido: R$', '', []);
        pedido := pedidoController.findPedido(codigoPedido);
        pedido := pedidoController.editPedido(pedido.numeroPedido, Now, pedido.codigoCliente, StrToCurr(total));

        lPedidoProduto := ppController.findPedidoProdutoNumeroPedido(codigoPedido);

        for i := 0 to (lPedidoProduto.Count - 1) do
          begin
            ppController.editPedidoProduto(lPedidoProduto.Items[i].codigo, codigoPedido, lPedidoProduto.Items[i].codigoProduto, StrToInt(grdProdutos.Cells[2, (i+1)]), StrToCurr(grdProdutos.Cells[3, (i+1)]), StrToCurr(grdProdutos.Cells[4, (i+1)]));
          end;

        codigoPedido := 0;
      end
    else
      begin
        // Grava o pedido e produto_pedido
        total := StringReplace(lblTotal.Caption, 'Total do Pedido: R$', '', []);
        pedido := pedidoController.addPedido(Now, StrToInt(edtCodCliente.Text), StrToCurr(total));

        for i := 1 to (grdProdutos.RowCount - 1) do
          begin
            ppController.addPedidoProduto(pedido.numeroPedido, StrToInt(grdProdutos.Cells[0, i]), StrToInt(grdProdutos.Cells[2, i]), StrToCurr(grdProdutos.Cells[3, i]), StrToCurr(grdProdutos.Cells[4, i]));
          end;
      end;


    ShowMessage('Pedido gravado com sucesso!');

    if MessageDlg('Deseja iniciar um novo pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        btnLimpar.Click();
        CalcularTotalPedido();
        edtCodCliente.SetFocus;
      end;
  end
  else
  begin
    ShowMessage('Os campos não foram preenchidos corretamente!');
  end;
end;

procedure TPedidoView.btnInserirProdutoClick(Sender: TObject);
var pos: Integer;
begin
  if ((edtQtd.Text <> '') and (edtVlUnitario.Text <> '')) then
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
      limpaDadosProduto();

      if btnCodProduto.Enabled = False then
      begin
       btnCodProduto.Enabled := True;
      end;
  end
  else
  begin
    ShowMessage('Os campos não foram preenchidos corretamente!');
    edtQtd.SetFocus;
  end;

end;

procedure TPedidoView.btnLimparClick(Sender: TObject);
begin
  limpaDadosGrid();
  limpaDadosCliente();
  limpaDadosProduto();
  CalcularTotalPedido();
  edtCodCliente.SetFocus;
end;

end.
