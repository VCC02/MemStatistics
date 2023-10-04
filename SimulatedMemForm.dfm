object frmSimulatedMem: TfrmSimulatedMem
  Left = 0
  Top = 0
  Caption = 'Memory Statistics - Simulated Memory'
  ClientHeight = 299
  ClientWidth = 924
  Color = clBtnFace
  Constraints.MinHeight = 338
  Constraints.MinWidth = 940
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    924
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object lblCOMNumber: TLabel
    Left = 8
    Top = 0
    Width = 63
    Height = 13
    Caption = 'COM Number'
  end
  object lblCompareWindow: TLabel
    Left = 303
    Top = 0
    Width = 84
    Height = 13
    Caption = 'Compare Window'
  end
  object lblSlot: TLabel
    Left = 454
    Top = 0
    Width = 18
    Height = 13
    Caption = 'Slot'
  end
  object lblCOMStatus: TLabel
    Left = 92
    Top = 48
    Width = 119
    Height = 13
    Hint = 'Status is updated on connect/disconnect.'
    Caption = 'Status: Disconnected'
    Font.Charset = DEFAULT_CHARSET
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
    Top = 0
    Width = 47
    Height = 13
    Caption = 'Baud rate'
  end
  object lblStatusMsg: TLabel
    Left = 8
    Top = 70
    Width = 23
    Height = 13
    Caption = 'Msg:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblAllReceivedCommands: TLabel
    Left = 8
    Top = 89
    Width = 177
    Height = 13
    AutoSize = False
    Caption = 'All received commands:'
  end
  object cmbCOMPort: TComboBox
    Left = 8
    Top = 19
    Width = 89
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnDropDown = cmbCOMPortDropDown
  end
  object btnSendAllCmdToCompareWindow: TButton
    Left = 689
    Top = 47
    Width = 227
    Height = 25
    Hint = 
      'Decode received commands and apply them to the simulated memory ' +
      '(selected slot).'
    Anchors = [akTop, akRight]
    Caption = 'Send all commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnSendAllCmdToCompareWindowClick
  end
  object btnConnect: TButton
    Left = 223
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 223
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 3
    OnClick = btnDisconnectClick
  end
  object btnLoadHEXFromMainWindow: TButton
    Left = 384
    Top = 47
    Width = 153
    Height = 25
    Caption = 'Load HEX from main window'
    TabOrder = 4
    OnClick = btnLoadHEXFromMainWindowClick
  end
  object btnLoadHEX: TButton
    Left = 303
    Top = 47
    Width = 75
    Height = 25
    Caption = 'LoadHEX...'
    TabOrder = 5
    OnClick = btnLoadHEXClick
  end
  object cmbCompareWindow: TComboBox
    Left = 303
    Top = 19
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 6
    OnChange = cmbCompareWindowChange
  end
  object cmbSlots: TComboBox
    Left = 454
    Top = 19
    Width = 83
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 7
  end
  object btnClearListOfCommands: TButton
    Left = 546
    Top = 16
    Width = 137
    Height = 25
    Caption = 'Clear list of commands'
    TabOrder = 8
    OnClick = btnClearListOfCommandsClick
  end
  object btnTestFIFOAndDecoder: TButton
    Left = 546
    Top = 47
    Width = 137
    Height = 25
    Hint = 
      'Sends some dummy data to the simulated memory, as if received fr' +
      'om COM port.'
    Caption = 'Test FIFO and decoder'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnTestFIFOAndDecoderClick
  end
  object cmbBaud: TComboBox
    Left = 103
    Top = 19
    Width = 82
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 20
    TabOrder = 10
    Text = '256000'
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
      '921600')
  end
  object chkShowAll: TCheckBox
    Left = 8
    Top = 47
    Width = 80
    Height = 17
    Hint = 'Shows all possible COM numbers'
    Caption = 'Show All'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
  end
  object grpReceivedDeviceInfo: TGroupBox
    Left = 689
    Top = 130
    Width = 227
    Height = 161
    Hint = 'Info updated on sending commands to compare window'
    Anchors = [akTop, akRight]
    Caption = 'Received device info'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    object lblDevicePointerSize: TLabel
      Left = 8
      Top = 24
      Width = 208
      Height = 13
      AutoSize = False
      Caption = 'Pointer size:'
    end
    object lblProgramFlashSize: TLabel
      Left = 8
      Top = 51
      Width = 208
      Height = 13
      AutoSize = False
      Caption = 'Program flash size:'
    end
    object lblBootFlashSize: TLabel
      Left = 8
      Top = 78
      Width = 208
      Height = 13
      AutoSize = False
      Caption = 'Boot flash size:'
    end
    object lblWriteSize: TLabel
      Left = 8
      Top = 105
      Width = 208
      Height = 13
      AutoSize = False
      Caption = 'Write size:'
    end
    object lblEraseSize: TLabel
      Left = 8
      Top = 132
      Width = 208
      Height = 13
      AutoSize = False
      Caption = 'Erase size:'
    end
  end
  object chkAutoSendCommandsToCmpWindow: TCheckBox
    Left = 689
    Top = 82
    Width = 227
    Height = 17
    Hint = 
      'If checked, all recent commands are sent to the simulated memory' +
      ' (selected slot on compare window).'
    Anchors = [akTop, akRight]
    Caption = 'Autosend commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
  end
  object chkAppendUserNotesOnCmpWindow: TCheckBox
    Left = 689
    Top = 105
    Width = 227
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Append user notes on cmp window'
    TabOrder = 14
  end
  object btnDisplayCompareWindow: TButton
    Left = 546
    Top = 78
    Width = 137
    Height = 25
    Caption = 'Display cmp window'
    TabOrder = 15
    OnClick = btnDisplayCompareWindowClick
  end
  object btnSendSelectedCommands: TButton
    Left = 689
    Top = 16
    Width = 227
    Height = 25
    Hint = 
      'Decode received commands and apply them to the simulated memory ' +
      '(selected slot).'
    Anchors = [akTop, akRight]
    Caption = 'Send selected commands to cmp window'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = btnSendSelectedCommandsClick
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
