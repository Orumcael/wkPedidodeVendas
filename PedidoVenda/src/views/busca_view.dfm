object frmBusca: TfrmBusca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Busca'
  ClientHeight = 320
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object grdBusca: TStringGrid
    Left = 0
    Top = 0
    Width = 588
    Height = 248
    Align = alClient
    DefaultColWidth = 116
    DefaultRowHeight = 32
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    OnDblClick = grdBuscaDblClick
    OnKeyDown = grdBuscaKeyDown
    ExplicitWidth = 584
    ExplicitHeight = 247
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 248
    Width = 588
    Height = 72
    Align = alBottom
    BorderStyle = bsSingle
    TabOrder = 1
    ExplicitTop = 247
    ExplicitWidth = 584
    object btnSelecionar: TButton
      Left = 172
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
    object btnCancelar: TButton
      Left = 488
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object edtCodPedido: TLabeledEdit
      Left = 16
      Top = 32
      Width = 150
      Height = 23
      EditLabel.Width = 99
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo do Pedido:'
      NumbersOnly = True
      TabOrder = 2
      Text = ''
    end
  end
end
