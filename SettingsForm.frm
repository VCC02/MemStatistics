object frmSettings: TfrmSettings
  Left = 215
  Height = 540
  Top = 185
  Width = 882
  Caption = 'Memory Statistics - Settings'
  ClientHeight = 540
  ClientWidth = 882
  Color = clBtnFace
  Constraints.MinHeight = 540
  Constraints.MinWidth = 882
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  LCLVersion = '7.5'
  object btnOK: TButton
    Left = 338
    Height = 25
    Top = 507
    Width = 75
    Anchors = [akBottom]
    Caption = 'OK'
    Enabled = False
    OnClick = btnOKClick
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 458
    Height = 25
    Top = 507
    Width = 75
    Anchors = [akBottom]
    Caption = 'Cancel'
    OnClick = btnCancelClick
    TabOrder = 1
  end
  object pagctrlSettings: TPageControl
    Left = 0
    Height = 501
    Top = 0
    Width = 874
    ActivePage = TabSheetMiscSettings
    Anchors = [akTop, akLeft, akRight, akBottom]
    TabIndex = 1
    TabOrder = 2
    object TabSheetMiscColors: TTabSheet
      Caption = 'Colors   '
      ClientHeight = 473
      ClientWidth = 866
      object pagctrlColors: TPageControl
        Left = 3
        Height = 289
        Top = 0
        Width = 745
        ActivePage = TabSheetChartMemCmpColors
        TabIndex = 0
        TabOrder = 0
        object TabSheetChartMemCmpColors: TTabSheet
          Caption = 'Chart (Memory compare)'
          ClientHeight = 261
          ClientWidth = 737
          ImageIndex = 1
          object grpEntriesColorsChartMemComp: TGroupBox
            Left = 0
            Height = 248
            Top = 1
            Width = 288
            Caption = 'Entries (PFM, RAM, BFM, EBI, SQI)'
            ClientHeight = 228
            ClientWidth = 284
            ParentBackground = False
            TabOrder = 0
            object lblFirstFileEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 18
              Width = 41
              Caption = 'First file'
            end
            object lblSecondFileEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 78
              Width = 58
              Caption = 'Second file'
            end
            object lblThirdFileEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 138
              Width = 47
              Caption = 'Third file'
            end
            object lblFourthFileEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 198
              Width = 54
              Caption = 'Fourth file'
            end
            object pnlFirstFileEntryChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 0
              Width = 43
              Color = clRed
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFirstFileEntryChart: TColorBox
              Left = 133
              Height = 22
              Top = 15
              Width = 145
              Selected = clRed
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 1
            end
            object pnlSecondFileEntryChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 60
              Width = 43
              Color = clLime
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxSecondFileEntryChart: TColorBox
              Left = 133
              Height = 22
              Top = 75
              Width = 145
              Selected = clLime
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 3
            end
            object pnlThirdFileEntryChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 120
              Width = 43
              Color = clSkyBlue
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxThirdFileEntryChart: TColorBox
              Left = 133
              Height = 22
              Top = 135
              Width = 145
              Selected = clSkyBlue
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 5
            end
            object pnlFourthFileEntryChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 180
              Width = 43
              Color = clGreen
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFourthFileEntryChart: TColorBox
              Left = 133
              Height = 22
              Top = 195
              Width = 145
              Selected = clGreen
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 7
            end
          end
          object grpSelectedEntriesColorsChartMemComp: TGroupBox
            Left = 295
            Height = 248
            Top = 1
            Width = 281
            Caption = 'Selected entries (PFM, RAM, BFM, EBI, SQI)'
            ClientHeight = 228
            ClientWidth = 277
            ParentBackground = False
            TabOrder = 1
            object lblFirstFileSelectedEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 18
              Width = 41
              Caption = 'First file'
            end
            object lblSecondFileSelectedEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 78
              Width = 58
              Caption = 'Second file'
            end
            object lblThirdFileSelectedEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 138
              Width = 47
              Caption = 'Third file'
            end
            object lblFourthFileSelectedEntryColor: TLabel
              Left = 6
              Height = 15
              Top = 198
              Width = 54
              Caption = 'Fourth file'
            end
            object pnlFirstFileSelectedEntryChart: TPanel
              Left = 76
              Height = 43
              Hint = 'Double click to edit'
              Top = 0
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFirstFileSelectedEntryChart: TColorBox
              Left = 125
              Height = 22
              Top = 15
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 1
            end
            object pnlSecondFileSelectedEntryChart: TPanel
              Left = 76
              Height = 43
              Hint = 'Double click to edit'
              Top = 60
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxSecondFileSelectedEntryChart: TColorBox
              Left = 125
              Height = 22
              Top = 75
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 3
            end
            object pnlThirdFileSelectedEntryChart: TPanel
              Left = 76
              Height = 43
              Hint = 'Double click to edit'
              Top = 120
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxThirdFileSelectedEntryChart: TColorBox
              Left = 125
              Height = 22
              Top = 135
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 5
            end
            object pnlFourthFileSelectedEntryChart: TPanel
              Left = 76
              Height = 43
              Hint = 'Double click to edit'
              Top = 180
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxFourthFileSelectedEntryChart: TColorBox
              Left = 125
              Height = 22
              Top = 195
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 7
            end
          end
          object grpOverlapColorsChartMemComp: TGroupBox
            Left = 583
            Height = 248
            Top = 1
            Width = 145
            Caption = 'Overlapping areas'
            ClientHeight = 228
            ClientWidth = 141
            ParentBackground = False
            TabOrder = 2
            object rdgrpColorType: TRadioGroup
              Left = 6
              Height = 81
              Top = 10
              Width = 131
              AutoFill = True
              Caption = 'Color type'
              ChildSizing.LeftRightSpacing = 6
              ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
              ChildSizing.EnlargeVertical = crsHomogenousChildResize
              ChildSizing.ShrinkHorizontal = crsScaleChilds
              ChildSizing.ShrinkVertical = crsScaleChilds
              ChildSizing.Layout = cclLeftToRightThenTopToBottom
              ChildSizing.ControlsPerLine = 1
              ClientHeight = 61
              ClientWidth = 127
              ItemIndex = 0
              Items.Strings = (
                'Average color'
                'Selected color'
              )
              OnClick = rdgrpColorTypeClick
              ParentBackground = False
              TabOrder = 0
            end
            object pnlOverlap: TPanel
              Left = 12
              Height = 43
              Hint = 'Double click to edit'
              Top = 180
              Width = 43
              Color = clGray
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Visible = False
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxOverlap: TColorBox
              Left = 5
              Height = 22
              Top = 135
              Width = 132
              Selected = clGray
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 2
              Visible = False
            end
          end
        end
        object TabSheetChartMiscColors: TTabSheet
          Caption = 'Chart (Miscellaneous)'
          ClientHeight = 262
          ClientWidth = 743
          ImageIndex = 2
          object grpTextColorsChart: TGroupBox
            Left = 0
            Height = 130
            Top = 1
            Width = 288
            Caption = 'Text'
            ClientHeight = 110
            ClientWidth = 284
            ParentBackground = False
            TabOrder = 0
            object lblChartTextBackgroundColor: TLabel
              Left = 6
              Height = 15
              Top = 18
              Width = 64
              Caption = 'Background'
            end
            object lblChartTextColor: TLabel
              Left = 6
              Height = 15
              Top = 78
              Width = 62
              Caption = 'Foreground'
            end
            object pnlTextBackgroundChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 0
              Width = 43
              Color = clCream
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxTextBackgroundChart: TColorBox
              Left = 133
              Height = 22
              Top = 15
              Width = 145
              Selected = clCream
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 1
            end
            object pnlTextColorChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 60
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxTextColorChart: TColorBox
              Left = 133
              Height = 22
              Top = 75
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 3
            end
          end
          object grpLinesAndBackgroundColorsChart: TGroupBox
            Left = 303
            Height = 130
            Top = 1
            Width = 290
            Caption = 'Lines and background'
            ClientHeight = 110
            ClientWidth = 286
            ParentBackground = False
            TabOrder = 1
            object lblChartBackgroundColor: TLabel
              Left = 6
              Height = 15
              Top = 18
              Width = 64
              Caption = 'Background'
            end
            object ChartLineColor: TLabel
              Left = 6
              Height = 15
              Top = 78
              Width = 27
              Caption = 'Lines'
            end
            object pnlBackgroundChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 0
              Width = 43
              Color = clCream
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxBackgroundChart: TColorBox
              Left = 133
              Height = 22
              Top = 15
              Width = 145
              Selected = clCream
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 1
            end
            object pnlLineChart: TPanel
              Left = 84
              Height = 43
              Hint = 'Double click to edit'
              Top = 60
              Width = 43
              Color = clBlack
              ParentBackground = False
              ParentColor = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnDblClick = GenericColorPanelDblClick
            end
            object colboxLineChart: TColorBox
              Left = 133
              Height = 22
              Top = 75
              Width = 145
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
              ItemHeight = 16
              OnChange = colboxGenericChange
              TabOrder = 3
            end
          end
        end
      end
    end
    object TabSheetMiscSettings: TTabSheet
      Caption = 'Misc   '
      ClientHeight = 473
      ClientWidth = 866
      ImageIndex = 1
      object chkDisplayDecimalAddressesCmpTable: TCheckBox
        Left = 3
        Height = 19
        Top = 16
        Width = 254
        Caption = 'Display decimal addresses in Compare Table'
        Checked = True
        OnKeyUp = chkDisplayDecimalAddressesCmpTableKeyUp
        OnMouseUp = chkDisplayDecimalAddressesCmpTableMouseUp
        State = cbChecked
        TabOrder = 0
      end
      object chkDisplayTableHints: TCheckBox
        Left = 3
        Height = 19
        Top = 48
        Width = 116
        Caption = 'Display table hints'
        Checked = True
        OnKeyUp = chkDisplayTableHintsKeyUp
        OnMouseUp = chkDisplayTableHintsMouseUp
        State = cbChecked
        TabOrder = 1
      end
      object grpDevice: TGroupBox
        Left = 3
        Height = 249
        Top = 112
        Width = 174
        Caption = 'Device'
        ClientHeight = 229
        ClientWidth = 170
        ParentBackground = False
        TabOrder = 2
        object lblDeviceBitness: TLabel
          Left = 14
          Height = 15
          Top = 175
          Width = 75
          Caption = 'Device bitness'
        end
        object lbeDefaultChipName: TLabeledEdit
          Left = 14
          Height = 23
          Hint = 'Used when no chip is provided from cmdline. It should be prefixed by the full prefix name (e.g. "PIC" instead of "P"). Example: PIC32MX795F512L'
          Top = 26
          Width = 145
          EditLabel.Height = 15
          EditLabel.Width = 145
          EditLabel.Caption = 'Default chip name'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyUp = lbeDefaultChipNameKeyUp
        end
        object lbeDefFilePrefix: TLabeledEdit
          Left = 14
          Height = 23
          Hint = 'Example:  P32,  P24, P30, P33'
          Top = 82
          Width = 145
          EditLabel.Height = 15
          EditLabel.Width = 145
          EditLabel.Caption = 'Def file prefix'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnKeyUp = lbeDefFilePrefixKeyUp
        end
        object lbeExpectedPrefix: TLabeledEdit
          Left = 14
          Height = 23
          Hint = 'Example:  PIC32,  PIC24, PIC30, PIC33'
          Top = 138
          Width = 145
          EditLabel.Height = 15
          EditLabel.Width = 145
          EditLabel.Caption = 'Expected prefix'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnKeyUp = lbeExpectedPrefixKeyUp
        end
        object cmbDeviceBitness: TComboBox
          Left = 14
          Height = 22
          Hint = 'This has to match the architecture that MemStatistics is working with.'
          Top = 194
          Width = 145
          ItemHeight = 16
          Items.Strings = (
            '8-bit'
            '16-bit'
            '32-bit'
          )
          OnChange = cmbDeviceBitnessChange
          ParentShowHint = False
          ShowHint = True
          Style = csOwnerDrawFixed
          TabOrder = 3
        end
      end
      object grpDeviceDefinitions: TGroupBox
        Left = 320
        Height = 176
        Top = 16
        Width = 534
        Anchors = [akTop, akLeft, akRight]
        Caption = 'Device definitions'
        ClientHeight = 156
        ClientWidth = 530
        ParentBackground = False
        TabOrder = 3
        object lbeDefsFolder: TLabeledEdit
          Left = 6
          Height = 23
          Top = 32
          Width = 458
          Anchors = [akTop, akLeft, akRight]
          EditLabel.Height = 15
          EditLabel.Width = 458
          EditLabel.Caption = 'Defs folder'
          TabOrder = 0
          OnKeyUp = lbeDefsFolderKeyUp
        end
        object btnBrowseDefsFolder: TButton
          Left = 472
          Height = 25
          Top = 32
          Width = 27
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = btnBrowseDefsFolderClick
          TabOrder = 1
        end
        object rdgrpDefinitionFilePriority: TRadioGroup
          Left = 6
          Height = 76
          Top = 71
          Width = 185
          AutoFill = True
          Caption = 'Definition file priority'
          ChildSizing.LeftRightSpacing = 6
          ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
          ChildSizing.EnlargeVertical = crsHomogenousChildResize
          ChildSizing.ShrinkHorizontal = crsScaleChilds
          ChildSizing.ShrinkVertical = crsScaleChilds
          ChildSizing.Layout = cclLeftToRightThenTopToBottom
          ChildSizing.ControlsPerLine = 1
          ClientHeight = 56
          ClientWidth = 181
          ItemIndex = 0
          Items.Strings = (
            'Defs folder (mlk / json)'
            'Local device list (ini)'
          )
          OnClick = rdgrpDefinitionFilePriorityClick
          ParentBackground = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
      end
      object chkShowDefsFolderOnMainWindow: TCheckBox
        Left = 3
        Height = 19
        Top = 80
        Width = 201
        Caption = 'Show Defs folder on main window'
        OnKeyUp = chkShowDefsFolderOnMainWindowKeyUp
        OnMouseUp = chkShowDefsFolderOnMainWindowMouseUp
        TabOrder = 4
      end
    end
    object TabSheetMemorySections: TTabSheet
      Caption = 'Memory Sections   '
      ClientHeight = 473
      ClientWidth = 866
      ImageIndex = 2
      object spdbtnMoveUp: TSpeedButton
        Left = 250
        Height = 25
        Hint = 'Move up'
        Top = 445
        Width = 23
        Anchors = [akLeft, akBottom]
        Enabled = False
        Font.CharSet = SYMBOL_CHARSET
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
          B1224CB122FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        }
        OnClick = spdbtnMoveUpClick
        ShowHint = True
        ParentFont = False
        ParentShowHint = False
      end
      object spdbtnMoveDown: TSpeedButton
        Left = 279
        Height = 25
        Hint = 'Move down'
        Top = 445
        Width = 23
        Anchors = [akLeft, akBottom]
        Enabled = False
        Font.CharSet = SYMBOL_CHARSET
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
          B1224CB1224CB1224CB1224CB1224CB1224CB122FFFFFF000000
        }
        OnClick = spdbtnMoveDownClick
        ShowHint = True
        ParentFont = False
        ParentShowHint = False
      end
      object lblMemoryTranslationInfoOperation: TLabel
        Left = 136
        Height = 15
        Top = 275
        Width = 109
        Anchors = [akLeft, akBottom]
        Caption = 'Mem Translation Op'
      end
      object btnAdd: TButton
        Left = 0
        Height = 25
        Top = 445
        Width = 75
        Anchors = [akLeft, akBottom]
        Caption = 'Add'
        OnClick = btnAddClick
        TabOrder = 0
      end
      object btnDelete: TButton
        Left = 162
        Height = 25
        Top = 445
        Width = 75
        Anchors = [akLeft, akBottom]
        Caption = 'Delete...'
        OnClick = btnDeleteClick
        TabOrder = 2
      end
      object grpChartMemoryAllocation: TGroupBox
        Left = 440
        Height = 144
        Top = 279
        Width = 224
        Anchors = [akLeft, akBottom]
        Caption = 'Chart (Memory allocation) - Colors'
        ClientHeight = 124
        ClientWidth = 220
        ParentBackground = False
        TabOrder = 3
        object lblEntryColor: TLabel
          Left = 53
          Height = 15
          Top = 4
          Width = 59
          Caption = 'Entry Color'
        end
        object lblSelectedEntryColor: TLabel
          Left = 53
          Height = 15
          Top = 65
          Width = 106
          Caption = 'Selected Entry Color'
        end
        object pnlEntryChart: TPanel
          Left = 4
          Height = 43
          Hint = 'Double click to edit'
          Top = 8
          Width = 43
          Color = 5197823
          ParentBackground = False
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxEntryChart: TColorBox
          Left = 53
          Height = 22
          Top = 25
          Width = 130
          Selected = 5197823
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          OnChange = colboxGenericChange
          TabOrder = 1
        end
        object pnlSelectedEntryChart: TPanel
          Left = 4
          Height = 43
          Hint = 'Double click to edit'
          Top = 69
          Width = 43
          Color = clYellow
          ParentBackground = False
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxSelectedEntryChart: TColorBox
          Left = 53
          Height = 22
          Top = 86
          Width = 130
          Selected = clYellow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          OnChange = colboxGenericChange
          TabOrder = 3
        end
      end
      object grpTable: TGroupBox
        Left = 672
        Height = 144
        Top = 279
        Width = 192
        Anchors = [akLeft, akBottom]
        Caption = 'Table - Colors'
        ClientHeight = 124
        ClientWidth = 188
        ParentBackground = False
        TabOrder = 4
        object lblEntryColorTable: TLabel
          Left = 54
          Height = 15
          Top = 4
          Width = 59
          Caption = 'Entry Color'
        end
        object lblTextColorTable: TLabel
          Left = 54
          Height = 15
          Top = 65
          Width = 54
          Caption = 'Text Color'
        end
        object pnlEntryColorTable: TPanel
          Left = 4
          Height = 43
          Hint = 'Double click to edit'
          Top = 8
          Width = 43
          Color = 13158655
          ParentBackground = False
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxEntryColorTable: TColorBox
          Left = 54
          Height = 22
          Top = 25
          Width = 130
          Selected = 13158655
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          OnChange = colboxGenericChange
          TabOrder = 1
        end
        object pnlTextColorTable: TPanel
          Left = 4
          Height = 43
          Hint = 'Double click to edit'
          Top = 69
          Width = 43
          Color = clBlack
          ParentBackground = False
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnDblClick = GenericColorPanelDblClick
        end
        object colboxTextColorTable: TColorBox
          Left = 54
          Height = 22
          Top = 86
          Width = 130
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          ItemHeight = 16
          OnChange = colboxGenericChange
          TabOrder = 3
        end
      end
      object lbeDisplayName: TLabeledEdit
        Left = 3
        Height = 23
        Hint = 'Examples: PFM, RAM, BFM, CFG, EBI, SQI'
        Top = 296
        Width = 125
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 125
        EditLabel.Caption = 'Display Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnChange = GenericLabeledEditChange
      end
      object lbeLongDisplayName: TLabeledEdit
        Left = 3
        Height = 23
        Hint = 'Examples: Program Flash, RAM, Boot Flash, Config Flash, Ext Bus Interface, Ser Quad Interface'
        Top = 353
        Width = 125
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 125
        EditLabel.Caption = 'Long Display Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = GenericLabeledEditChange
      end
      object lbeDefinitionName: TLabeledEdit
        Left = 3
        Height = 23
        Hint = 'Examples: ROM, RAM, BOOTROM, CFGREG, EBIROM, SQIROM.   Comma separated values can be used, if multiple definition names are required for the same definition.'
        Top = 416
        Width = 125
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 125
        EditLabel.Caption = 'Definition Name'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = GenericLabeledEditChange
      end
      object lbeAddressOffsetS1: TLabeledEdit
        Left = 136
        Height = 23
        Hint = 'For PIC32, this can be 0x0, 0x20000000 or -0x20000000.   (-0x20000000 = 0xE0000000)'
        Top = 353
        Width = 137
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 137
        EditLabel.Caption = 'Address Offset S1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnChange = GenericLabeledEditChange
      end
      object lbeMinDefaultAddr: TLabeledEdit
        Left = 136
        Height = 23
        Hint = 'Physical address (hex), used when the section is not found in definition file.'
        Top = 416
        Width = 136
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 136
        EditLabel.Caption = 'Min Default Address'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnChange = GenericLabeledEditChange
      end
      object lbeAddressOffsetS2: TLabeledEdit
        Left = 279
        Height = 23
        Hint = 'For PIC32, this can be 0x0, 0x20000000 or -0x20000000.   (-0x20000000 = 0xE0000000)'
        Top = 353
        Width = 152
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 152
        EditLabel.Caption = 'Address Offset S2'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnChange = GenericLabeledEditChange
      end
      object lbeMaxDefaultAddr: TLabeledEdit
        Left = 279
        Height = 23
        Hint = 'Physical address (hex), used when the section is not found in definition file.'
        Top = 416
        Width = 152
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 152
        EditLabel.Caption = 'Max Default Address'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnChange = GenericLabeledEditChange
      end
      object lbeMemoryTranslationInfoValue: TLabeledEdit
        Left = 279
        Height = 23
        Top = 296
        Width = 152
        Anchors = [akLeft, akBottom]
        EditLabel.Height = 15
        EditLabel.Width = 152
        EditLabel.Caption = 'Mem Translation Value'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnChange = GenericLabeledEditChange
      end
      object cmbMemoryTranslationInfoOperation: TComboBox
        Left = 136
        Height = 22
        Top = 296
        Width = 137
        ItemHeight = 16
        ItemIndex = 0
        Items.Strings = (
          'None'
          'ADD'
          'OR'
        )
        OnChange = cmbMemoryTranslationInfoOperationChange
        Style = csOwnerDrawFixed
        TabOrder = 13
        Text = 'None'
      end
      object chkVisibleOnCompare: TCheckBox
        Left = 440
        Height = 19
        Top = 449
        Width = 121
        Anchors = [akLeft, akBottom]
        Caption = 'Visible on compare'
        Checked = True
        OnKeyUp = chkVisibleOnCompareKeyUp
        OnMouseUp = chkVisibleOnCompareMouseUp
        State = cbChecked
        TabOrder = 14
      end
      object chkDisplayEvenIfMissingFromDefinition: TCheckBox
        Left = 597
        Height = 19
        Hint = 'Display EBI and SQI columns, even if their sections are not present in the definition file (.mlk / .json).'
        Top = 449
        Width = 223
        Anchors = [akLeft, akBottom]
        Caption = 'Display even if missing from definition'
        Checked = True
        OnKeyUp = chkDisplayEvenIfMissingFromDefinitionKeyUp
        OnMouseUp = chkDisplayEvenIfMissingFromDefinitionMouseUp
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 15
      end
      object bitbtnUpdate: TBitBtn
        Left = 81
        Height = 25
        Top = 445
        Width = 75
        Anchors = [akLeft, akBottom]
        Caption = 'Update'
        OnClick = btnUpdateClick
        TabOrder = 1
      end
      object chkVisibleOnTable: TCheckBox
        Left = 440
        Height = 19
        Top = 428
        Width = 100
        Anchors = [akLeft, akBottom]
        Caption = 'Visible on table'
        OnKeyUp = chkVisibleOnTableKeyUp
        OnMouseUp = chkVisibleOnTableMouseUp
        TabOrder = 16
      end
      object lblDevWarning: TLabel
        Left = 0
        Height = 15
        Top = 40
        Width = 725
        Caption = 'Before compiling, please switch to another tab of this page control. There is a bug, which causes the application to hang if left on this tab.'
        Color = 8224255
        Transparent = False
        Visible = False
      end
    end
  end
  object ColorDialog1: TColorDialog
    Color = clBlack
    CustomColors.Strings = (
      'ColorA=000000'
      'ColorB=000080'
      'ColorC=008000'
      'ColorD=008080'
      'ColorE=800000'
      'ColorF=800080'
      'ColorG=808000'
      'ColorH=808080'
      'ColorI=C0C0C0'
      'ColorJ=0000FF'
      'ColorK=00FF00'
      'ColorL=00FFFF'
      'ColorM=FF0000'
      'ColorN=FF00FF'
      'ColorO=FFFF00'
      'ColorP=FFFFFF'
      'ColorQ=C0DCC0'
      'ColorR=F0CAA6'
      'ColorS=F0FBFF'
      'ColorT=A4A0A0'
    )
    Left = 536
  end
  object imglstMemSections: TImageList
    Height = 32
    Width = 32
    Left = 568
    Top = 184
    Bitmap = {
      4C7A0100000020000000200000001A0000000000000078DAEDC1010D000000C2
      A0F74F6D0F0714000000F06E10000001
    }
  end
  object tmrUpdate: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrUpdateTimer
    Left = 104
    Top = 464
  end
end
