unit busca_view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, produto_controller,
  System.Generics.Collections, produto, cliente, cliente_controller, pedido, pedido_controller;

type
  TOperacao = (Cliente, Produto, Pedido);
  
type
  TfrmBusca = class(TForm)
    grdBusca: TStringGrid;
    pnlBottom: TPanel;
    btnSelecionar: TButton;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure grdBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdBuscaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    produtoController: TProdutoController;
    clienteController: TClienteController;
    ppController: TPedidoController;
  public
    { Public declarations }    
    operacao: TOperacao;
    codigoConsulta: Integer;
  end;

var
  frmBusca: TfrmBusca;

implementation

{$R *.dfm}

procedure TfrmBusca.btnCancelarClick(Sender: TObject);
begin
  produtoController.Free;
  clienteController.Free;
  ppController.Free;
  Close;
end;

procedure TfrmBusca.btnSelecionarClick(Sender: TObject);
begin
  codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);
  btnCancelar.Click();
end;

procedure TfrmBusca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TfrmBusca.FormShow(Sender: TObject);
var lProduto: TList<TProduto>;
    lCliente: TList<TCliente>;
    lPedido:   TList<TPedido>;
    i: Integer;
begin
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

        grdBusca.RowCount:= lCliente.Count;
        
        for i := 0 to (lCliente.Count-1) do
          begin
            grdBusca.Cells[0, i] := InttoStr(lCliente.Items[i].codigo);
            grdBusca.Cells[1, i] := lCliente.Items[i].nome;
            grdBusca.Cells[2, i] := lCliente.Items[i].cidade;
            grdBusca.Cells[3, i] := lCliente.Items[i].uf;
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

        grdBusca.RowCount:= lProduto.Count;
        
        for i := 0 to (lProduto.Count-1) do
          begin
            grdBusca.Cells[0, i] := InttoStr(lProduto.Items[i].codigo);
            grdBusca.Cells[1, i] := lProduto.Items[i].descricao;
            grdBusca.Cells[2, i] := CurrtoStr(lProduto.Items[i].precoVenda);
          end;
      end;

      Pedido:
      begin
        ppController:= TPedidoController.Create;

        grdBusca.RowCount:= 1;
        grdBusca.ColCount:= 6;

        grdBusca.Cells[0, 0] := 'Número Pedido';
        grdBusca.Cells[1, 0] := 'Data Emissão';
        grdBusca.Cells[2, 0] := 'Código Cliente';
        grdBusca.Cells[3, 0] := 'Valor Total';


        lPedido := ppController.findAllPedido();

        grdBusca.RowCount:= lPedido.Count;

        for i := 0 to (lPedido.Count-1) do
          begin
            grdBusca.Cells[0, i] := InttoStr(lPedido.Items[i].numeropedido);
            grdBusca.Cells[1, i] := DateToStr(lPedido.Items[i].dataEmissao);
            grdBusca.Cells[2, i] := InttoStr(lPedido.Items[i].codigoCliente);
            grdBusca.Cells[3, i] := CurrtoStr(lPedido.Items[i].valorTotal);
          end;
      end;
  end;
end;

procedure TfrmBusca.grdBuscaDblClick(Sender: TObject);
begin
  codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);
  btnCancelar.Click();
end;

procedure TfrmBusca.grdBuscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      codigoConsulta := StrToInt(grdBusca.Cells[0, grdBusca.Row]);
      btnCancelar.Click();
    end;
end;

end.
