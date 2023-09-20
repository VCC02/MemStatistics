object frmMemStatisticsMain: TfrmMemStatisticsMain
  Left = 0
  Top = 0
  Caption = 'Memory Statistics'
  ClientHeight = 340
  ClientWidth = 992
  Color = clBtnFace
  Constraints.MinHeight = 347
  Constraints.MinWidth = 990
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  DesignSize = (
    992
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object lblListName: TLabel
    Left = 8
    Top = 8
    Width = 1008
    Height = 19
    Caption = 
      'List Name: Please run from mikroPascal/mikroC/mikroBasic with pa' +
      'rameters:  "%LIST_FILE_NAME" %CHIP_NAME Dummy'
    Font.Charset = DEFAULT_CHARSET
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
    Top = 32
    Width = 199
    Height = 19
    Caption = 'Chip Name: not selected'
    Font.Charset = DEFAULT_CHARSET
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
    Top = 57
    Width = 174
    Height = 19
    Caption = '"Defs" Folder: not set'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object spdClearFilters: TSpeedButton
    Left = 468
    Top = 280
    Width = 76
    Height = 37
    Anchors = [akRight, akBottom]
    Caption = 'Clear Filters'
    OnClick = spdClearFiltersClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 321
    Width = 992
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object prbLoading: TProgressBar
    Left = 102
    Top = 323
    Width = 298
    Height = 17
    Anchors = [akLeft, akBottom]
    Smooth = True
    TabOrder = 0
  end
  object PageControlEntries: TPageControl
    Left = 468
    Top = 57
    Width = 516
    Height = 219
    ActivePage = TabSheetStatistics
    Anchors = [akTop, akRight, akBottom]
    Constraints.MinHeight = 219
    Constraints.MinWidth = 516
    TabOrder = 2
    OnChange = PageControlEntriesChange
    object TabSheetRoutines: TTabSheet
      Caption = 'By routines'
      DesignSize = (
        508
        191)
      object lblVstBackground: TLabel
        Left = 3
        Top = 0
        Width = 502
        Height = 143
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Color = clWindow
        ParentColor = False
        ExplicitHeight = 182
      end
    end
    object TabSheetRaw: TTabSheet
      Caption = 'By address'
      ImageIndex = 1
      DesignSize = (
        508
        191)
      object lblVstBackgroundRaw: TLabel
        Left = 3
        Top = 0
        Width = 494
        Height = 122
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Color = clWindow
        ParentColor = False
        Transparent = False
      end
    end
    object TabSheetStatistics: TTabSheet
      Caption = 'Statistics'
      ImageIndex = 2
      DesignSize = (
        508
        191)
      object lstFreeMemory: TListBox
        Left = 3
        Top = 2
        Width = 502
        Height = 186
        Hint = 'Press Ctrl+C to copy this list to clipboard.'
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Visible = False
        OnKeyDown = lstFreeMemoryKeyDown
      end
    end
  end
  object rdgrpChartContent: TRadioGroup
    Left = 796
    Top = 0
    Width = 188
    Height = 75
    Anchors = [akTop, akRight]
    Caption = 'Chart content'
    ItemIndex = 2
    Items.Strings = (
      'Display only from routines'
      'Display only from raw addresses'
      'Display both above')
    TabOrder = 3
    OnClick = rdgrpChartContentClick
  end
  object prbUpdateSignalsListRun1: TProgressBar
    Left = 402
    Top = 323
    Width = 363
    Height = 17
    Anchors = [akLeft, akBottom]
    Smooth = True
    TabOrder = 4
  end
  object lbeMem: TLabeledEdit
    Left = 548
    Top = 296
    Width = 34
    Height = 21
    Anchors = [akRight, akBottom]
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Mem'
    TabOrder = 5
    OnChange = lbeMemChange
  end
  object lbeAddrHex: TLabeledEdit
    Left = 588
    Top = 296
    Width = 69
    Height = 21
    Anchors = [akRight, akBottom]
    EditLabel.Width = 69
    EditLabel.Height = 13
    EditLabel.Caption = 'Address [Hex]'
    TabOrder = 6
    OnChange = lbeMemChange
    OnKeyPress = lbeAddrHexKeyPress
  end
  object lbeAddrDec: TLabeledEdit
    Left = 663
    Top = 296
    Width = 66
    Height = 21
    Anchors = [akRight, akBottom]
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = 'Address [Dec]'
    TabOrder = 7
    OnChange = lbeMemChange
    OnKeyPress = lbeAddrDecKeyPress
  end
  object lbeSize: TLabeledEdit
    Left = 735
    Top = 296
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'Size'
    TabOrder = 8
    OnChange = lbeMemChange
    OnKeyPress = lbeSizeKeyPress
  end
  object lbeEntryName: TLabeledEdit
    Left = 799
    Top = 296
    Width = 178
    Height = 21
    Anchors = [akRight, akBottom]
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Entry Name'
    TabOrder = 9
    OnChange = lbeMemChange
  end
  object pnlVisibleEntries: TPanel
    Left = 663
    Top = 57
    Width = 130
    Height = 17
    Hint = 'Number of entries that match your search criteria.'
    Anchors = [akTop, akRight]
    Caption = 'All visible entries'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
  end
  object btnSettings: TButton
    Left = 468
    Top = 32
    Width = 70
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Settings...'
    TabOrder = 11
    OnClick = btnSettingsClick
  end
  object btnNewCompareWindow: TButton
    Left = 544
    Top = 33
    Width = 160
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'New Compare Window...'
    TabOrder = 12
    OnClick = btnNewCompareWindowClick
  end
  object pnlSplitterStatusFromVersions: TPanel
    Left = 458
    Top = 57
    Width = 10
    Height = 260
    Cursor = crHSplit
    Anchors = [akTop, akBottom]
    Color = clYellow
    ParentBackground = False
    TabOrder = 13
    OnMouseDown = pnlSplitterStatusFromVersionsMouseDown
    OnMouseMove = pnlSplitterStatusFromVersionsMouseMove
    OnMouseUp = pnlSplitterStatusFromVersionsMouseUp
  end
  object pnlSplitterPathFromStatus: TPanel
    Left = 422
    Top = 33
    Width = 18
    Height = 264
    Cursor = crHSplit
    Anchors = [akLeft, akTop, akBottom]
    Color = clYellow
    ParentBackground = False
    TabOrder = 14
    Visible = False
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrStartupTimer
    Left = 295
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
