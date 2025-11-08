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
    Caption = 'Received device info'
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
      4C7A040000001000000010000000630500000000000078DAED967950137714C7
      37808AB587E32857D4D6DBA98EA3526BABD54EEF83CED869AD476BA7886D2002
      A3AD6DD516040C5A5BB0B6A5254447AB9DB11E40E53E428824E19080B4282A90
      700442A4040929570824DFFE76D35898249068FFECFBCD77B2B3BB9FB7EFBDDF
      7BD9A5288A5A77940D5A0F9703AE1C5323D87BE147AAFD17CA258DF4478B3E27
      93C99C127DAF951BF97CFA1A4909E21F768FCBDB8B9FBE46B3AEF0FF75FCCEF2
      8EE27795FF3FFEFBEBDFFB9D1FEA3EE79736DCA33962CD66D3BDBA449B5E81F8
      CE0338A53D0675D72DA7B921E300B2B5BF22749003EB0A19FE0809DA58D47556
      C06C721C53B3AE06BCEE7DE03858C1260E8E747E812AED6598868DA3587DA71A
      41E2B5E0F66C77C88F5CD15D7B50A2CD8171B08FE1FB741D58CD77C37AC1646C
      15F963E79DF7C7F5B1F3E666047EB39EE10DBD3AACE54F80BF8062441F6FC95A
      8A50F5561B8EDB1384D77FF6C794600FCCE03E8061A301C38303789E3FE52E6F
      D5D37C0F6C4E5E8470C53BE09839784F1E80D99F4E05C5A1187970DC48EE1A66
      AF5F4D7CC486B7EA29BE3B5EE0F9C19DC3BACBD26211D52B2B991CB61C7FCC21
      4F6BF1FE49A358AB8A2AD32D35ECBD83B3B2830838E165975F76C0965FBE7F01
      94AA6BA3F672A05F8FD4B2786C38C91EC53FC1FB977F88EB89F8D4480C1AFA1C
      F6D3A0A11719F2046C3C65C96BCD114F26DF0D5F3F87C6D61B2EF5B4B0EA24F6
      08D6E092F48CDD1E766A7ECD6687F33B4B93EDF28CA65437C04350C9C815EBEF
      D18F625DE1759DEDD8763A1D13F8E52EF3B7D54D78E94416DC134A417DF91BA8
      63525084A5C6E349DD64F2322C4C12818A2F02B5F722285E2EE1144435701B83
      370D19715E5488698952B08E882CEC57E457D008EAB8069EFC2A445ECCB0BFEF
      64268FA6E7E2C1A41250B1B916364E42D826A2364CE55FC189DC7C0C19066CD8
      3E7D173E3B9749EA2407159305EAF30BA0BE25790B5460095A312B518282D262
      DB5E22B9AA9A15963AD16C04A9D3BE14503FFD415835619BB02A29170DCA3ABB
      31FF5E538DC58979602594112E99F069A0F8354CBC6EA45E6F9E4C87F676AB5D
      F6EAD52B60C76582FA4E6661A3324025D5125683C94937B087E4D343F2B2BF45
      66C49C25391ECAB7B0BC9C7FF6478349FC6A7C9F9E8DC101C7B36AECEF4544F8
      BBE479A41FA2490CC72A187662D275B23F99308EC1D2A6A9AB62785AEEA41FDC
      628598162FC199FC7CA607C6B38ACCD30858B70221DB02181F91679351505404
      9369D8E977B0BE5D857E9DD6C23898757B46CFBEC160704A857585D074B4D89C
      A79C30914A82E5EAC3D874330E5DFA3F9D62AC56A8926279CB212C6E3B8C85AA
      83D8288F854EDFE1948FA29662AC688EC522F5212C683E8859925D98591886B7
      A551E8FE4BEBD0072922D21AF2B0B49987852D3CCC534661A630146C71187C52
      83C09684E345E97EB477B6C21E9BD1908FC71B639867CE531C003B9F0BB62814
      3EC9DBE1270E856FC92EAC127F0CE5ED5A1B3EB3518825CA68CC6F8AC1DCFA48
      F8E585C08FF0DE1703E15BC085AF2C1CFEA2DDA86BBB61C3E6280BB0A43E0AF3
      1BA231E756047C738219799FFF00DEF9C1F091846199300CB5EA1A1B56DBD18C
      9595FB30A73682919F900B9FB41DF04ED90EAF8C0FE15DB413F3491CA58A12BB
      75330D0F212C6313E6567CC2E4E89D4AB8E440CCB814042F3117F37243505C2F
      735873E1753E56C9597825CB1FB3499C5EE93B303D95F005219893CD81B44EE2
      90D575B5E20DD90CF857927775050B2FA7AD24B50AC67421078F66EDC0E55BE2
      31FB25B19CCBB0563D59EE86B7CEBD06BFCC205CB89A42FFCB38E415AA623C53
      36F12EFB6CA927CE54EE25DF65DDA8AE2F1B936562D7AB1158B294893B4CBA1A
      4D6AB94BF341DB9DEE16E45DFB917C2F185C66FF0617F27A19
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
