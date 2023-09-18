{
    Copyright (C) 2023 VCC
    creation date: 2013
    initial release date: 17 Sep 2023

    author: VCC
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
    OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}


unit DevicesForm;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}  

interface

uses
  {$IFDEF FPC}
    LCLIntf, LCLType,
  {$ELSE}
    Windows, Messages,
  {$ENDIF}
    SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VirtualTrees, ExtCtrls;

type
  TfrmDevices = class(TForm)
    edtSearch: TEdit;
    tmrClose: TTimer;
    btnCancel: TButton;
    btnOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure vstDevicesDblClick(Sender: TObject);
    procedure vstDevicesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstDevicesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrCloseTimer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDevices: TStringList;
    FSelectedDevice: Integer;

    vstDevices: TVirtualStringTree;

    procedure SelectDeviceInVST(Index: Cardinal);
    procedure SetFieldToSelectedDevice;
    procedure CreateRemainingComponents;
  public
    { Public declarations }
    property SelectedDevice: Integer read FSelectedDevice write FSelectedDevice;
  end;

var
  frmDevices: TfrmDevices;

function GetNewDevice(AllDevices: string; Selected: Integer; var NewChipName: string): Integer;

implementation

{$IFDEF FPC}
  {$R *.frm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}


function GetNewDevice(AllDevices: string; Selected: Integer; var NewChipName: string): Integer;
begin
  Application.CreateForm(TfrmDevices, frmDevices);
  frmDevices.FDevices.Text := AllDevices;
  frmDevices.vstDevices.RootNodeCount := frmDevices.FDevices.Count;
  
  frmDevices.SelectedDevice := Selected;

  frmDevices.ShowModal;
  if frmDevices.Tag = 1 then
    Result := frmDevices.SelectedDevice
  else
    Result := Selected; //nothing changed

  if Result = -1 then
    NewChipName := ''
  else
    NewChipName := frmDevices.FDevices.Strings[Result];

  frmDevices.FDevices.Free;
end;


procedure TfrmDevices.SelectDeviceInVST(Index: Cardinal);
var
  CurrentNode: PVirtualNode;
begin
  CurrentNode := vstDevices.GetFirst;
  if CurrentNode = nil then
    Exit;

  repeat
    if CurrentNode.Index = Index then
    begin
      vstDevices.Selected[CurrentNode] := True;
      if Visible then
        vstDevices.ScrollIntoView(CurrentNode, True, True);
      Exit;
    end;

    CurrentNode := CurrentNode.NextSibling;
  until CurrentNode = nil;
end;


procedure TfrmDevices.SetFieldToSelectedDevice;
var
  CurrentNode: PVirtualNode;
begin
  CurrentNode := vstDevices.GetFirstSelected;
  if CurrentNode <> nil then
    FSelectedDevice := CurrentNode.Index; 
end;


procedure TfrmDevices.tmrCloseTimer(Sender: TObject);
begin
  Close;
end;


procedure TfrmDevices.btnCancelClick(Sender: TObject);
begin
  Tag := 0;
  tmrClose.Enabled := True;
end;


procedure TfrmDevices.edtSearchChange(Sender: TObject);
var
  CurrentNode: PVirtualNode;
begin
  CurrentNode := vstDevices.GetFirst;
  if CurrentNode = nil then
    Exit;
    
  repeat
    if edtSearch.Text <> '' then
      vstDevices.IsVisible[CurrentNode] := Pos(UpperCase(edtSearch.Text), UpperCase(FDevices.Strings[CurrentNode.Index])) > 0
    else
      vstDevices.IsVisible[CurrentNode] := True;

    CurrentNode := CurrentNode.NextSibling;
  until CurrentNode = nil;

  vstDevices.Visible := True;
  vstDevices.UpdateScrollBars(True);
  vstDevices.Repaint;
end;


procedure TfrmDevices.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Tag := 0;
    tmrClose.Enabled := True;
  end;

  if Key = VK_RETURN then
    if vstDevices.GetFirstSelected <> nil then
    begin
      SetFieldToSelectedDevice;
      Tag := 1;
      tmrClose.Enabled := True;
    end;
end;


procedure TfrmDevices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfrmDevices.CreateRemainingComponents;
begin
  vstDevices := TVirtualStringTree.Create(Self);
  vstDevices.Parent := Self;

  vstDevices.Left := 0;
  vstDevices.Top := 0;
  vstDevices.Width := 309;
  vstDevices.Height := 226;
  vstDevices.Hint := 'Double click to select and exit. Press Esc to leave unchanged.';
  vstDevices.Anchors := [akLeft, akTop, akRight, akBottom];
  vstDevices.Header.AutoSizeIndex := 0;
  vstDevices.Header.DefaultHeight := 17;
  vstDevices.Header.Font.Charset := DEFAULT_CHARSET;
  vstDevices.Header.Font.Color := clWindowText;
  vstDevices.Header.Font.Height := -11;
  vstDevices.Header.Font.Name := 'Tahoma';
  vstDevices.Header.Font.Style := [];
  vstDevices.Header.MainColumn := -1;
  vstDevices.ParentShowHint := False;
  vstDevices.ShowHint := True;
  vstDevices.TabOrder := 1;
  vstDevices.TreeOptions.SelectionOptions := [toFullRowSelect];
  vstDevices.OnDblClick := vstDevicesDblClick;
  vstDevices.OnGetText := vstDevicesGetText;
  vstDevices.OnKeyDown := vstDevicesKeyDown;
end;



procedure TfrmDevices.FormCreate(Sender: TObject);
begin
  CreateRemainingComponents;
  vstDevices.RootNodeCount := 0;
  FDevices := TStringList.Create;
  FSelectedDevice := -1;
end;


procedure TfrmDevices.FormShow(Sender: TObject);
begin
  if SelectedDevice > -1 then
    frmDevices.SelectDeviceInVST(SelectedDevice);
end;


procedure TfrmDevices.vstDevicesDblClick(Sender: TObject);
begin
  SetFieldToSelectedDevice;
  Tag := 1;
  tmrClose.Enabled := True;
end;


procedure TfrmDevices.vstDevicesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
begin
  try
    CellText := '';
    if (Node <> nil) and (FDevices <> nil) then
      if FDevices.Count > 0 then
        if Integer(Node.Index) < FDevices.Count then
          CellText := FDevices.Strings[Node.Index];
  except
    //another thread is still running, while this form is distroyed
  end;
end;


procedure TfrmDevices.vstDevicesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Tag := 0;
    tmrClose.Enabled := True;
  end;

  if Key = VK_RETURN then
    if vstDevices.GetFirstSelected <> nil then
    begin
      SetFieldToSelectedDevice;
      Tag := 1;
      tmrClose.Enabled := True;
    end;
end;

end.
