object frmDevices: TfrmDevices
  Left = 373
  Height = 258
  Top = 284
  Width = 310
  Caption = 'Devices'
  ClientHeight = 258
  ClientWidth = 310
  Color = clBtnFace
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  LCLVersion = '7.5'
  object edtSearch: TEdit
    Left = 1
    Height = 23
    Hint = 'Search'
    Top = 230
    Width = 193
    Anchors = [akLeft, akRight, akBottom]
    OnChange = edtSearchChange
    OnKeyDown = edtSearchKeyDown
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 255
    Height = 25
    Top = 230
    Width = 53
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    OnClick = btnCancelClick
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 198
    Height = 25
    Top = 230
    Width = 51
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    OnClick = vstDevicesDblClick
    TabOrder = 2
  end
  object tmrClose: TTimer
    Enabled = False
    Interval = 30
    OnTimer = tmrCloseTimer
    Left = 248
    Top = 144
  end
end
