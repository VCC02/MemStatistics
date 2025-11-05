object frmMemStatCompare: TfrmMemStatCompare
  Left = 129
  Height = 535
  Top = 156
  Width = 1149
  Caption = 'Memory Statistics - Visual Compare'
  ClientHeight = 535
  ClientWidth = 1149
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 1000
  Menu = mmCmpMain
  LCLVersion = '8.4'
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  object lblMinimap: TLabel
    Left = 1038
    Height = 19
    Top = 2
    Width = 55
    Anchors = [akTop, akRight]
    Caption = 'Minimap'
  end
  object lblSettingVisibility: TLabel
    Left = 559
    Height = 34
    Top = 178
    Width = 434
    Caption = 'Setting visibility. Please wait...'
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    ParentFont = False
  end
  object lblChipName: TLabel
    Left = 408
    Height = 19
    Top = 511
    Width = 118
    Anchors = [akLeft, akBottom]
    Caption = 'not selected '
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object lblChipNameText: TLabel
    Left = 292
    Height = 19
    Top = 511
    Width = 103
    Anchors = [akLeft, akBottom]
    Caption = 'Chip Name:'
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object spdbtnJumpToPrevSection: TSpeedButton
    Left = 1092
    Height = 18
    Hint = 'Jump to previous section'
    Top = 2
    Width = 23
    Anchors = [akTop, akRight]
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
    ShowHint = True
    ParentFont = False
    ParentShowHint = False
    OnClick = spdbtnJumpToPrevSectionClick
  end
  object spdbtnJumpToNextSection: TSpeedButton
    Left = 1119
    Height = 18
    Hint = 'Jump to next section'
    Top = 2
    Width = 23
    Anchors = [akTop, akRight]
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
    ShowHint = True
    ParentFont = False
    ParentShowHint = False
    OnClick = spdbtnJumpToNextSectionClick
  end
  object pnlMiniMap: TPanel
    Left = 1038
    Height = 457
    Hint = 'Hold Ctrl to select an entry.'
    Top = 48
    Width = 107
    Anchors = [akTop, akRight, akBottom]
    FullRepaint = False
    ParentBackground = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnMouseDown = pnlMiniMapMouseDown
    OnMouseMove = pnlMiniMapMouseMove
    OnResize = pnlMiniMapResize
  end
  object cmbCmpViewOptions: TComboBox
    Left = 0
    Height = 26
    Top = 507
    Width = 145
    Anchors = [akLeft, akBottom]
    AutoSize = False
    ItemHeight = 16
    ItemIndex = 0
    Items.Strings = (
      'Show all'
      'Show different'
      'Show same'
    )
    Style = csOwnerDrawFixed
    TabOrder = 1
    Text = 'Show all'
    OnChange = cmbCmpViewOptionsChange
  end
  object btnChangeDevice: TButton
    Left = 151
    Height = 25
    Top = 508
    Width = 122
    Anchors = [akLeft, akBottom]
    Caption = 'Change Device...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnChangeDeviceClick
  end
  object lbeSearchHexAddr: TLabeledEdit
    Left = 856
    Height = 25
    Hint = 'Search Hex address.'
    Top = 507
    Width = 65
    Anchors = [akRight, akBottom]
    EditLabel.Height = 19
    EditLabel.Width = 64
    EditLabel.Caption = 'Addr[Hex]'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = lbeSearchHexAddrChange
  end
  object lbeSearchData: TLabeledEdit
    Left = 968
    Height = 25
    Hint = 'Search Data. At least one slot has to match.'
    Top = 507
    Width = 65
    Anchors = [akRight, akBottom]
    EditLabel.Height = 19
    EditLabel.Width = 31
    EditLabel.Caption = 'Data'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnChange = lbeSearchDataChange
  end
  object lbeSearchNote: TLabeledEdit
    Left = 1080
    Height = 25
    Hint = 'Search user note.'
    Top = 507
    Width = 65
    Anchors = [akRight, akBottom]
    EditLabel.Height = 19
    EditLabel.Width = 31
    EditLabel.Caption = 'Note'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnChange = lbeSearchNoteChange
  end
  object pnlUpdatingTable: TPanel
    Left = 882
    Height = 25
    Top = 460
    Width = 129
    Anchors = [akRight, akBottom]
    Caption = 'Updating table...'
    Color = clYellow
    Font.Color = 179
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object imgUserNotes: TImage
    Left = 710
    Height = 16
    Top = 245
    Width = 16
    Picture.Data = {
      1754506F727461626C654E6574776F726B47726170686963BF00000089504E47
      0D0A1A0A0000000D494844520000001000000010080200000090916836000000
      09704859730000000000000000009D6226320000000674524E5300FF00FF00FF
      37581B7D0000005F49444154789C63F84F2260204783D2461F221142C3D667B2
      87510150040DA16BA847058435401056A5583430C00050039084A88030E052E8
      3640A421364054C0CD86B0F16940F306610DA4D980E6079C1A480B2572E281B4
      98262D2D9104002372D399750B87A00000000049454E44AE426082
    }
    Visible = False
  end
  object spdbtnJumpToPrevDifference: TSpeedButton
    Left = 1092
    Height = 18
    Hint = 'Jump to previous difference'
    Top = 24
    Width = 23
    Anchors = [akTop, akRight]
    Font.CharSet = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Webdings'
    Font.Style = [fsBold]
    Glyph.Data = {
      9E010000424D9E0100000000000036000000280000000F000000060000000100
      2000000000006801000000000000000000000000000000000000FFFFFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFFFFFFFFFFFFFFFFFFFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
      FFFF277FFFFF277FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277F
      FFFF277FFFFF277FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF
    }
    ShowHint = True
    ParentFont = False
    ParentShowHint = False
    OnClick = spdbtnJumpToPrevDifferenceClick
  end
  object spdbtnJumpToNextDifference: TSpeedButton
    Left = 1119
    Height = 18
    Hint = 'Jump to next difference'
    Top = 24
    Width = 23
    Anchors = [akTop, akRight]
    Font.CharSet = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Webdings'
    Font.Style = [fsBold]
    Glyph.Data = {
      9E010000424D9E0100000000000036000000280000000F000000060000000100
      2000000000006801000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277FFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF277FFFFF277FFFFF277FFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
      FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFFFFFF
      FFFF
    }
    ShowHint = True
    ParentFont = False
    ParentShowHint = False
    OnClick = spdbtnJumpToNextDifferenceClick
  end
  object mmCmpMain: TMainMenu
    Left = 192
    Top = 72
    object Compare1: TMenuItem
      Caption = 'Compare'
      OnClick = Compare1Click
      object Loadsettingsfromfile1: TMenuItem
        Caption = 'Load settings...'
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF00A6DD00A6DD00A6DD00A6DD00A6DD00A6DD00A6DD00A6DD00A6DD00A6
          DDFFFFFFFFFFFFFFFFFFFFFFFFC9AEFF00A6DD277FFF277FFF277FFF277FFF27
          7FFF277FFF277FFF277FFF277FFF277FFF00A6DDFFFFFFFFFFFFFFFFFF00A6DD
          00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9
          FF277FFF00A6DDFFFFFFFFFFFF00A6DD00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0E
          C9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF277FFF00A6DDFFFFFFFFFFFF00A6DD
          00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9
          FF277FFF00A6DDFFFFFFFFFFFF00A6DD00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0E
          C9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF277FFF00A6DDFFFFFFFFFFFF00A6DD
          00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9
          FF277FFF00A6DDFFFFFFFFFFFF00A6DD00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0E
          C9FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF277FFF00A6DDFFFFFFFFFFFF00A6DD
          00F2FF0EC9FF0EC9FF0EC9FF0EC9FF0EC9FF00F2FF00F2FF00F2FF00F2FF00F2
          FF00A6DD00A6DDFFFFFFFFFFFF00A6DD00F2FF0EC9FF0EC9FF00F2FF00F2FF00
          A6DD00A6DD00A6DD00A6DD00A6DD00A6DD00A6DDFFFFFFFFFFFFFFFFFF00A6DD
          00F2FF00F2FF00F2FF00A6DD00A6DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00A6DD00A6DD00A6DD00A6DDFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        }
        OnClick = Loadsettingsfromfile1Click
      end
      object Savesettingstofile1: TMenuItem
        Caption = 'Save settings'
        Bitmap.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFF3F3F1FFEFE6
          DDFFE3D0C0FFEBDED3FFFCFAF9FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFBFFFBF7
          F5FFF1F0E8FFE5EADBFFD9E4CDFFBDD0AAFFA3BF89FF83AA63FF809D55FFAB8C
          5FFFB78358FFC69C79FFF0E4DCFFFEFDFDFFFFFFFFFFFFFFFFFFD5BDABFFC9A2
          84FFA8A271FF7DA85EFF6CA651FF70AD5CFF7CB76DFF89C382FF9ACE98FFB4B8
          93FFBE966DFFC08E64FFE0C9B6FFFAF8F5FFFFFFFFFFFFFFFFFFBE9576FFAF75
          46FF9F925CFF88B876FF87C683FF8ACB8AFF8CCB8CFF8DCB8DFF8CCB8CFF9EBE
          8BFFB69B6FFFC08E62FFD6B79FFFF6EEEAFFFFFFFFFFFFFFFFFFC4A993FFBF8D
          63FFB89970FF99BD85FF72C071FF67BF67FF64BE64FF62BD62FF61BC61FF78BB
          6FFF9EA069FFBB8B5EFFC89D7AFFE8D8CBFFFFFFFFFFFFFFFFFFCFC3B9FFCBA5
          84FFBA8D61FFAAA879FF86C17EFF72BA6AFF75B566FF79AF62FF7DA95FFF89A0
          5CFFA2925CFFBD8C5FFFC39166FFD6B79EFFFBF9F7FFFFFFFFFFFBF8F6FFDCC3
          AEFFBD8A5EFFB68F62FF9F9963FF989356FFA49159FFB18F5CFFBB8E5EFFC390
          63FFC79467FFCB9A6DFFCA996CFFC9A07DFFEDE2DAFFFFFFFFFFFEFEFEFFF1E7
          E0FFC89E7AFFC59264FFCC9C6FFFCE9E70FFCB9B6DFFC9976AFFC79568FFC593
          67FFC39269FFC09169FFBF8E64FFC39064FFD4B69EFFFDFBFBFFFFFFFFFFF4F0
          EEFFD9BEA7FFC39064FFC59265FFBE8C60FFC5845EFFC69877FFC8A588FFCEB1
          9AFFD4BDABFFDAC8BAFFC7A387FFC28F63FFC69D7AFFF2EAE3FFFFFFFFFFFFFF
          FFFFEDE1D7FFC3956FFFBC895EFFCDAC95FFE89E96FFEBABA6FFEADEDBFFECEA
          E9FFEDECECFFEDEDECFFDAC9BCFFC3946EFFC18F66FFDDC5B0FFFFFFFFFFFFFF
          FFFFF8F3F0FFD3B298FFBF8C61FFC8A486FFE8C4BDFFF69C9CFFF1D3D3FFEEEE
          EEFFEEEEEEFFEEEEEEFFE6E0DAFFCAA98DFFBD885CFFCAA181FFFFFFFFFFFFFF
          FFFFFDFCFCFFEADCD1FFC69974FFBF8E67FFD4BBA8FFE9A39CFFE7A49CFFDCC3
          B7FFD3BCABFFCCAD96FFC49E81FFC09676FFCBA78AFFDDC6B3FFFFFFFFFFFFFF
          FFFFFFFFFFFFF7F0ECFFD0AE93FFB8855CFFBF9370FFCB9A7FFFCE997FFFCCA7
          8DFFD3B49DFFDCC5B3FFE6D5C8FFEAE0D7FFF7F1EDFFFBF8F6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFDFCFCFFF3EBE4FFE9DBCFFFE8D9CDFFEDDFD5FFF4EBE5FFF8F4
          F1FFFDFBF9FFFDFCFBFFFEFDFDFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        }
        OnClick = Savesettingstofile1Click
      end
      object SaveAsSettings1: TMenuItem
        Caption = 'Save settings as...'
        OnClick = SaveAsSettings1Click
      end
      object Recentsettings1: TMenuItem
        Caption = 'Recent settings'
        Enabled = False
        Visible = False
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuItem_ShowSimulatedMemory: TMenuItem
        Caption = 'Show simulated memory'
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000CCEDF4B0E4EF
          B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4
          EFB0E4EFB0E4EFCCEDF4B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0
          E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EF
          B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4
          EFB0E4EFB0E4EFB0E4EF16C99C16C99C16C99C16C99C16C99C16C99C16C99C16
          C99C16C99C16C99C16C99C16C99C16C99C16C99C16C99C16C99C4CB1224CB122
          3ED3FF4CB1224CB1223ED3FF4CB1224CB1223ED3FF4CB1224CB1223ED3FF4CB1
          224CB1223ED3FF4CB1224CB12256C6263ED3FF56C62656C6263ED3FF56C62656
          C6263ED3FF56C62656C6263ED3FF56C62656C6263ED3FF4CB1224CB12256C626
          56C62656C62656C62656C62656C62656C62656C62656C62656C62656C62656C6
          2656C62656C6264CB1224CB12256C62656C62656C62656C62656C62656C62656
          C62656C62656C62656C62656C62656C62656C62656C6264CB1224CB12256C626
          61616161616156C62661616161616156C62661616161616156C6266161616161
          6156C62656C6264CB1224CB12256C62661616161616156C62661616161616156
          C62661616161616156C62661616161616156C62656C6264CB1224CB12256C626
          61616161616156C62661616161616156C62661616161616156C6266161616161
          6156C62656C6264CB1224CB12256C62656C62656C62656C62656C62656C62656
          C62656C62656C62656C62656C62656C62656C62656C6264CB1224CB1224CB122
          4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1
          224CB1224CB1224CB122B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0
          E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EF
          B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4
          EFB0E4EFB0E4EFB0E4EFCCEDF4B0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0
          E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFB0E4EFCCEDF4
        }
        OnClick = MenuItem_ShowSimulatedMemoryClick
      end
    end
    object File1: TMenuItem
      Caption = 'File Slot1'
      object LoadHEX1: TMenuItem
        Caption = 'Load HEX...'
        OnClick = LoadHEX1Click
      end
      object LoadHEXFromMainWindow1: TMenuItem
        Caption = 'Load HEX From Main Window'
        OnClick = LoadHEXFromMainWindow1Click
      end
      object LoadListing1: TMenuItem
        Caption = 'Load Listing...'
        Enabled = False
        Visible = False
      end
      object CloseHEX1: TMenuItem
        Caption = 'Close HEX'
        OnClick = CloseHEX1Click
      end
      object CloseListing1: TMenuItem
        Caption = 'Close Listing'
        Enabled = False
        Visible = False
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ReloadHEX1: TMenuItem
        Caption = 'Reload HEX'
        OnClick = ReloadHEX1Click
      end
      object ReloadListing1: TMenuItem
        Caption = 'Reload Listing'
        Enabled = False
        Visible = False
      end
      object ReloadBoth1: TMenuItem
        Caption = 'Reload Both'
        Enabled = False
        Visible = False
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MenuItem_Erase1: TMenuItem
        Caption = 'Erase'
        OnClick = MenuItem_Erase1Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MenuItem_LoadRoutinesFromMainWindow1: TMenuItem
        Caption = 'Load Routines From Main Window'
        OnClick = MenuItem_LoadRoutinesFromMainWindow1Click
      end
    end
    object FileSlot11: TMenuItem
      Caption = 'File Slot2'
      object LoadHEX2: TMenuItem
        Caption = 'Load HEX...'
        OnClick = LoadHEX2Click
      end
      object LoadHEXFromMainWindow2: TMenuItem
        Caption = 'Load HEX From Main Window'
        OnClick = LoadHEXFromMainWindow2Click
      end
      object LoadListing2: TMenuItem
        Caption = 'Load Listing...'
        Enabled = False
        Visible = False
      end
      object CloseHEX2: TMenuItem
        Caption = 'Close HEX'
        OnClick = CloseHEX2Click
      end
      object CloseListing2: TMenuItem
        Caption = 'Close Listing'
        Enabled = False
        Visible = False
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object ReloadHEX2: TMenuItem
        Caption = 'Reload HEX'
        OnClick = ReloadHEX2Click
      end
      object ReloadListing2: TMenuItem
        Caption = 'Reload Listing'
        Enabled = False
        Visible = False
      end
      object ReloadBoth2: TMenuItem
        Caption = 'Reload Both'
        Enabled = False
        Visible = False
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MenuItem_Erase2: TMenuItem
        Caption = 'Erase'
        OnClick = MenuItem_Erase2Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object MenuItem_LoadRoutinesFromMainWindow2: TMenuItem
        Caption = 'Load Routines From Main Window'
        OnClick = MenuItem_LoadRoutinesFromMainWindow2Click
      end
    end
    object FileSlot31: TMenuItem
      Caption = 'File Slot3'
      object LoadHEX3: TMenuItem
        Caption = 'Load HEX...'
        OnClick = LoadHEX3Click
      end
      object LoadHEXFromMainWindow3: TMenuItem
        Caption = 'Load HEX From Main Window'
        OnClick = LoadHEXFromMainWindow3Click
      end
      object LoadListing3: TMenuItem
        Caption = 'Load Listing...'
        Enabled = False
        Visible = False
      end
      object CloseHEX3: TMenuItem
        Caption = 'Close HEX'
        OnClick = CloseHEX3Click
      end
      object CloseListing3: TMenuItem
        Caption = 'Close Listing'
        Enabled = False
        Visible = False
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object ReloadHEX3: TMenuItem
        Caption = 'Reload HEX'
        OnClick = ReloadHEX3Click
      end
      object ReloadListing3: TMenuItem
        Caption = 'Reload Listing'
        Enabled = False
        Visible = False
      end
      object ReloadBoth3: TMenuItem
        Caption = 'Reload Both'
        Enabled = False
        Visible = False
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MenuItem_Erase3: TMenuItem
        Caption = 'Erase'
        OnClick = MenuItem_Erase3Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MenuItem_LoadRoutinesFromMainWindow3: TMenuItem
        Caption = 'Load Routines From Main Window'
        OnClick = MenuItem_LoadRoutinesFromMainWindow3Click
      end
    end
    object FileSlot41: TMenuItem
      Caption = 'File Slot4'
      object LoadHEX4: TMenuItem
        Caption = 'Load HEX...'
        OnClick = LoadHEX4Click
      end
      object LoadHEXFromMainWindow4: TMenuItem
        Caption = 'Load HEX From Main Window'
        OnClick = LoadHEXFromMainWindow4Click
      end
      object LoadListing4: TMenuItem
        Caption = 'Load Listing...'
        Enabled = False
        Visible = False
      end
      object CloseHEX4: TMenuItem
        Caption = 'Close HEX'
        OnClick = CloseHEX4Click
      end
      object CloseListing4: TMenuItem
        Caption = 'Close Listing'
        Enabled = False
        Visible = False
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ReloadHEX4: TMenuItem
        Caption = 'Reload HEX'
        OnClick = ReloadHEX4Click
      end
      object ReloadListing4: TMenuItem
        Caption = 'Reload Listing'
        Enabled = False
        Visible = False
      end
      object ReloadBoth4: TMenuItem
        Caption = 'Reload Both'
        Enabled = False
        Visible = False
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MenuItem_Erase4: TMenuItem
        Caption = 'Erase'
        OnClick = MenuItem_Erase4Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MenuItem_LoadRoutinesFromMainWindow4: TMenuItem
        Caption = 'Load Routines From Main Window'
        OnClick = MenuItem_LoadRoutinesFromMainWindow4Click
      end
    end
  end
  object imglstHeaderVSTSlots: TImageList
    BlendColor = clWhite
    BkColor = clBlack
    Height = 24
    Width = 48
    Left = 64
    Top = 56
    Bitmap = {
      4C7A040000003000000018000000AA0400000000000078DAED9AFD53545518C7
      77615DA185057931E35D2D1D46880444B6121C905D1A585EAC2073186C06D86A
      042AA60251790904111461315E161D2B13C237062749C4948178C92695498566
      1AB3661AFB01FE846FF75E07DCC3DD4D2CCFB6B73967E6FBC39EBDF79CCF7DEE
      73CEBDF73B8F4C46AF3929C3B174492864126DB6E0F7F274C597EDF9A2390E56
      652124D85FE87F551F85931DF922C9E57264656C4265F1EBC4F92F6F5C8B8EC6
      5C2C738B16F8D78706A1AEFC4D8BD711E8E785E6DA1D18BBF809C639F12C99E9
      1AAC0A5C6E714E5EE663F9FB78E2FE9D56D1D863DF542246132CF47FB8335918
      57B3E1394272990C1EEE2EF869E400F4BA70E158272725C607AAB0FDB5973017
      FF84CDA1B8DAB7573487B3B3123F5EA941A121113E2B9621C0D70B6F6CD5A0B3
      C900956AE9FC3CB95971981CAE9BFF1D1612F8D8FC87F7655BCD039EEFC6D07E
      B8A99FC2EEA2741C6F7907E6F9638D3F226C256E8F3588FA1DB8FB6AFEFBC5A8
      35B836586D71FE07FC6D30ECD842E8F6683DC1DFDF53223A466E364F534D36BA
      3A0AB878D6C29BCBC9C5F0BBBA38E3E7EF0F09F917F1C22AB8A89C2C323E8AFF
      CFA93694BC974A686AE220C1FF6DEF1ED131E6FC2B03BC85714A3F48C3C2F56B
      8D9F6FCFAF0BC06747DEC53437DF1FB73EC5A5B3A5888F0979CCF8FFBBFCE15B
      E7E13C18F7BF853BE30DE0D7E462F9CDDB8AE5EEC8CFD5E1D71BCD50BB3AC356
      FC1969D118FEBA1CCA250A7C5C9882739F1709F7E651FC3CA35C2E23FA1D1D1C
      F0DB4D2302FDBD9F287FCFD1426C890D21C4CFEDE7E381692E87A3C2570BC72A
      950A8C5CA880213B9EE0FFE1F23EE2DCB84DEB90181786F3273F427AF206AC0E
      7A9ADBAFFD505FB15DB8FEC5E68FA7870BB757E789FEABDE9D89E035BE427F4A
      62044C5C7E2C141FE31C6E6F2BC84B24CE8FE4D6229F4B73FB3F9FE30BCF6D6D
      C881BB9B0A3B7374E8321560E87C19FABF2AC6AEF75345EB78EDB3CFA076EF36
      FC1F9FBF8C9FF1337EC6CFF8193FE367FC8C9FF133FF87F93FCCFF61FE0FF37F
      98FFC3FC1FFBF57F140A05B7CFAB447274748414DE1FD27491B83E588089E11A
      42A70F69A156AB61EFFCE9DA305C9EECC3B9DF670935E7C5C25496FC9F5FC33F
      E53F51F60A4C455A9C6AD44B82FF8BC9599846499DFA65161357AB24C1DF3E32
      83FA5E525D53D2E1AF3B33836223A9EE69E9F02FCCFF39B1F8DB869F5FAF2D83
      A4CEDE93D2FAE5F6FC015252E19FF8AE02576E9EB6A8EB03F976CD1F14E08B24
      EE1DD49AF4BA68BBE667FE0FF37F98FFC3FC1FE6FF30FF87F93FCCFFB1B7F787
      6DFA7098AA133869E7D559158FA4F8F59002FF9E5C2E3FEFDE25BEE9FAA7AFA1
      AF722352B491902AFFDBB15BD1BD2B06FA84BFBF067BE4EFBD771F976E0D08EA
      31A64A82BFEA04F96D5DD2328333DCF75DF7914C49F01BB9EFE9C60B0FD574F1
      C1BD900A7FC7E82C5A871EAA7D585AFC65C7C8FC296D9B9114BF357F4C2AFCA5
      AD64FCCB8FB1F8DBA2652445A0B9249A93C6A28A0D9BED9A9FF93FCCFF61FE0F
      F37F98FFC3FC1FE6FF30FFC7DE9EBFB4EB7F68FB3FB4EB7F68FB3FB4EB7F68FB
      3FB4EB7F68FB3FB4EB7F68FB3FB4EB7F68FB3FB4EB4F68FB3FB4EB7F68FB3FB6
      8A3F2DFF8176FD0F6DFF8776FD8F2DE24FB3FE87B6FFF324EA7FFE026BEFCA80
    }
  end
  object OpenDialogHex: TOpenDialog
    Filter = 'PIC32 Hex Files (*.hex)|*.hex|All Files (*.*)|*.*'
    Left = 896
    Top = 112
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrStartupTimer
    Left = 448
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 488
    Top = 136
  end
  object pmimgMinimap: TPopupMenu
    Left = 1056
    Top = 224
    object SaveImageToFile: TMenuItem
      Caption = 'Save image to file...'
      OnClick = SaveImageToFileClick
    end
    object Copyimagetoclipboard1: TMenuItem
      Caption = 'Copy image to clipboard'
      OnClick = Copyimagetoclipboard1Click
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 1056
    Top = 184
  end
  object OpenDialogSettings: TOpenDialog
    Filter = 'MemStat comparision settings (*.memcmp)|*.memcmp|All Files (*.*)|*.*'
    Left = 896
    Top = 152
  end
  object SaveDialogSettings: TSaveDialog
    Filter = 'MemStat comparision settings (*.memcmp)|*.memcmp|All Files (*.*)|*.*'
    Left = 936
    Top = 152
  end
  object tmrHideUpdatingTable: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrHideUpdatingTableTimer
    Left = 960
    Top = 352
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrSearchTimer
    Left = 864
    Top = 352
  end
  object tmrEditingUserNotes: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrEditingUserNotesTimer
    Left = 448
    Top = 176
  end
  object tmrRepaintMinimapOnSelect: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrRepaintMinimapOnSelectTimer
    Left = 448
    Top = 216
  end
  object tmrDrawZoom: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrDrawZoomTimer
    Left = 180
    Top = 220
  end
end
