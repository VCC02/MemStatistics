object frmMemStatisticsMain: TfrmMemStatisticsMain
  Left = 258
  Height = 347
  Top = 270
  Width = 1021
  Caption = 'Memory Statistics'
  ClientHeight = 347
  ClientWidth = 1021
  Color = clBtnFace
  Constraints.MinHeight = 347
  Constraints.MinWidth = 990
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  LCLVersion = '7.5'
  object lblListName: TLabel
    Left = 8
    Height = 19
    Top = 8
    Width = 1008
    Caption = 'List Name: Please run from mikroPascal/mikroC/mikroBasic with parameters:  "%LIST_FILE_NAME" %CHIP_NAME Dummy'
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object lblChipName: TLabel
    Left = 8
    Height = 19
    Top = 32
    Width = 199
    Caption = 'Chip Name: not selected'
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object lblDefsFolder: TLabel
    Left = 8
    Height = 19
    Top = 57
    Width = 174
    Caption = '"Defs" Folder: not set'
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object spdClearFilters: TSpeedButton
    Left = 472
    Height = 37
    Top = 287
    Width = 76
    Anchors = [akRight, akBottom]
    Caption = 'Clear Filters'
    OnClick = spdClearFiltersClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Height = 23
    Top = 324
    Width = 1021
    Panels = <    
      item
        Width = 100
      end    
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object prbLoading: TProgressBar
    Left = 102
    Height = 17
    Top = 330
    Width = 298
    Anchors = [akLeft, akBottom]
    Smooth = True
    TabOrder = 0
  end
  object PageControlEntries: TPageControl
    Left = 465
    Height = 226
    Top = 57
    Width = 548
    ActivePage = TabSheetStatistics
    Anchors = [akTop, akRight, akBottom]
    Constraints.MinHeight = 219
    Constraints.MinWidth = 516
    TabIndex = 2
    TabOrder = 2
    OnChange = PageControlEntriesChange
    object TabSheetRoutines: TTabSheet
      Caption = 'By routines'
      ClientHeight = 204
      ClientWidth = 546
      object lblVstBackground: TLabel
        Left = 3
        Height = 122
        Top = 0
        Width = 494
        Anchors = [akTop, akLeft, akRight, akBottom]
        AutoSize = False
        Color = clWindow
        Transparent = False
      end
    end
    object TabSheetRaw: TTabSheet
      Caption = 'By address'
      ClientHeight = 204
      ClientWidth = 546
      ImageIndex = 1
      object lblVstBackgroundRaw: TLabel
        Left = 3
        Height = 122
        Top = 0
        Width = 494
        Anchors = [akTop, akLeft, akRight, akBottom]
        AutoSize = False
        Color = clWindow
        Transparent = False
      end
    end
    object TabSheetStatistics: TTabSheet
      Caption = 'Statistics'
      ClientHeight = 200
      ClientWidth = 540
      ImageIndex = 2
      object lstFreeMemory: TListBox
        Left = 3
        Height = 188
        Hint = 'Press Ctrl+C to copy this list to clipboard.'
        Top = 2
        Width = 534
        Anchors = [akTop, akLeft, akRight, akBottom]
        ItemHeight = 0
        OnKeyDown = lstFreeMemoryKeyDown
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Visible = False
      end
    end
  end
  object prbUpdateSignalsListRun1: TProgressBar
    Left = 402
    Height = 17
    Top = 330
    Width = 363
    Anchors = [akLeft, akBottom]
    Smooth = True
    TabOrder = 4
  end
  object lbeMem: TLabeledEdit
    Left = 552
    Height = 21
    Top = 303
    Width = 36
    Anchors = [akRight, akBottom]
    EditLabel.Height = 13
    EditLabel.Width = 36
    EditLabel.Caption = 'Mem'
    TabOrder = 5
    OnChange = lbeMemChange
  end
  object lbeAddrHex: TLabeledEdit
    Left = 592
    Height = 21
    Top = 303
    Width = 80
    Anchors = [akRight, akBottom]
    EditLabel.Height = 13
    EditLabel.Width = 80
    EditLabel.Caption = 'Address [Hex]'
    TabOrder = 6
    OnChange = lbeMemChange
    OnKeyPress = lbeAddrHexKeyPress
  end
  object lbeAddrDec: TLabeledEdit
    Left = 680
    Height = 21
    Top = 303
    Width = 85
    Anchors = [akRight, akBottom]
    EditLabel.Height = 13
    EditLabel.Width = 85
    EditLabel.Caption = 'Address [Dec]'
    TabOrder = 7
    OnChange = lbeMemChange
    OnKeyPress = lbeAddrDecKeyPress
  end
  object lbeSize: TLabeledEdit
    Left = 773
    Height = 21
    Top = 303
    Width = 60
    Anchors = [akRight, akBottom]
    EditLabel.Height = 13
    EditLabel.Width = 60
    EditLabel.Caption = 'Size'
    TabOrder = 8
    OnChange = lbeMemChange
    OnKeyPress = lbeSizeKeyPress
  end
  object lbeEntryName: TLabeledEdit
    Left = 837
    Height = 21
    Top = 303
    Width = 169
    Anchors = [akRight, akBottom]
    EditLabel.Height = 13
    EditLabel.Width = 169
    EditLabel.Caption = 'Entry Name'
    TabOrder = 9
    OnChange = lbeMemChange
  end
  object pnlVisibleEntries: TPanel
    Left = 692
    Height = 17
    Hint = 'Number of entries that match your search criteria.'
    Top = 57
    Width = 130
    Anchors = [akTop, akRight]
    Caption = 'All visible entries'
    ParentBackground = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
  end
  object btnSettings: TButton
    Left = 465
    Height = 25
    Top = 32
    Width = 70
    Anchors = [akTop, akRight]
    Caption = 'Settings...'
    OnClick = btnSettingsClick
    TabOrder = 11
  end
  object btnNewCompareWindow: TButton
    Left = 541
    Height = 25
    Top = 32
    Width = 160
    Anchors = [akTop, akRight]
    Caption = 'New Compare Window...'
    OnClick = btnNewCompareWindowClick
    TabOrder = 12
  end
  object pnlSplitter: TPanel
    Cursor = crHSplit
    Left = 440
    Height = 267
    Top = 57
    Width = 10
    Anchors = [akTop, akBottom]
    Color = 7864319
    ParentBackground = False
    ParentColor = False
    TabOrder = 13
    OnMouseDown = pnlSplitterMouseDown
    OnMouseMove = pnlSplitterMouseMove
    OnMouseUp = pnlSplitterMouseUp
    OnResize = pnlSplitterResize
  end
  object rdgrpChartContent: TRadioGroup
    Left = 825
    Height = 75
    Top = 0
    Width = 188
    Anchors = [akTop, akRight]
    AutoFill = True
    Caption = 'Chart content'
    ChildSizing.LeftRightSpacing = 6
    ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
    ChildSizing.EnlargeVertical = crsHomogenousChildResize
    ChildSizing.ShrinkHorizontal = crsScaleChilds
    ChildSizing.ShrinkVertical = crsScaleChilds
    ChildSizing.Layout = cclLeftToRightThenTopToBottom
    ChildSizing.ControlsPerLine = 1
    ClientHeight = 57
    ClientWidth = 184
    ItemIndex = 2
    Items.Strings = (
      'Display only from routines'
      'Display only from raw addresses'
      'Display both above'
    )
    OnClick = rdgrpChartContentClick
    ParentBackground = False
    TabOrder = 3
  end
  object pnlHorizontalResize: TPanel
    Left = 0
    Height = 4
    Top = 325
    Width = 1013
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    ParentColor = False
    TabOrder = 14
    OnResize = pnlHorizontalResizeResize
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrStartupTimer
    Left = 224
    Top = 48
  end
  object tmrBlinkGraphicFocus: TTimer
    Interval = 250
    OnTimer = tmrBlinkGraphicFocusTimer
    Left = 328
    Top = 48
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 328
    Top = 176
  end
  object tmrDrawZoom: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrDrawZoomTimer
    Left = 152
    Top = 192
  end
  object pmEntries: TPopupMenu
    Left = 536
    Top = 184
    object MenuItem_VSTHints: TMenuItem
      AutoCheck = True
      Caption = 'Enable hints'
      OnClick = MenuItem_VSTHintsClick
    end
  end
  object pmChart: TPopupMenu
    Left = 64
    Top = 168
    object MenuItem_Reload: TMenuItem
      Caption = 'Reload files'
      OnClick = MenuItem_ReloadClick
    end
    object MenuItem_SetDefsFolder: TMenuItem
      Caption = 'Set Defs Folder...'
      OnClick = MenuItem_SetDefsFolderClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItem_BlinkFocusedEntry: TMenuItem
      AutoCheck = True
      Caption = 'Blink focused entry'
      Checked = True
      OnClick = MenuItem_BlinkFocusedEntryClick
    end
    object MenuItem_EnableZoomWindow: TMenuItem
      AutoCheck = True
      Caption = 'Enable zoom window'
      Checked = True
      OnClick = MenuItem_EnableZoomWindowClick
    end
    object MenuItem_ChartHints: TMenuItem
      AutoCheck = True
      Caption = 'Enable hints'
      Checked = True
      OnClick = MenuItem_ChartHintsClick
    end
  end
end
