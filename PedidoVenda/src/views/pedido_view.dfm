object PedidoView: TPedidoView
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 509
  ClientWidth = 1138
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
    Height = 509
    Align = alLeft
    BevelInner = bvNone
    DefaultColWidth = 153
    DefaultRowHeight = 30
    FixedColor = clScrollBar
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    OnKeyDown = grdProdutosKeyDown
    ExplicitHeight = 508
  end
  object pnlLeft: TPanel
    Left = 773
    Top = 0
    Width = 365
    Height = 509
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 1
    ExplicitWidth = 361
    ExplicitHeight = 508
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
    object edtCodProduto: TLabeledEdit
      Left = 14
      Top = 213
      Width = 45
      Height = 23
      Color = clScrollBar
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo:'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object btnCodProduto: TButton
      Left = 65
      Top = 212
      Width = 30
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnCodProdutoClick
    end
    object edtProduto: TLabeledEdit
      Left = 110
      Top = 213
      Width = 235
      Height = 23
      Color = clScrollBar
      EditLabel.Width = 46
      EditLabel.Height = 15
      EditLabel.Caption = 'Produto:'
      ReadOnly = True
      TabOrder = 2
      Text = ''
    end
    object btnInserirProduto: TButton
      Left = 14
      Top = 300
      Width = 115
      Height = 25
      Caption = 'Inserir/Confirmar'
      TabOrder = 3
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
      TabOrder = 4
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
      TabOrder = 5
      Text = ''
    end
    object btnGravarPedido: TButton
      Left = 14
      Top = 452
      Width = 150
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 6
      OnClick = btnGravarPedidoClick
    end
    object btnCarregarPedido: TButton
      Left = 194
      Top = 452
      Width = 150
      Height = 25
      Caption = 'Carregar Pedido'
      TabOrder = 7
      OnClick = btnCarregarPedidoClick
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
      TabOrder = 8
    end
    object edtCodCliente: TLabeledEdit
      Left = 14
      Top = 52
      Width = 45
      Height = 23
      TabStop = False
      Color = clScrollBar
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo:'
      EditLabel.Color = clScrollBar
      EditLabel.ParentColor = False
      ReadOnly = True
      TabOrder = 9
      Text = ''
    end
    object btnCodCliente: TButton
      Left = 65
      Top = 51
      Width = 30
      Height = 25
      Caption = '...'
      TabOrder = 10
      OnClick = btnCodClienteClick
    end
    object edtCliente: TLabeledEdit
      Left = 14
      Top = 103
      Width = 331
      Height = 23
      Color = clScrollBar
      EditLabel.Width = 40
      EditLabel.Height = 15
      EditLabel.Caption = 'Cliente:'
      ReadOnly = True
      TabOrder = 11
      Text = ''
    end
  end
end