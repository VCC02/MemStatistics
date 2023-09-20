object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  Caption = 'Memory Statistics - Settings'
  ClientHeight = 500
  ClientWidth = 769
  Color = clBtnFace
  Constraints.MinHeight = 448
  Constraints.MinWidth = 785
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    769
    500)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 290
    Top = 467
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'OK'
    Enabled = False
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 394
    Top = 467
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pagctrlSettings: TPageControl
    Left = 0
    Top = 0
    Width = 761
    Height = 461
    ActivePage = TabSheetMiscColors
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheetMiscColors: TTabSheet
      Caption = 'Colors'
      object pagctrlColors: TPageControl
        Left = 3
        Top = 0
        Width = 745
        Height = 289
        ActivePage = TabSheetChartMemCmpColors
        TabOrder = 0
        object TabSheetChartMemCmpColors: TTabSheet
          Caption = 'Chart (Memory compare)'
          ImageIndex = 1
          object grpEntriesColorsChartMemComp: TGroupBox
            Left = 0
            Top = 1
            Width = 274
            Height = 248
            Caption = 'Entries (PFM, RAM, BFM, EBI, SQI)'
            TabOrder = 0
            object lblFirstFileEntryColor: TLabel
              Left = 8
              Top = 36
              Width = 38
              Height = 13
              Caption = 'First file'
            end
            object lblSecondFileEntryColor: TLabel
              Left = 8
              Top = 96
              Width = 52
              Height = 13
              Caption = 'Second file'
            end
            object lblThirdFileEntryColor: TLabel
              Left = 8
              Top = 156
              Width = 43
              Height = 13
              Caption = 'Third File'
            end
            object lblFourthFileEntryColor: TLabel
              Left = 8
              Top = 216
              Width = 51
              Height = 13
              Caption = 'Fourth File'
            end
            object pnlFirstFileEntryChart: TPanel
              Left = 70
              Top = 18
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clRed
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFirstFileEntryChart: TColorBox
              Left = 119
              Top = 33
              Width = 145
              Height = 22
              Selected = clRed
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 1
              OnChange = colboxGenericChange
            end
            object pnlSecondFileEntryChart: TPanel
              Left = 70
              Top = 78
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clLime
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxSecondFileEntryChart: TColorBox
              Left = 119
              Top = 93
              Width = 145
              Height = 22
              Selected = clLime
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 3
              OnChange = colboxGenericChange
            end
            object pnlThirdFileEntryChart: TPanel
              Left = 70
              Top = 138
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clSkyBlue
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxThirdFileEntryChart: TColorBox
              Left = 119
              Top = 153
              Width = 145
              Height = 22
              Selected = clSkyBlue
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 5
              OnChange = colboxGenericChange
            end
            object pnlFourthFileEntryChart: TPanel
              Left = 70
              Top = 198
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clGreen
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFourthFileEntryChart: TColorBox
              Left = 119
              Top = 213
              Width = 145
              Height = 22
              Selected = clGreen
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 7
              OnChange = colboxGenericChange
            end
          end
          object grpSelectedEntriesColorsChartMemComp: TGroupBox
            Left = 279
            Top = 1
            Width = 274
            Height = 248
            Caption = 'Selected entries (PFM, RAM, BFM, EBI, SQI)'
            TabOrder = 1
            object lblFirstFileSelectedEntryColor: TLabel
              Left = 8
              Top = 36
              Width = 38
              Height = 13
              Caption = 'First file'
            end
            object lblSecondFileSelectedEntryColor: TLabel
              Left = 8
              Top = 96
              Width = 52
              Height = 13
              Caption = 'Second file'
            end
            object lblThirdFileSelectedEntryColor: TLabel
              Left = 8
              Top = 156
              Width = 43
              Height = 13
              Caption = 'Third File'
            end
            object lblFourthFileSelectedEntryColor: TLabel
              Left = 8
              Top = 216
              Width = 51
              Height = 13
              Caption = 'Fourth File'
            end
            object pnlFirstFileSelectedEntryChart: TPanel
              Left = 70
              Top = 18
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFirstFileSelectedEntryChart: TColorBox
              Left = 119
              Top = 33
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 1
              OnChange = colboxGenericChange
            end
            object pnlSecondFileSelectedEntryChart: TPanel
              Left = 70
              Top = 78
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxSecondFileSelectedEntryChart: TColorBox
              Left = 119
              Top = 93
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 3
              OnChange = colboxGenericChange
            end
            object pnlThirdFileSelectedEntryChart: TPanel
              Left = 70
              Top = 138
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxThirdFileSelectedEntryChart: TColorBox
              Left = 119
              Top = 153
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 5
              OnChange = colboxGenericChange
            end
            object pnlFourthFileSelectedEntryChart: TPanel
              Left = 70
              Top = 198
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFourthFileSelectedEntryChart: TColorBox
              Left = 119
              Top = 213
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 7
              OnChange = colboxGenericChange
            end
          end
          object grpOverlapColorsChartMemComp: TGroupBox
            Left = 559
            Top = 1
            Width = 170
            Height = 248
            Caption = 'Overlapping areas'
            TabOrder = 2
            object rdgrpColorType: TRadioGroup
              Left = 16
              Top = 24
              Width = 145
              Height = 81
              Caption = 'Color type'
              ItemIndex = 0
              Items.Strings = (
                'Average color'
                'Selected color')
              TabOrder = 0
              OnClick = rdgrpColorTypeClick
            end
            object pnlOverlap: TPanel
              Left = 14
              Top = 198
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clGray
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Visible = False
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxOverlap: TColorBox
              Left = 15
              Top = 153
              Width = 145
              Height = 22
              Selected = clGray
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 2
              Visible = False
              OnChange = colboxGenericChange
            end
          end
        end
        object TabSheetChartMiscColors: TTabSheet
          Caption = 'Chart (Miscellaneous)'
          ImageIndex = 2
          object grpTextColorsChart: TGroupBox
            Left = 0
            Top = 1
            Width = 273
            Height = 130
            Caption = 'Text'
            TabOrder = 0
            object lblChartTextBackgroundColor: TLabel
              Left = 8
              Top = 36
              Width = 56
              Height = 13
              Caption = 'Background'
            end
            object lblChartTextColor: TLabel
              Left = 8
              Top = 96
              Width = 56
              Height = 13
              Caption = 'Foreground'
            end
            object pnlTextBackgroundChart: TPanel
              Left = 70
              Top = 18
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clCream
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxTextBackgroundChart: TColorBox
              Left = 119
              Top = 33
              Width = 145
              Height = 22
              Selected = clCream
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 1
              OnChange = colboxGenericChange
            end
            object pnlTextColorChart: TPanel
              Left = 70
              Top = 78
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxTextColorChart: TColorBox
              Left = 119
              Top = 93
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 3
              OnChange = colboxGenericChange
            end
          end
          object grpLinesAndBackgroundColorsChart: TGroupBox
            Left = 279
            Top = 1
            Width = 274
            Height = 130
            Caption = 'Lines and background'
            TabOrder = 1
            object lblChartBackgroundColor: TLabel
              Left = 8
              Top = 36
              Width = 56
              Height = 13
              Caption = 'Background'
            end
            object ChartLineColor: TLabel
              Left = 8
              Top = 96
              Width = 24
              Height = 13
              Caption = 'Lines'
            end
            object pnlBackgroundChart: TPanel
              Left = 70
              Top = 18
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clCream
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxBackgroundChart: TColorBox
              Left = 119
              Top = 33
              Width = 145
              Height = 22
              Selected = clCream
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 1
              OnChange = colboxGenericChange
            end
            object pnlLineChart: TPanel
              Left = 70
              Top = 78
              Width = 43
              Height = 43
              Hint = 'Double click to edit'
              Color = clBlack
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxLineChart: TColorBox
              Left = 119
              Top = 93
              Width = 145
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              TabOrder = 3
              OnChange = colboxGenericChange
            end
          end
        end
      end
    end
    object TabSheetMiscSettings: TTabSheet
      Caption = 'Misc'
      ImageIndex = 1
      DesignSize = (
        753
        433)
      object chkDisplayDecimalAddressesCmpTable: TCheckBox
        Left = 3
        Top = 16
        Width = 246
        Height = 17
        Caption = 'Display Decimal Addresses in Compare Table'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnKeyUp = chkDisplayDecimalAddressesCmpTableKeyUp
        OnMouseUp = chkDisplayDecimalAddressesCmpTableMouseUp
      end
      object chkDisplayTableHints: TCheckBox
        Left = 3
        Top = 48
        Width = 174
        Height = 17
        Caption = 'Display Table Hints'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnKeyUp = chkDisplayTableHintsKeyUp
        OnMouseUp = chkDisplayTableHintsMouseUp
      end
      object grpDevice: TGroupBox
        Left = 3
        Top = 112
        Width = 174
        Height = 249
        Caption = 'Device'
        TabOrder = 2
        object lblDeviceBitness: TLabel
          Left = 16
          Top = 189
          Width = 69
          Height = 13
          Caption = 'Device bitness'
        end
        object lbeDefaultChipName: TLabeledEdit
          Left = 16
          Top = 40
          Width = 145
          Height = 21
          Hint = 
            'Used when no chip is provided from cmdline. It should be prefixe' +
            'd by the full prefix name (e.g. "PIC" instead of "P"). Example: ' +
            'PIC32MX795F512L'
          EditLabel.Width = 86
          EditLabel.Height = 13
          EditLabel.Caption = 'Default chip name'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyUp = lbeDefaultChipNameKeyUp
        end
        object lbeDefFilePrefix: TLabeledEdit
          Left = 16
          Top = 96
          Width = 145
          Height = 21
          Hint = 'Example:  P32,  P24, P30, P33'
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Def file prefix'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnKeyUp = lbeDefFilePrefixKeyUp
        end
        object lbeExpectedPrefix: TLabeledEdit
          Left = 16
          Top = 152
          Width = 145
          Height = 21
          Hint = 'Example:  PIC32,  PIC24, PIC30, PIC33'
          EditLabel.Width = 76
          EditLabel.Height = 13
          EditLabel.Caption = 'Expected prefix'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnKeyUp = lbeExpectedPrefixKeyUp
        end
        object cmbDeviceBitness: TComboBox
          Left = 16
          Top = 208
          Width = 145
          Height = 22
          Hint = 
            'This has to match the architecture that MemStatistics is working' +
            ' with.'
          Style = csOwnerDrawFixed
          ItemHeight = 16
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnChange = cmbDeviceBitnessChange
          Items.Strings = (
            '8-bit'
            '16-bit'
            '32-bit')
        end
      end
      object grpDeviceDefinitions: TGroupBox
        Left = 280
        Top = 0
        Width = 470
        Height = 126
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Device definitions'
        TabOrder = 3
        DesignSize = (
          470
          126)
        object lbeDefsFolder: TLabeledEdit
          Left = 6
          Top = 36
          Width = 419
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 53
          EditLabel.Height = 13
          EditLabel.Caption = 'Defs folder'
          TabOrder = 0
          OnKeyUp = lbeDefsFolderKeyUp
        end
        object btnBrowseDefsFolder: TButton
          Left = 431
          Top = 36
          Width = 27
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
          OnClick = btnBrowseDefsFolderClick
        end
        object rdgrpDefinitionFilePriority: TRadioGroup
          Left = 6
          Top = 63
          Width = 185
          Height = 56
          Caption = 'Definition file priority'
          ItemIndex = 0
          Items.Strings = (
            'Defs folder (mlk / json)'
            'Local device list (ini)')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = rdgrpDefinitionFilePriorityClick
        end
      end
    end
    object TabSheetMemorySections: TTabSheet
      Caption = 'Memory Sections'
      ImageIndex = 2
      DesignSize = (
        753
        433)
      object spdbtnMoveUp: TSpeedButton
        Left = 250
        Top = 405
        Width = 23
        Height = 25
        Hint = 'Move up'
        Anchors = [akLeft, akBottom]
        Enabled = False
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = [fsBold]
        Glyph.Data = {
          56010000424D560100000000000036000000280000000F000000060000000100
          1800000000002001000000000000000000000000000000000000FFFFFF4CB122
          4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1
          224CB122FFFFFF000000FFFFFFFFFFFF4CB1224CB1224CB1224CB1224CB1224C
          B1224CB1224CB1224CB1224CB1224CB122FFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFF4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB122FFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF4CB1224CB1224CB1224C
          B1224CB1224CB1224CB122FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF4CB1224CB1224CB1224CB1224CB122FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4CB1224C
          B1224CB122FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = spdbtnMoveUpClick
        ExplicitTop = 314
      end
      object spdbtnMoveDown: TSpeedButton
        Left = 279
        Top = 405
        Width = 23
        Height = 25
        Hint = 'Move down'
        Anchors = [akLeft, akBottom]
        Enabled = False
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = [fsBold]
        Glyph.Data = {
          56010000424D560100000000000036000000280000000F000000060000000100
          1800000000002001000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF4CB1224CB1224CB122FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4CB1224CB1224C
          B1224CB1224CB122FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFF4CB1224CB1224CB1224CB1224CB1224CB1224CB122FFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF4CB1224CB1224CB1224CB1224C
          B1224CB1224CB1224CB1224CB122FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1
          22FFFFFFFFFFFF000000FFFFFF4CB1224CB1224CB1224CB1224CB1224CB1224C
          B1224CB1224CB1224CB1224CB1224CB1224CB122FFFFFF000000}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = spdbtnMoveDownClick
        ExplicitTop = 314
      end
      object lblMemoryTranslationInfoOperation: TLabel
        Left = 119
        Top = 278
        Width = 95
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Mem Translation Op'
      end
      object btnAdd: TButton
        Left = 0
        Top = 405
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Add'
        TabOrder = 0
        OnClick = btnAddClick
      end
      object btnDelete: TButton
        Left = 162
        Top = 405
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Delete...'
        TabOrder = 2
        OnClick = btnDeleteClick
      end
      object grpChartMemoryAllocation: TGroupBox
        Left = 355
        Top = 278
        Width = 198
        Height = 113
        Anchors = [akLeft, akBottom]
        Caption = 'Chart (Memory allocation) - Colors'
        TabOrder = 3
        object lblEntryColor: TLabel
          Left = 55
          Top = 18
          Width = 54
          Height = 13
          Caption = 'Entry Color'
        end
        object lblSelectedEntryColor: TLabel
          Left = 55
          Top = 67
          Width = 98
          Height = 13
          Caption = 'Selected Entry Color'
        end
        object pnlEntryChart: TPanel
          Left = 6
          Top = 14
          Width = 43
          Height = 43
          Hint = 'Double click to edit'
          Color = 5197823
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxEntryChart: TColorBox
          Left = 55
          Top = 37
          Width = 130
          Height = 22
          Selected = 5197823
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          TabOrder = 1
          OnChange = colboxGenericChange
        end
        object pnlSelectedEntryChart: TPanel
          Left = 6
          Top = 63
          Width = 43
          Height = 43
          Hint = 'Double click to edit'
          Color = clYellow
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxSelectedEntryChart: TColorBox
          Left = 55
          Top = 86
          Width = 130
          Height = 22
          Selected = clYellow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          TabOrder = 3
          OnChange = colboxGenericChange
        end
      end
      object grpTable: TGroupBox
        Left = 559
        Top = 278
        Width = 194
        Height = 113
        Anchors = [akLeft, akBottom]
        Caption = 'Table - Colors'
        TabOrder = 4
        object lblEntryColorTable: TLabel
          Left = 56
          Top = 18
          Width = 54
          Height = 13
          Caption = 'Entry Color'
        end
        object lblTextColorTable: TLabel
          Left = 56
          Top = 67
          Width = 50
          Height = 13
          Caption = 'Text Color'
        end
        object pnlEntryColorTable: TPanel
          Left = 6
          Top = 14
          Width = 43
          Height = 43
          Hint = 'Double click to edit'
          Color = 13158655
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxEntryColorTable: TColorBox
          Left = 56
          Top = 35
          Width = 130
          Height = 22
          Selected = 13158655
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          TabOrder = 1
          OnChange = colboxGenericChange
        end
        object pnlTextColorTable: TPanel
          Left = 6
          Top = 63
          Width = 43
          Height = 43
          Hint = 'Double click to edit'
          Color = clBlack
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxTextColorTable: TColorBox
          Left = 56
          Top = 86
          Width = 130
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          TabOrder = 3
          OnChange = colboxGenericChange
        end
      end
      object lbeDisplayName: TLabeledEdit
        Left = 3
        Top = 294
        Width = 110
        Height = 21
        Hint = 'Examples: PFM, RAM, BFM, CFG, EBI, SQI'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'Display Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnChange = GenericLabeledEditChange
      end
      object lbeLongDisplayName: TLabeledEdit
        Left = 3
        Top = 338
        Width = 110
        Height = 21
        Hint = 
          'Examples: Program Flash, RAM, Boot Flash, Config Flash, Ext Bus ' +
          'Interface, Ser Quad Interface'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Long Display Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = GenericLabeledEditChange
      end
      object lbeDefinitionName: TLabeledEdit
        Left = 3
        Top = 378
        Width = 110
        Height = 21
        Hint = 
          'Examples: ROM, RAM, BOOTROM, CFGREG, EBIROM, SQIROM.   Comma sep' +
          'arated values can be used, if multiple definition names are requ' +
          'ired for the same definition.'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 75
        EditLabel.Height = 13
        EditLabel.Caption = 'Definition Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = GenericLabeledEditChange
      end
      object lbeAddressOffsetS1: TLabeledEdit
        Left = 119
        Top = 338
        Width = 110
        Height = 21
        Hint = 
          'For PIC32, this can be 0x0, 0x20000000 or -0x20000000.   (-0x200' +
          '00000 = 0xE0000000)'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 88
        EditLabel.Height = 13
        EditLabel.Caption = 'Address Offset S1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnChange = GenericLabeledEditChange
      end
      object lbeMinDefaultAddr: TLabeledEdit
        Left = 119
        Top = 378
        Width = 110
        Height = 21
        Hint = 
          'Physical address (hex), used when the section is not found in de' +
          'finition file.'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 96
        EditLabel.Height = 13
        EditLabel.Caption = 'Min Default Address'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnChange = GenericLabeledEditChange
      end
      object lbeAddressOffsetS2: TLabeledEdit
        Left = 235
        Top = 338
        Width = 114
        Height = 21
        Hint = 
          'For PIC32, this can be 0x0, 0x20000000 or -0x20000000.   (-0x200' +
          '00000 = 0xE0000000)'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 88
        EditLabel.Height = 13
        EditLabel.Caption = 'Address Offset S2'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnChange = GenericLabeledEditChange
      end
      object lbeMaxDefaultAddr: TLabeledEdit
        Left = 235
        Top = 378
        Width = 114
        Height = 21
        Hint = 
          'Physical address (hex), used when the section is not found in de' +
          'finition file.'
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 100
        EditLabel.Height = 13
        EditLabel.Caption = 'Max Default Address'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnChange = GenericLabeledEditChange
      end
      object lbeMemoryTranslationInfoValue: TLabeledEdit
        Left = 235
        Top = 294
        Width = 114
        Height = 21
        Anchors = [akLeft, akBottom]
        EditLabel.Width = 107
        EditLabel.Height = 13
        EditLabel.Caption = 'Mem Translation Value'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnChange = GenericLabeledEditChange
      end
      object cmbMemoryTranslationInfoOperation: TComboBox
        Left = 119
        Top = 294
        Width = 110
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akBottom]
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 13
        Text = 'None'
        OnChange = cmbMemoryTranslationInfoOperationChange
        Items.Strings = (
          'None'
          'ADD'
          'OR')
      end
      object chkVisibleOnCompare: TCheckBox
        Left = 355
        Top = 413
        Width = 134
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Visible on compare'
        Checked = True
        State = cbChecked
        TabOrder = 14
        OnKeyUp = chkVisibleOnCompareKeyUp
        OnMouseUp = chkVisibleOnCompareMouseUp
      end
      object chkDisplayEvenIfMissingFromDefinition: TCheckBox
        Left = 504
        Top = 413
        Width = 225
        Height = 17
        Hint = 
          'Display EBI and SQI columns, even if their sections are not pres' +
          'ent in the definition file (.mlk / .json).'
        Anchors = [akLeft, akBottom]
        Caption = 'Display even if missing from definition'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 15
        OnKeyUp = chkDisplayEvenIfMissingFromDefinitionKeyUp
        OnMouseUp = chkDisplayEvenIfMissingFromDefinitionMouseUp
      end
      object bitbtnUpdate: TBitBtn
        Left = 81
        Top = 405
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Update'
        TabOrder = 1
        OnClick = btnUpdateClick
      end
      object chkVisibleOnTable: TCheckBox
        Left = 355
        Top = 394
        Width = 134
        Height = 15
        Anchors = [akLeft, akBottom]
        Caption = 'Visible on table'
        TabOrder = 16
        OnKeyUp = chkVisibleOnTableKeyUp
        OnMouseUp = chkVisibleOnTableMouseUp
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 536
  end
  object imglstMemSections: TImageList
    Height = 32
    Width = 32
    Left = 576
    Top = 464
    Bitmap = {
      494C010101000400040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000002000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000200000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF00000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object tmrUpdate: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrUpdateTimer
    Left = 104
    Top = 464
  end
end
