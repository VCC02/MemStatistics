object frmDevices: TfrmDevices
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Devices'
  ClientHeight = 257
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    310
    257)
  PixelsPerInch = 96
  TextHeight = 13
  object edtSearch: TEdit
    Left = 0
    Top = 232
    Width = 193
    Height = 21
    Hint = 'Search'
    Anchors = [akLeft, akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = edtSearchChange
    OnKeyDown = edtSearchKeyDown
  end
  object btnCancel: TButton
    Left = 256
    Top = 232
    Width = 53
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 199
    Top = 232
    Width = 51
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = vstDevicesDblClick
  end
  object tmrClose: TTimer
    Enabled = False
    Interval = 30
    OnTimer = tmrCloseTimer
    Left = 248
    Top = 144
  end
end
