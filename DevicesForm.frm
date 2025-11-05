object frmDevices: TfrmDevices
  Left = 373
  Height = 258
  Top = 284
  Width = 310
  Caption = 'Devices'
  ClientHeight = 258
  ClientWidth = 310
  Color = clBtnFace
  Position = poScreenCenter
  LCLVersion = '8.4'
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  object edtSearch: TEdit
    Left = 1
    Height = 23
    Hint = 'Search'
    Top = 230
    Width = 193
    Anchors = [akLeft, akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = edtSearchChange
    OnKeyDown = edtSearchKeyDown
  end
  object btnCancel: TButton
    Left = 255
    Height = 25
    Top = 230
    Width = 53
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 198
    Height = 25
    Top = 230
    Width = 51
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
