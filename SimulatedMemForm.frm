object frmSimulatedMem: TfrmSimulatedMem
  Left = 43
  Height = 338
  Top = 57
  Width = 940
  Caption = 'Memory Statistics - Simulated Memory'
  ClientHeight = 338
  ClientWidth = 940
  Color = clBtnFace
  Constraints.MinHeight = 338
  Constraints.MinWidth = 940
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  LCLVersion = '7.5'
  object lblCOMNumber: TLabel
    Left = 8
    Height = 13
    Top = 0
    Width = 63
    Caption = 'COM Number'
  end
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
  object lblCOMStatus: TLabel
    Left = 92
    Height = 13
    Hint = 'Status is updated on connect/disconnect.'
    Top = 48
    Width = 119
    Caption = 'Status: Disconnected'
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object lblBaudRate: TLabel
    Left = 103
    Height = 13
    Top = 0
    Width = 47
    Caption = 'Baud rate'
  end
  object lblStatusMsg: TLabel
    Left = 8
    Height = 13
    Top = 70
    Width = 23
    Caption = 'Msg:'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object lblAllReceivedCommands: TLabel
    Left = 8
    Height = 13
    Top = 89
    Width = 177
    AutoSize = False
    Caption = 'All received commands:'
  end
  object cmbCOMPort: TComboBox
    Left = 8
    Height = 22
    Top = 19
    Width = 89
    ItemHeight = 16
    OnDropDown = cmbCOMPortDropDown
    Style = csOwnerDrawFixed
    TabOrder = 0
  end
  object btnSendAllCmdToCompareWindow: TButton
    Left = 697
    Height = 25
    Hint = 'Decode received commands and apply them to the simulated memory (selected slot).'
    Top = 48
    Width = 239
    Anchors = [akTop, akRight]
    Caption = 'Send all commands to cmp window'
    OnClick = btnSendAllCmdToCompareWindowClick
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object btnConnect: TButton
    Left = 223
    Height = 25
    Top = 16
    Width = 75
    Caption = 'Connect'
    OnClick = btnConnectClick
    TabOrder = 2
  end
  object btnDisconnect: TButton
    Left = 223
    Height = 25
    Top = 47
    Width = 75
    Caption = 'Disconnect'
    Enabled = False
    OnClick = btnDisconnectClick
    TabOrder = 3
  end
  object btnLoadHEXFromMainWindow: TButton
    Left = 384
    Height = 25
    Top = 47
    Width = 161
    Caption = 'Load HEX from main window'
    OnClick = btnLoadHEXFromMainWindowClick
    TabOrder = 4
  end
  object btnLoadHEX: TButton
    Left = 303
    Height = 25
    Top = 47
    Width = 75
    Caption = 'LoadHEX...'
    OnClick = btnLoadHEXClick
    TabOrder = 5
  end
  object cmbCompareWindow: TComboBox
    Left = 303
    Height = 22
    Top = 19
    Width = 145
    ItemHeight = 16
    OnChange = cmbCompareWindowChange
    Style = csOwnerDrawFixed
    TabOrder = 6
  end
  object cmbSlots: TComboBox
    Left = 454
    Height = 22
    Top = 19
    Width = 90
    ItemHeight = 16
    Style = csOwnerDrawFixed
    TabOrder = 7
  end
  object btnClearListOfCommands: TButton
    Left = 554
    Height = 25
    Top = 16
    Width = 135
    Caption = 'Clear list of commands'
    OnClick = btnClearListOfCommandsClick
    TabOrder = 8
  end
  object btnTestFIFOAndDecoder: TButton
    Left = 554
    Height = 25
    Hint = 'Sends some dummy data to the simulated memory, as if received from COM port.'
    Top = 47
    Width = 135
    Caption = 'Test FIFO and decoder'
    OnClick = btnTestFIFOAndDecoderClick
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
  end
  object cmbBaud: TComboBox
    Left = 103
    Height = 22
    Top = 19
    Width = 82
    ItemHeight = 16
    ItemIndex = 20
    Items.Strings = (
      '75'
      '110'
      '134'
      '150'
      '300'
      '600'
      '1200'
      '1800'
      '2400'
      '4800'
      '7200'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200'
      '128000'
      '230400'
      '256000'
      '460800'
      '921600'
    )
    Style = csOwnerDrawFixed
    TabOrder = 10
    Text = '256000'
  end
  object chkShowAll: TCheckBox
    Left = 8
    Height = 19
    Hint = 'Shows all possible COM numbers'
    Top = 47
    Width = 60
    Caption = 'Show All'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
  end
  object grpReceivedDeviceInfo: TGroupBox
    Left = 697
    Height = 161
    Hint = 'Info updated on sending commands to compare window'
    Top = 141
    Width = 239
    Anchors = [akTop, akRight]
    Caption = 'Received device info'
    ClientHeight = 143
    ClientWidth = 235
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    object lblDevicePointerSize: TLabel
      Left = 8
      Height = 13
      Top = 8
      Width = 208
      AutoSize = False
      Caption = 'Pointer size:'
    end
    object lblProgramFlashSize: TLabel
      Left = 8
      Height = 13
      Top = 35
      Width = 208
      AutoSize = False
      Caption = 'Program flash size:'
    end
    object lblBootFlashSize: TLabel
      Left = 8
      Height = 13
      Top = 62
      Width = 208
      AutoSize = False
      Caption = 'Boot flash size:'
    end
    object lblWriteSize: TLabel
      Left = 8
      Height = 13
      Top = 89
      Width = 208
      AutoSize = False
      Caption = 'Write size:'
    end
    object lblEraseSize: TLabel
      Left = 8
      Height = 13
      Top = 116
      Width = 208
      AutoSize = False
      Caption = 'Erase size:'
    end
  end
  object chkAutoSendCommandsToCmpWindow: TCheckBox
    Left = 697
    Height = 19
    Hint = 'If checked, all recent commands are sent to the simulated memory (selected slot on compare window).'
    Top = 84
    Width = 239
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Autosend commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
  end
  object chkAppendUserNotesOnCmpWindow: TCheckBox
    Left = 697
    Height = 19
    Top = 108
    Width = 239
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Append user notes on cmp window'
    TabOrder = 14
  end
  object btnDisplayCompareWindow: TButton
    Left = 554
    Height = 25
    Top = 78
    Width = 135
    Caption = 'Display cmp window'
    OnClick = btnDisplayCompareWindowClick
    TabOrder = 15
  end
  object btnSendSelectedCommands: TButton
    Left = 697
    Height = 25
    Hint = 'Decode received commands and apply them to the simulated memory (selected slot).'
    Top = 16
    Width = 239
    Anchors = [akTop, akRight]
    Caption = 'Send selected commands to cmp window'
    OnClick = btnSendSelectedCommandsClick
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
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
end
