program PedidoVenda;

uses
  Vcl.Forms,
  System.SysUtils,
  cliente in 'src\models\cliente.pas',
  produto in 'src\models\produto.pas',
  pedido in 'src\models\pedido.pas',
  db_connection in 'src\database\db_connection.pas',
  pedido_controller in 'src\controllers\pedido_controller.pas',
  pedido_view in 'src\views\pedido_view.pas' {PedidoView},
  clienteDAO in 'src\models\clienteDAO.pas',
  produtoDAO in 'src\models\produtoDAO.pas',
  pedido_produto in 'src\models\pedido_produto.pas',
  pedido_produtoDAO in 'src\models\pedido_produtoDAO.pas',
  pedidoDAO in 'src\models\pedidoDAO.pas',
  cliente_controller in 'src\controllers\cliente_controller.pas',
  produto_controller in 'src\controllers\produto_controller.pas',
  pedido_produto_controller in 'src\controllers\pedido_produto_controller.pas',
  busca_view in 'src\views\busca_view.pas' {frmBusca};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPedidoView, PedidoView);
  // Cria o formulário principal
  Application.Run;  // Inicia a aplicação VCL
end.
