object frmSimulatedMem: TfrmSimulatedMem
  Left = 43
  Height = 363
  Top = 57
  Width = 972
  Caption = 'Memory Statistics - Simulated Memory'
  ClientHeight = 363
  ClientWidth = 972
  Color = clBtnFace
  Constraints.MinHeight = 363
  Constraints.MinWidth = 972
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  LCLVersion = '8.4'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  object lblCompareWindow: TLabel
    Left = 303
    Height = 13
    Top = 0
    Width = 84
    Caption = 'Compare Window'
  end
  object lblSlot: TLabel
    Left = 454
    Height = 13
    Top = 0
    Width = 18
    Caption = 'Slot'
  end
  object lblAllReceivedCommands: TLabel
    Left = 8
    Height = 13
    Top = 89
    Width = 177
    AutoSize = False
    Caption = 'All received commands:'
  end
  object btnSendAllCmdToCompareWindow: TButton
    Left = 712
    Height = 25
    Hint = 'Decode received commands and apply them to the simulated memory (selected slot).'
    Top = 47
    Width = 256
    Anchors = [akTop, akRight]
    Caption = 'Send all commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnSendAllCmdToCompareWindowClick
  end
  object btnLoadHEXFromMainWindow: TButton
    Left = 384
    Height = 25
    Hint = 'This loads a hex file in the selected "Compare window".'
    Top = 47
    Width = 177
    Caption = 'Load HEX from main window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnLoadHEXFromMainWindowClick
  end
  object btnLoadHEX: TButton
    Left = 303
    Height = 25
    Hint = 'This loads a hex file in the selected "Compare window".'
    Top = 47
    Width = 75
    Caption = 'LoadHEX...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnLoadHEXClick
  end
  object cmbCompareWindow: TComboBox
    Left = 303
    Height = 22
    Top = 16
    Width = 145
    AutoSize = False
    DropDownCount = 10
    ItemHeight = 16
    Style = csOwnerDrawFixed
    TabOrder = 3
    OnChange = cmbCompareWindowChange
  end
  object cmbSlots: TComboBox
    Left = 454
    Height = 22
    Top = 16
    Width = 107
    AutoSize = False
    DropDownCount = 10
    ItemHeight = 16
    Style = csOwnerDrawFixed
    TabOrder = 4
  end
  object btnClearListOfCommands: TButton
    Left = 568
    Height = 25
    Top = 16
    Width = 140
    Caption = 'Clear list of commands'
    TabOrder = 5
    OnClick = btnClearListOfCommandsClick
  end
  object btnTestFIFOAndDecoder: TButton
    Left = 568
    Height = 25
    Hint = 'Sends some dummy data to the simulated memory, as if received from COM port.'
    Top = 47
    Width = 140
    Caption = 'Test FIFO and decoder'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnTestFIFOAndDecoderClick
  end
  object grpReceivedDeviceInfo: TGroupBox
    Left = 712
    Height = 161
    Hint = 'Info updated on sending commands to compare window'
    Top = 141
    Width = 256
    Anchors = [akTop, akRight]
    Caption = 'Received device info  (sizes are in bytes)'
    ClientHeight = 143
    ClientWidth = 252
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    object lblDevicePointerSize: TLabel
      Left = 8
      Height = 13
      Top = 8
      Width = 240
      AutoSize = False
      Caption = 'Pointer size:'
    end
    object lblProgramFlashSize: TLabel
      Left = 8
      Height = 13
      Top = 35
      Width = 240
      AutoSize = False
      Caption = 'Program flash size:'
    end
    object lblBootFlashSize: TLabel
      Left = 8
      Height = 13
      Top = 62
      Width = 240
      AutoSize = False
      Caption = 'Boot flash size:'
    end
    object lblWriteSize: TLabel
      Left = 8
      Height = 13
      Top = 89
      Width = 240
      AutoSize = False
      Caption = 'Write size:'
    end
    object lblEraseSize: TLabel
      Left = 8
      Height = 13
      Top = 116
      Width = 240
      AutoSize = False
      Caption = 'Erase size:'
    end
  end
  object chkAutoSendCommandsToCmpWindow: TCheckBox
    Left = 712
    Height = 19
    Hint = 'If checked, all recent commands are sent to the simulated memory (selected slot on compare window).'
    Top = 83
    Width = 256
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Autosend commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
  end
  object chkAppendUserNotesOnCmpWindow: TCheckBox
    Left = 712
    Height = 19
    Top = 108
    Width = 256
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Append user notes on cmp window'
    TabOrder = 9
  end
  object btnDisplayCompareWindow: TButton
    Left = 568
    Height = 25
    Top = 77
    Width = 140
    Caption = 'Display cmp window'
    TabOrder = 10
    OnClick = btnDisplayCompareWindowClick
  end
  object btnSendSelectedCommands: TButton
    Left = 712
    Height = 25
    Hint = 'Decode received commands and apply them to the simulated memory (selected slot).'
    Top = 16
    Width = 256
    Anchors = [akTop, akRight]
    Caption = 'Send selected commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnSendSelectedCommandsClick
  end
  object chkAutoScrollToSelectedCommands: TCheckBox
    Left = 303
    Height = 17
    Hint = 'When checked, clicking on one or more commands, on the list, will scroll to the first selected one in compare window.'
    Top = 83
    Width = 174
    Caption = 'Autoscroll to selected commands'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
  end
  object lbeSearchCommand: TLabeledEdit
    Left = 712
    Height = 21
    Top = 328
    Width = 256
    Anchors = [akTop, akRight]
    EditLabel.Height = 13
    EditLabel.Width = 256
    EditLabel.Caption = 'Search command'
    TabOrder = 13
    OnChange = lbeSearchCommandChange
  end
  object pnlCOMUI: TPanel
    Left = 0
    Height = 90
    Top = 0
    Width = 301
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 14
  end
  object tmrReadFIFO: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrReadFIFOTimer
    Left = 104
    Top = 120
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrStartupTimer
    Left = 48
    Top = 120
  end
  object imglstCmds: TImageList
    Left = 388
    Top = 156
    Bitmap = {
      4C7A080000001000000010000000290A00000000000078DAED977B50537716C7
      2F8895D66DEB76850051AB82E25416516AB55AEDF4B16DAD9D71DB5A1FDB760B
      D80622616C6B77D5561E0ABA58E9DA2E95888EB6EE8C6D155979C92340240948
      05B40B2290078F8480940442142460E0BBBF7B63109A5C48B4FB5F7F77BE933B
      B9F9FC7EE79CDF3937BF435114B5EA0B2E683D720970E69E1AC5DE0B3F5A1DFF
      A69CD2E8F968D1DFC964328744FFD6CA8D5E9F7E465C82F85F1F4EC8DBB39F7E
      46B3CEF0BFB6FD8EF26CF63BCBFF66FFFDE5EFFDD60F759FF54B0FDCE3606387
      8787EE754AB4199548D2C7E084EE10B4DDF50E73B707FB715EF71D220778B05E
      11E60F90AC4B805C5F89E121769B5A0CB588EFD9091ECB153EC443A2FE535CD1
      5DC09079700C6BD46B11265E09FECD50567EF415D7BD1D65BA5C0C0EF4317C9F
      A113CB84AE589DFA20361705636BD7BB13CEB1B56E23423E5FCDF0A65E03560A
      272338956244DF6FCA0940A476B30DC7BF198657BF09C6D4703778F01F8279D0
      04F3403F9E174E1DE1AD7A5AE8868D69FE8852BE05DE300F6F57ACC5AC4FA681
      E2518CDC78AEC4F77666AF5F4979D486B76AB970125E88F7C1249ECB084BCB85
      48A1AA627CD87474362B4F6BC1AE296358AB4AAA322D31ECEDC229D95EAC3DE6
      69970F8CB1E58376CD834A5D33662FFB6F19915E9E8475C7B963F827E3EFF20F
      F3DD91941E8D01531F6B3E0D987A9155918CF5272C7EAD487467FC5D77E03934
      B55E732AA745578E637BEA0A9C939EB49BC30ED5EFF0306BFDCE6C3FEF748D9E
      AD6E845B6A152367C6AD9BC631AC33BC41DF8177BECDC464E125A7F9EBDA66FC
      E9580E26255F04F5D97F401D9282222C35114FE226AB28C7FC2345A0924A40ED
      38032A3E8F704AA25AB88EC30FDD1EC40F45C5782C450A97C4220BFB0FF299DA
      04EA683BDC8557107D26CBFEBE939AFC22330FBF3B52062A21CFC21E9410B699
      A80DD3843FE2585E016E9BFA6DD83E6337FEF67D36895305A83D39A0FE7E1AD4
      3F89DFA96AB8A4B662668A0485174B6D7389F8AA6E515AE244B3BB499C769E05
      75F8BF84D512B6194B8FE4A15125B76BF34FB5D55890920F97E472C2A5113E03
      94B096B1D795C4EBCFC733A1BBDE6A97BD7CF947700F6683FA52666163B3401D
      69206C3B1E3C720DDB893F37895FF6B768187B4E111FF71558D8F8DC3BFBD38E
      29C26A7C95791E03FDECB53A78AB17BBA3FE42D623F910476C3854C9B00F1CB9
      4AF6271B83E3B0F468975F61785A93483EB82688F0589204270B0A981C986854
      667F8BB5AB1623E29DB5CC1CD1A7D250585282A121B3C3FFC1C60E356E197416
      86A5D6ED0DBAF64D2693432A9617A3BD5363F33DE5C028524B10A4DD8F0D7507
      D16DFCD921C63A8AD5520469F66141DB7ECC57EFC5FA8A04188C9D0ECD51A229
      C5E29604F86BF7615ECB5ECC946CC38C6201DE94C6A2E7868E750E12446434E6
      23A0251EF335F1F055C5628628125CB1005EE961E04AA2F0A274173AF4ADB0C7
      663516E089A63DCC9ABECA18700BF8E01645C22B2D143EE24878976DC352F147
      505D6FB0E1B39B4458A88A835FF31ECC5544C3273F023E84E79C098177211FDE
      B22804177D0879DB351B36575588858A58F835C6614EFD6E78E78633E2FCF01E
      3805E1F09208102812A0415B6BC3EA3A5BB0A46A27E634EC66E423E2C32B630B
      386743E199F53E38255BE147ECB8A82CB31BB721F36D08B236606EE5C78C8F9C
      74C2A585C0E35C183CC57CF8E645A05421638DB9E8AA104B2B5CF0724E306611
      3B3D33B7607A3AE10B2330E73C0F52B984953574B7E235990782ABC87F75A50B
      5ECA584262158EE9221E1ECFD9820BF5E271F325E5129F61AD7AEA922BDEF87E
      0D7CB2C370FAF259FA2DC3CA2BD5A578A6FC8111F6D98BEE3859B5839CCB7A50
      AD281F97656C376A115216C0D82D902E43B3B6C2A9FAA047578F06F9355F93F3
      82C969967E0F7850898CE8DEC099FBD1ECBDF0A3E56CFF347A3E6BFF161B1BEB
      9046F76FA3D7A79F59FBFF89787BF6D3CFACFDBFA3FCAF6DBFA33C9BFDCEF2BF
      D97F7FF97BBFF573BFF59BA135DC73AFCEC60E0F0DDF7BFFAF342229468F1387
      74D0D6773BDE2BF50FE2FC773A44F206C0E38151C407662427E820AFD48FDFFF
      D71A10BFB36784FBA5C2794348FC548F2B17C8196B70ECB9CCA8D5236CA518FC
      D09BACFC68C56DEF4659AE0E837D0396F37AA701CB5C8558FD602A36071761EB
      BB5D13CEB175631D42567F6EE9FF0DBD58395988602A95117DBF292007919BB5
      361C3FEC265E0DFE0653DDC2E1F1101F66D320CCFD03787EEA5DDEAAA7DD84D8
      E89F86A8B794841DC6DB6B2B306BDA27E4FDC863E4E6CA83B15DCFECF52B8FA6
      D8F0562D9F24C40B3EF198E4C21B6169B91029AA5496FE7FF651569ED68229BB
      C6B05695645AFAAFBEAE5E9CDA2BC35ACF6376F9C02931366CD0BC5D50D5A8C7
      F6FFC65B484F2AC73AEEF131FC9353E247B887DDF9488A4EC7409F89BDFFEF35
      212BB902EB679F60F815EE898CBFEB9E3B80A66BAD4EE5B4E8F8156C5F918A73
      27A57673D8A1FA65E90968968AA973BA4613F9E44CB3B88B9133A3E6E058D619
      BE320158BEBC06D4A24EA779D96E604E30392F2FBC0EEA0F3F81F26F758857A6
      00DF8475C035A811949F1AD4A3A437E49233FB623351DFB8BC3C1948584F7AFD
      40B2D6EC460BFB38F95C4C7AB625448B0CD8FCFC55BB6CFD57A456D7907582DA
      41CD68B0B0BE1A0B4B6BD1CFD8B14E81FA2F6DD9EA03C0EBCF92F3FD22D2DF78
      139F1F21E7C9F9D7EFB2811A08FFDA06C5615B5F8B779A2D71A2D9E9244ED32E
      83FAA37184FD7D50030A3EB1DFD3A6096EC02D504E62DC4138D24B4FAF26F3F4
      DD61CD08585A83F258FBB13AFD01E9097D89CD0BB416967395F83E6061836E61
      1DF1E7A703ECFBF4EE2AE2E34C8585E5D6DFD91F3A4E3710B5A60ED70E8D9F1F
      9B267F46D621F9E0456CF0D7DF59B797EC4F2DEA0E4D9C5F34CFCC41E7D40C25
      C9150DA25F573039E0C8F0A7DEC08B94809963F3AA2A0837A9213F8CFFFBA06B
      DFE1FEBF588E764DA7CDF7F43413A948A246D07E2D361CAC43F7CF468718AB8A
      A584DDA7C182FD6D98BF578DF5091530743A364749A9068B135AE0BF4F8B797B
      5B30739B043304C57833568A1EDD0DF639C8EB3223BF1101F12D981FAF816FAC
      0A332245E00AC4F00A4B07374A82177749D1D1AA873D36ABA0114FEC6962D6F4
      8D5182CB2F0037B2085EA169F08914C37B5B19967E2486AAE1BA0D9F2D6AC2C2
      3815FCF634636EB4023E11F9F0213C27E40CBCF985F08E9221F8C322C8AFB5D9
      B0B9852A2C8C55C02FAE117376D7C33B3C9711E7BD1FC0092F80974082408108
      0DB55A1B56D7D289253BAB08D7C0C8872F82D7960C7042CFC2F3FD2C70B696C0
      8FD871B14C69376E43B7CD106CC8C2DC8F2B191F39A1E9F00C498347D83978F2
      C5F08DC843A94CC11A7391F02A96BA54E0E5E01CCC22767A6EC9C4F490747844
      14620EEF3CA412392B6B68EDC66B1E242E54159E74A9C44B4B3288DF8598CE13
      E1F12D39B820AE1F375F52F89718D6AAA75C2FE18D35DFC3272C1BA7CF5EA65B
      78565E59AAC6330F948FB0CFBA5FC4C91D5530F5F4A2BA5C312ECBD8AE352224
      A08CB15BB04C8AE60AAD53F541AB4BD383FCAF6B70DB34E834FB3F51E2D8ED
    }
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrSearchTimer
    Left = 48
    Top = 216
  end
end
