object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 567
  ClientWidth = 1294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblObj1: TLabel
    Left = 24
    Top = 123
    Width = 135
    Height = 13
    Caption = 'Oggetto JSON 1 (prioritario)'
  end
  object lblObj2: TLabel
    Left = 432
    Top = 123
    Width = 78
    Height = 13
    Caption = 'Oggetto JSON 2'
  end
  object lblObjRes: TLabel
    Left = 840
    Top = 123
    Width = 114
    Height = 13
    Caption = 'Oggetto JSON Risultato'
  end
  object lblTerminated: TCSLabel
    Left = 840
    Top = 25
    Width = 64
    Height = 13
    Caption = 'lblTerminated'
  end
  object memObj1: TMemo
    Left = 24
    Top = 147
    Width = 369
    Height = 377
    Lines.Strings = (
      'memObj1')
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object memObj2: TMemo
    Left = 432
    Top = 147
    Width = 369
    Height = 377
    Lines.Strings = (
      'memObj1')
    ScrollBars = ssBoth
    TabOrder = 7
  end
  object memObjRes: TMemo
    Left = 840
    Top = 147
    Width = 369
    Height = 377
    Lines.Strings = (
      'memObj1')
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object btnMerge: TButton
    Left = 24
    Top = 8
    Width = 369
    Height = 49
    Caption = 'Merge'
    TabOrder = 0
    OnClick = btnMergeClick
  end
  object edtWrapper: TCSEdit
    Left = 432
    Top = 22
    Width = 369
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Wrapper'
    TabOrder = 1
    ColorOnFocus = clYellow
    EditType = etTesto
    Options.AllowNegative = False
    Options.BlankWhenZero = False
    Options.CheckYear = False
    Options.DigitsDec = 0
    Options.DigitsInt = 0
    Options.FormatZero = fzNothing
    Options.MaxTimeUnit = tuOre
    Options.MinTimeUnit = tuSecondi
    Options.PercSign = False
    Options.Seconds = False
    Options.ThousandSep = False
    Options.Nullable = False
    DesignSize = (
      365
      17)
  end
  object btnClear1: TButton
    Left = 24
    Top = 92
    Width = 75
    Height = 25
    Caption = 'btnClear1'
    TabOrder = 3
    OnClick = btnClear1Click
  end
  object btnClear2: TButton
    Left = 432
    Top = 92
    Width = 75
    Height = 25
    Caption = 'btnClear2'
    TabOrder = 4
    OnClick = btnClear2Click
  end
  object btnClear3: TButton
    Left = 840
    Top = 92
    Width = 75
    Height = 25
    Caption = 'btnClear3'
    TabOrder = 5
    OnClick = btnClear3Click
  end
  object btnClearAll: TButton
    Left = 24
    Top = 63
    Width = 369
    Height = 25
    Caption = 'btnClearAll'
    TabOrder = 2
    OnClick = btnClearAllClick
  end
end
