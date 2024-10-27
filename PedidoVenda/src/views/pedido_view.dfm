object PedidoView: TPedidoView
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 508
  ClientWidth = 1134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object grdProdutos: TStringGrid
    Left = 0
    Top = 0
    Width = 773
    Height = 508
    TabStop = False
    Align = alLeft
    BevelInner = bvNone
    DefaultColWidth = 153
    DefaultRowHeight = 30
    FixedColor = clScrollBar
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    OnKeyDown = grdProdutosKeyDown
    OnSelectCell = grdProdutosSelectCell
    ExplicitHeight = 507
  end
  object pnlLeft: TPanel
    Left = 773
    Top = 0
    Width = 361
    Height = 508
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 1
    ExplicitWidth = 357
    ExplicitHeight = 507
    object lblTotal: TLabel
      Left = 14
      Top = 371
      Width = 166
      Height = 30
      Caption = 'Total do Pedido: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RadioGroup2: TRadioGroup
      Left = 4
      Top = 11
      Width = 349
      Height = 150
      Caption = 'Dados do Cliente '
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 12
    end
    object edtCodProduto: TLabeledEdit
      Left = 14
      Top = 213
      Width = 45
      Height = 23
      TabStop = False
      Color = clScrollBar
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo:'
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
    object btnCodProduto: TButton
      Left = 65
      Top = 212
      Width = 30
      Height = 25
      Caption = '...'
      TabOrder = 5
      OnClick = btnCodProdutoClick
    end
    object edtProduto: TLabeledEdit
      Left = 110
      Top = 213
      Width = 235
      Height = 23
      TabStop = False
      Color = clScrollBar
      EditLabel.Width = 46
      EditLabel.Height = 15
      EditLabel.Caption = 'Produto:'
      ReadOnly = True
      TabOrder = 6
      Text = ''
    end
    object btnInserirProduto: TButton
      Left = 14
      Top = 300
      Width = 115
      Height = 25
      Caption = 'Inserir/Confirmar'
      TabOrder = 9
      OnClick = btnInserirProdutoClick
    end
    object edtQtd: TLabeledEdit
      Left = 14
      Top = 261
      Width = 150
      Height = 23
      EditLabel.Width = 65
      EditLabel.Height = 15
      EditLabel.Caption = 'Quantidade:'
      NumbersOnly = True
      TabOrder = 7
      Text = ''
    end
    object edtVlUnitario: TLabeledEdit
      Left = 192
      Top = 261
      Width = 150
      Height = 23
      EditLabel.Width = 74
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor Unit'#225'rio:'
      NumbersOnly = True
      TabOrder = 8
      Text = ''
    end
    object btnGravarPedido: TButton
      Left = 14
      Top = 424
      Width = 150
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 10
      OnClick = btnGravarPedidoClick
    end
    object btnCarregarPedido: TButton
      Left = 16
      Top = 132
      Width = 153
      Height = 25
      Caption = 'Carregar Pedido'
      TabOrder = 2
      OnClick = btnCarregarPedidoClick
    end
    object edtCodCliente: TLabeledEdit
      Left = 14
      Top = 52
      Width = 45
      Height = 23
      TabStop = False
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo:'
      EditLabel.Color = clScrollBar
      EditLabel.ParentColor = False
      NumbersOnly = True
      TabOrder = 13
      Text = ''
      OnChange = edtCodClienteChange
      OnKeyDown = edtCodClienteKeyDown
    end
    object btnCodCliente: TButton
      Left = 65
      Top = 51
      Width = 30
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnCodClienteClick
    end
    object edtCliente: TLabeledEdit
      Left = 14
      Top = 103
      Width = 331
      Height = 23
      TabStop = False
      Color = clScrollBar
      EditLabel.Width = 40
      EditLabel.Height = 15
      EditLabel.Caption = 'Cliente:'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object btnLimpar: TBitBtn
      Left = 198
      Top = 424
      Width = 150
      Height = 25
      Caption = 'Limpa Campos'
      TabOrder = 11
      OnClick = btnLimparClick
    end
    object btnCancelarPedido: TButton
      Left = 192
      Top = 132
      Width = 153
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 3
      OnClick = btnCancelarPedidoClick
    end
  end
end
