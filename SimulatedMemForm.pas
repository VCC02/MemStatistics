{
    Copyright (C) 2023 VCC
    creation date: 2023
    initial release date: 23 Sep 2023

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


unit SimulatedMemForm;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF UNIX}
    LCLIntf, LCLType,
  {$ELSE}
    Windows,
  {$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PollingFIFO, ExtCtrls, VirtualTrees, ComCtrls, ImgList;

type
  TComThread = class(TThread)
  private
    FCharsReceived: Integer;
  protected
    procedure Execute; override;
  public
    property CharsReceived: Integer read FCharsReceived;
  end;

  TDeviceFlashInfo = record
    Pointer_Size: Integer;
    ProgramFlash_Size: Integer;
    BootFlash_Size: Integer;
    Write_Size: Integer;
    Erase_Size: Integer;
  end;

  { TfrmSimulatedMem }

  TfrmSimulatedMem = class(TForm)
    cmbCOMPort: TComboBox;
    tmrReadFIFO: TTimer;
    btnSendAllCmdToCompareWindow: TButton;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnLoadHEXFromMainWindow: TButton;
    btnLoadHEX: TButton;
    cmbCompareWindow: TComboBox;
    lblCOMNumber: TLabel;
    lblCompareWindow: TLabel;
    cmbSlots: TComboBox;
    lblSlot: TLabel;
    lblCOMStatus: TLabel;
    btnClearListOfCommands: TButton;
    btnTestFIFOAndDecoder: TButton;
    cmbBaud: TComboBox;
    lblBaudRate: TLabel;
    lblStatusMsg: TLabel;
    chkShowAll: TCheckBox;
    grpReceivedDeviceInfo: TGroupBox;
    lblDevicePointerSize: TLabel;
    lblProgramFlashSize: TLabel;
    lblBootFlashSize: TLabel;
    lblWriteSize: TLabel;
    lblEraseSize: TLabel;
    chkAutoSendCommandsToCmpWindow: TCheckBox;
    lblAllReceivedCommands: TLabel;
    chkAppendUserNotesOnCmpWindow: TCheckBox;
    tmrStartup: TTimer;
    btnDisplayCompareWindow: TButton;
    btnSendSelectedCommands: TButton;
    imglstCmds: TImageList;
    chkAutoScrollToSelectedCommands: TCheckBox;
    procedure tmrReadFIFOTimer(Sender: TObject);
    procedure btnLoadHEXClick(Sender: TObject);
    procedure btnLoadHEXFromMainWindowClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbCompareWindowChange(Sender: TObject);
    procedure vstMemCommandsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstMemCommandsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstMemCommandsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnClearListOfCommandsClick(Sender: TObject);
    procedure btnTestFIFOAndDecoderClick(Sender: TObject);
    procedure btnSendAllCmdToCompareWindowClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure cmbCOMPortDropDown(Sender: TObject);
    procedure tmrStartupTimer(Sender: TObject);
    procedure btnDisplayCompareWindowClick(Sender: TObject);
    procedure btnSendSelectedCommandsClick(Sender: TObject);
  private
    { Private declarations }
    FFIFO: TPollingFIFO;
    FConnHandle: THandle;
    FCOMName: string;
    FAllCommands: TStringList;
    vstMemCommands: TVirtualStringTree;

    FDeviceFlashInfo: TDeviceFlashInfo;
    FTh: TComThread;

    procedure LoadSettingsFromIni;
    procedure SaveSettingsToIni;
    procedure CreateRemainingComponents;

    {$IFDEF Windows}
      procedure DetectDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    {$ENDIF}

    procedure UpdateListOfCOMPorts;
    function GetCurrentCOMName: string;
    procedure ConnectToCOMPort;
    procedure DisconnectFromCOMPort;

    procedure DisplayExtraErrorMessage(AMsg: string; AExtraInfo: string = '');
    procedure ClearExtraErrorMessage;

    procedure CreateTh;
    procedure TerminateTh;

    procedure FillInListOfAvailableSlots;
    procedure FillInListOfAvailableCmpWindows;

    procedure ReadFromFIFO;
    procedure SendCmdToCompareWindowByIndex(ACommandsToSend: TStringList; ACmdIdx, ACmpWinIdx, ASlotIdx: Integer; AAppendUserNotes: Boolean);
    procedure HighlightCmdToCompareWindowByIndex(ACommandsToHighlight: TStringList; ACmdIdx, ACmpWinIdx, ASlotIdx: Integer);
    procedure SendAllCmdsToCompareWindow;
    procedure SendSelectedCmdsToCompareWindow;
  public
    { Public declarations }
    procedure UpdateAvailableCmpWindowSelection;

    property FIFO: TPollingFIFO read FFIFO; //thread safe
    property ConnHandle: THandle read FConnHandle;
    property COMName: string read FCOMName;


  end;

var
  frmSimulatedMem: TfrmSimulatedMem;

implementation


{$IFDEF FPC}
  {$R *.frm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}


uses
  MemStatCompareForm, MemStatUtils, SimpleCOM, IniFiles;

const
  CDevCmd_Pointer_Size = 'Pointer_Size';
  CDevCmd_ProgramFlash_Size = 'ProgramFlash_Size';
  CDevCmd_BootFlash_Size = 'BootFlash_Size';
  CDevCmd_Write_Size = 'Write_Size';
  CDevCmd_Erase_Size = 'Erase_Size';

  CDevCmd_Write_Word = 'Write_Word';
  CDevCmd_Write_Row = 'Write_Row';
  CDevCmd_Erase = 'Erase';


  CDevCmd_Pointer_Size_EQ = CDevCmd_Pointer_Size + '=';
  CDevCmd_ProgramFlash_Size_EQ = CDevCmd_ProgramFlash_Size + '=';
  CDevCmd_BootFlash_Size_EQ = CDevCmd_BootFlash_Size + '=';
  CDevCmd_Write_Size_EQ = CDevCmd_Write_Size + '=';
  CDevCmd_Erase_Size_EQ = CDevCmd_Erase_Size + '=';

  CDevCmd_Write_Word_EQ = CDevCmd_Write_Word + '=';
  CDevCmd_Write_Row_EQ = CDevCmd_Write_Row + '=';
  CDevCmd_Erase_EQ = CDevCmd_Erase + '=';


procedure TComThread.Execute;
type
  TArr = array[0..0] of AnsiChar;
var
  TempNrCharsReceived, ActualRead: Integer;
  s, TempCmd, LongBuffer: string;    //LongBuffer is used as a stream FIFO (adds data on one end, then removes from the other)
  PosCRLF: Integer;
  arr: ^TArr;
begin
  LongBuffer := '';

  repeat
    try
      if COMIsConnected(frmSimulatedMem.COMName) then
      begin
        TempNrCharsReceived := GetReceivedByteCount(frmSimulatedMem.ConnHandle);

        if TempNrCharsReceived > 0 then
        begin
          SetLength(s, TempNrCharsReceived);
          arr := @s[1];

          ActualRead := ReceiveDataFromCOM(frmSimulatedMem.ConnHandle, arr^, TempNrCharsReceived);
          if ActualRead < TempNrCharsReceived then
            SetLength(s, ActualRead);

          LongBuffer := LongBuffer + s;  //keep adding to it
          PosCRLF := Pos({$IFDEF UNIX} #10 {$ELSE} #13#10 {$ENDIF}, LongBuffer); //maybe the config is wrong, so that #13 doesn't make it

          while PosCRLF > 0 do
          begin
            TempCmd := Copy(LongBuffer, 1, PosCRLF - 1);
            frmSimulatedMem.FIFO.Put(TempCmd);

            {$IFDEF UNIX}
              Delete(LongBuffer, 1, PosCRLF + 0); //deletes TempCmd and the CRLF after it
              PosCRLF := Pos(#10, LongBuffer);
            {$ELSE}
              Delete(LongBuffer, 1, PosCRLF + 1); //deletes TempCmd and the CRLF after it
              PosCRLF := Pos(#13#10, LongBuffer);
            {$ENDIF}
          end;
        end;

        FCharsReceived := TempNrCharsReceived;
      end;

      Sleep(1);
    except

    end;
  until Terminated;
end;


procedure TfrmSimulatedMem.ConnectToCOMPort;
begin
  tmrReadFIFO.Enabled := True;
  lblCOMStatus.Font.Color := $00006800;
  lblCOMStatus.Caption := 'Status: Connected';
  lblCOMStatus.Hint := '';

  ClearExtraErrorMessage;

  btnConnect.Enabled := False;
  btnDisconnect.Enabled := True;
  cmbCOMPort.Enabled := False;
  cmbBaud.Enabled := False;

  CreateTh;
end;


procedure TfrmSimulatedMem.DisconnectFromCOMPort;
begin
  TerminateTh;
  DisconnectFromCOM(FCOMName);  //set internal library info to "disconnected"

  try
    lblCOMStatus.Hint := SysErrorMessage(GetCOMError(FCOMName));
  except
    //GetComErrors may throw an AV if the COM port is closed  :(
  end;

  tmrReadFIFO.Enabled := False;
  lblCOMStatus.Font.Color := clMaroon;
  lblCOMStatus.Caption := 'Status: Disconnected';

  ClearExtraErrorMessage;
  
  btnConnect.Enabled := True;
  btnDisconnect.Enabled := False;
  cmbCOMPort.Enabled := True;
  cmbBaud.Enabled := True;
end;


{$IFDEF Windows}
  procedure TfrmSimulatedMem.DetectDeviceChange(var Msg: TMessage);
  begin
    Sleep(100);
    UpdateListOfCOMPorts;

    if cmbCOMPort.Items.IndexOf(FCOMName) = -1 then  //current com is disconnected
      if COMIsConnected(FCOMName) then
        DisconnectFromCOMPort;
  end;
{$ENDIF}


procedure TfrmSimulatedMem.UpdateListOfCOMPorts;
var
  OldSelection: string;
  NewSelectionIndex: Integer;
  AllCOMs: TStringList;
begin
  AllCOMs := TStringList.Create;
  try
    ListExistentCOMPorts(AllCOMs, Visible and chkShowAll.Checked);

    if cmbCOMPort.Items.Text <> AllCOMs.Text then
    begin
      OldSelection := '';
      if cmbCOMPort.ItemIndex <> -1 then
        OldSelection := cmbCOMPort.Items.Strings[cmbCOMPort.ItemIndex];

      cmbCOMPort.Items.Text := AllCOMs.Text;

      if OldSelection <> '' then
      begin
        NewSelectionIndex := cmbCOMPort.Items.IndexOf(OldSelection);
        if NewSelectionIndex <> -1 then
          cmbCOMPort.ItemIndex := NewSelectionIndex;
      end;
    end;
  finally
    AllCOMs.Free;
  end;
end;


function TfrmSimulatedMem.GetCurrentCOMName: string;
begin
  if cmbCOMPort.ItemIndex = -1 then
  begin
    Result := '';
    Exit;
  end;

  Result := cmbCOMPort.Items.Strings[cmbCOMPort.ItemIndex];
end;


procedure TfrmSimulatedMem.DisplayExtraErrorMessage(AMsg: string; AExtraInfo: string = '');
begin
  lblStatusMsg.Caption := 'Msg: ' + AMsg;
  lblStatusMsg.Font.Color := clMaroon;
  lblStatusMsg.Font.Style := [fsBold];
  lblStatusMsg.Hint := AExtraInfo;

  {$IFDEF UNIX}
    if AMsg = 'Permission denied' then
      lblStatusMsg.Hint := lblStatusMsg.Hint + #13#10 +
                           'Type this into a terminal, then relogin: ' + #13#10 +
                           'sudo usermod -a -G dialout $USER';
  {$ENDIF}
end;


procedure TfrmSimulatedMem.ClearExtraErrorMessage;
begin
  lblStatusMsg.Caption := 'Msg';
  lblStatusMsg.Font.Color := clWindowText;
  lblStatusMsg.Font.Style := [];
end;


procedure TfrmSimulatedMem.btnConnectClick(Sender: TObject);
var
  BaudStr: string;
begin
  FCOMName := GetCurrentCOMName;
  if FCOMName = '' then
  begin
    DisplayExtraErrorMessage('No COM is selected.');
    Exit;
  end;

  if cmbBaud.ItemIndex = -1 then
    BaudStr := '256000'
  else
    BaudStr := cmbBaud.Items.Strings[cmbBaud.ItemIndex];

  FConnHandle := ConnectToCOM(FCOMName, StrToIntDef(BaudStr, 256000), {Parity_none, 8, ONESTOPBIT,} 4096, 4096);
  if FConnHandle > 0 then
    ConnectToCOMPort
  else
  begin
    try
      DisplayExtraErrorMessage(SysErrorMessage(GetCOMError(FCOMName)), GetCOMExtraError(FCOMName)); //SysErrorMessage(GetLastError);
    except
      //GetComErrors may throw an AV if the COM port is closed  :(
    end;
  end;
end;


procedure TfrmSimulatedMem.btnDisconnectClick(Sender: TObject);
begin
  DisconnectFromCOMPort;
end;


procedure TfrmSimulatedMem.btnDisplayCompareWindowClick(Sender: TObject);
begin
  if ListOfFrmMemStatCompare.Count = 0 then
    Exit;

  if cmbCompareWindow.ItemIndex = -1 then
    Exit;

  ListOfFrmMemStatCompare.Items[cmbCompareWindow.ItemIndex].BringToFront;  
end;


procedure TfrmSimulatedMem.btnLoadHEXClick(Sender: TObject);
begin
  if ListOfFrmMemStatCompare.Count = 0 then
    Exit;

  if cmbCompareWindow.ItemIndex = -1 then
    Exit;

  if cmbSlots.ItemIndex = -1 then
    Exit;

  ListOfFrmMemStatCompare.Items[cmbCompareWindow.ItemIndex].LoadExternalHex(cmbSlots.ItemIndex);
end;


procedure TfrmSimulatedMem.btnLoadHEXFromMainWindowClick(Sender: TObject);
begin
  if ListOfFrmMemStatCompare.Count = 0 then
    Exit;

  if cmbCompareWindow.ItemIndex = -1 then
    Exit;

  if cmbSlots.ItemIndex = -1 then
    Exit;

  ListOfFrmMemStatCompare.Items[cmbCompareWindow.ItemIndex].LoadExternalHex(cmbSlots.ItemIndex, True);
end;


procedure TfrmSimulatedMem.SendCmdToCompareWindowByIndex(ACommandsToSend: TStringList; ACmdIdx, ACmpWinIdx, ASlotIdx: Integer; AAppendUserNotes: Boolean);
var
  j, k: Integer;
  TempData, s, AddressStr, UserNote: string;
  TempWord, Address: DWord;
  DataToWrite: array of Byte;
begin
  s := ACommandsToSend.Strings[ACmdIdx];

  if Pos(CDevCmd_Pointer_Size_EQ, s) = 1 then
  begin
    TempData := Copy(s, Length(CDevCmd_Pointer_Size_EQ) + 1, MaxInt);
    FDeviceFlashInfo.Pointer_Size := HexToInt(TempData);
    lblDevicePointerSize.Caption := 'Pointer size: ' + TempData + ' (' + IntToStr(FDeviceFlashInfo.Pointer_Size) + ')';
    Exit;
  end;

  if Pos(CDevCmd_ProgramFlash_Size_EQ, s) = 1 then
  begin
    TempData := Copy(s, Length(CDevCmd_ProgramFlash_Size_EQ) + 1, MaxInt);
    FDeviceFlashInfo.ProgramFlash_Size := HexToInt(TempData);
    lblProgramFlashSize.Caption := 'Program flash size: ' + TempData + ' (' + IntToStr(FDeviceFlashInfo.ProgramFlash_Size) + ')';
    Exit;
  end;

  if Pos(CDevCmd_BootFlash_Size_EQ, s) = 1 then
  begin
    TempData := Copy(s, Length(CDevCmd_BootFlash_Size_EQ) + 1, MaxInt);
    FDeviceFlashInfo.BootFlash_Size := HexToInt(TempData);
    lblBootFlashSize.Caption := 'Boot flash size: ' + TempData + ' (' + IntToStr(FDeviceFlashInfo.BootFlash_Size) + ')';
    Exit;
  end;

  if Pos(CDevCmd_Write_Size_EQ, s) = 1 then
  begin
    TempData := Copy(s, Length(CDevCmd_Write_Size_EQ) + 1, MaxInt);
    FDeviceFlashInfo.Write_Size := HexToInt(TempData);
    lblWriteSize.Caption := 'Write size: ' + TempData + ' (' + IntToStr(FDeviceFlashInfo.Write_Size) + ')';
    Exit;
  end;

  if Pos(CDevCmd_Erase_Size_EQ, s) = 1 then
  begin
    TempData := Copy(s, Length(CDevCmd_Erase_Size_EQ) + 1, MaxInt);
    FDeviceFlashInfo.Erase_Size := HexToInt(TempData);
    lblEraseSize.Caption := 'Erase size: ' + TempData + ' (' + IntToStr(FDeviceFlashInfo.Erase_Size) + ')';
    Exit;
  end;

  if (ACmpWinIdx > -1) and (ASlotIdx > -1) then
  begin
    if Pos(CDevCmd_Write_Word_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Write_Word_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      Delete(TempData, 1, 8);
      TempWord := HexToInt(TempData);

      SetLength(DataToWrite, 4);
      for j := 0 to Length(DataToWrite) - 1 do
      begin
        DataToWrite[j] := TempWord and $FF;
        TempWord := TempWord shr 8;
      end;

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      if AAppendUserNotes then
        UserNote := CWriteWord_UserNote
      else
        UserNote := '';

      ListOfFrmMemStatCompare[ACmpWinIdx].WriteMemory(ASlotIdx, Address, DataToWrite, UserNote);
      Exit;
    end;

    if Pos(CDevCmd_Write_Row_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Write_Row_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      Delete(TempData, 1, 8);

      SetLength(DataToWrite, FDeviceFlashInfo.Write_Size);
      for k := 0 to FDeviceFlashInfo.Write_Size shr 2 - 1 do
      begin
        TempWord := HexToInt(Copy(TempData, 1, 8));
        for j := 0 to 3 do
        begin
          DataToWrite[k shl 2 + j] := TempWord and $FF;
          TempWord := TempWord shr 8;
        end;

        Delete(TempData, 1, 8);
      end;

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      if AAppendUserNotes then
        UserNote := CWriteRow_UserNote
      else
        UserNote := '';

      ListOfFrmMemStatCompare[ACmpWinIdx].WriteMemory(ASlotIdx, Address, DataToWrite, UserNote);
      Exit;
    end;

    if Pos(CDevCmd_Erase_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Erase_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      if AAppendUserNotes then
        UserNote := CErase_UserNote
      else
        UserNote := '';

      ListOfFrmMemStatCompare[ACmpWinIdx].EraseMemoryChunk(ASlotIdx, Address, FDeviceFlashInfo.Erase_Size, UserNote);
      Exit;
    end;
  end;
end;


procedure TfrmSimulatedMem.HighlightCmdToCompareWindowByIndex(ACommandsToHighlight: TStringList; ACmdIdx, ACmpWinIdx, ASlotIdx: Integer);
var
  TempData, s, AddressStr: string;
  Address: DWord;
  ScrollHighlightedNodesIntoView: Boolean;
begin
  s := ACommandsToHighlight.Strings[ACmdIdx];

  if (ACmpWinIdx > -1) and (ASlotIdx > -1) then
  begin
    ScrollHighlightedNodesIntoView := chkAutoScrollToSelectedCommands.Checked;

    if Pos(CDevCmd_Write_Word_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Write_Word_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      ListOfFrmMemStatCompare[ACmpWinIdx].HighlightMemoryChunk(ASlotIdx, Address, FDeviceFlashInfo.Pointer_Size, ScrollHighlightedNodesIntoView);
      Exit;
    end;

    if Pos(CDevCmd_Write_Row_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Write_Row_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      ListOfFrmMemStatCompare[ACmpWinIdx].HighlightMemoryChunk(ASlotIdx, Address, FDeviceFlashInfo.Write_Size, ScrollHighlightedNodesIntoView);
      Exit;
    end;

    if Pos(CDevCmd_Erase_EQ, s) = 1 then
    begin
      TempData := Copy(s, Length(CDevCmd_Erase_EQ) + 1, MaxInt);
      AddressStr := Copy(TempData, 1, 8);

      if ListOfFrmMemStatCompare[ACmpWinIdx].DeviceInfo.DeviceBitness = db32 then
        PhysicalAddrToKseg(AddressStr);

      Address := HexToInt(AddressStr);

      ListOfFrmMemStatCompare[ACmpWinIdx].HighlightMemoryChunk(ASlotIdx, Address, FDeviceFlashInfo.Erase_Size, ScrollHighlightedNodesIntoView);
      Exit;
    end;
  end;
end;


procedure TfrmSimulatedMem.SendAllCmdsToCompareWindow;
var
  i: Integer;
  CmpWinIdx, SlotIdx: Integer;
  AppendUserNotes: Boolean;
begin
  CmpWinIdx := cmbCompareWindow.ItemIndex;
  SlotIdx := cmbSlots.ItemIndex;
  AppendUserNotes := chkAppendUserNotesOnCmpWindow.Checked;

  for i := 0 to FAllCommands.Count - 1 do
    SendCmdToCompareWindowByIndex(FAllCommands, i, CmpWinIdx, SlotIdx, AppendUserNotes);
end;


procedure TfrmSimulatedMem.SendSelectedCmdsToCompareWindow;
var
  Node: PVirtualNode;
  CmpWinIdx, SlotIdx: Integer;
  AppendUserNotes: Boolean;
begin
  Node := vstMemCommands.GetFirstSelected;
  if Node = nil then
    Exit;

  CmpWinIdx := cmbCompareWindow.ItemIndex;
  SlotIdx := cmbSlots.ItemIndex;
  AppendUserNotes := chkAppendUserNotesOnCmpWindow.Checked;

  repeat
    if vstMemCommands.Selected[Node] then
      SendCmdToCompareWindowByIndex(FAllCommands, Node^.Index, CmpWinIdx, SlotIdx, AppendUserNotes);
      
    Node := Node^.NextSibling;
  until Node = nil;
end;


procedure TfrmSimulatedMem.btnSendAllCmdToCompareWindowClick(Sender: TObject);
begin
  SendAllCmdsToCompareWindow;
end;


procedure TfrmSimulatedMem.btnSendSelectedCommandsClick(Sender: TObject);
begin
  SendSelectedCmdsToCompareWindow;
end;


procedure TfrmSimulatedMem.btnClearListOfCommandsClick(Sender: TObject);
begin
  FAllCommands.Clear;
  vstMemCommands.RootNodeCount := 0;
  vstMemCommands.Repaint;
end;


procedure TfrmSimulatedMem.btnTestFIFOAndDecoderClick(Sender: TObject);
var
  Value, LocalWrite_Size: Integer;
  i, j: Integer;
  s, Digit: string;
begin
  FFIFO.Put(CDevCmd_Pointer_Size + '=00000004');      //this decides how long the data would be in a '<cmd=data>' line
  FFIFO.Put(CDevCmd_ProgramFlash_Size + '=00040000'); //useful for verification only
  FFIFO.Put(CDevCmd_BootFlash_Size + '=00000BF0');    //useful for verification only
  FFIFO.Put(CDevCmd_Write_Size + '=00000080');        //_FLASH_WRITE_LATCH   //used by 'Write_Row' command
  FFIFO.Put(CDevCmd_Erase_Size + '=00000400');        //_FLASH_ERASE         //used by 'Erase' command

  LocalWrite_Size := $80; //128 bytes
  Value := $3F887733;
  s := '';
  for i := 0 to LocalWrite_Size shr 4 - 1 do   //(shr 2) shr 2
  begin
    Digit := '';
    for j := 0 to 3 do
      Digit := Digit + IntToHex(Value + j, 2);

    s := s + Digit;
    Inc(Value, 4);
  end;

  FFIFO.Put(CDevCmd_Write_Word + '=1D000018EE887733');
  FFIFO.Put(CDevCmd_Write_Row + '=1D000030' + s);
  FFIFO.Put(CDevCmd_Erase + '=1D000420');

  if not tmrReadFIFO.Enabled then  //since the timer is unavailable, read the FIFO here
    ReadFromFIFO;
end;


procedure TfrmSimulatedMem.cmbCompareWindowChange(Sender: TObject);
begin
  FillInListOfAvailableSlots;
end;


procedure TfrmSimulatedMem.cmbCOMPortDropDown(Sender: TObject);
begin
  UpdateListOfCOMPorts;
end;


procedure TfrmSimulatedMem.FillInListOfAvailableSlots;
var
  i, n, Selection: Integer;
begin
  Selection := cmbSlots.ItemIndex;

  cmbSlots.Items.Clear;
  if ListOfFrmMemStatCompare.Count = 0 then
    Exit;

  if cmbCompareWindow.ItemIndex > -1 then
  begin
    n := ListOfFrmMemStatCompare.Items[cmbCompareWindow.ItemIndex].GetSlotCount;

    for i := 1 to n do
      cmbSlots.Items.Add('Slot ' + IntToStr(i));

    if n > 0 then
      if Selection = -1 then
        cmbSlots.ItemIndex := 0
      else
        cmbSlots.ItemIndex := Selection;
  end;
end;


procedure TfrmSimulatedMem.FillInListOfAvailableCmpWindows;
var
  i: Integer;
  Selection: Cardinal;
begin
  Selection := 0; //maybe the combobox is out of sync with regard to ListOfFrmMemStatCompare.Count

  try
    if ListOfFrmMemStatCompare.Count > 0 then
      if cmbCompareWindow.ItemIndex > -1 then
        Selection := ListOfFrmMemStatCompare.Items[cmbCompareWindow.ItemIndex].Handle
  except
  end;

  cmbCompareWindow.Clear;

  for i := 0 to ListOfFrmMemStatCompare.Count - 1 do
    cmbCompareWindow.Items.Add('CmpWin ' + IntToStr(ListOfFrmMemStatCompare.Items[i].Handle));

  if ListOfFrmMemStatCompare.Count > 0 then
    cmbCompareWindow.ItemIndex := Selection;
end;


procedure TfrmSimulatedMem.CreateTh;
begin
  if FTh <> nil then
    TerminateTh;
  
  FTh := TComThread.Create(True);
  FTh.FreeOnTerminate := False;

  {$IFDEF VER180}
    FTh.Resume;
  {$ELSE}
    FTh.Start;
  {$ENDIF}
end;


procedure TfrmSimulatedMem.TerminateTh;
var
  tk: Int64;
begin
  if FTh = nil then
    Exit;
    
  try
    FTh.Terminate;

    tk := GetTickCount64;
    repeat
      Application.ProcessMessages;
      Sleep(1);
    until FTh.Terminated or (GetTickCount64 - tk > 1000);
  except
  end;

  try
    FreeAndNil(FTh);
  except
  end;
end;


procedure TfrmSimulatedMem.LoadSettingsFromIni;
var
  Ini: TMemIniFile;
  Baud, COMIndex: Integer;
  BaudStr: string;
begin    //opening again, the file from main window, because this window is not created when loading from main
  Ini := TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'MemStat.ini');
  try
    Left := Ini.ReadInteger('SimMemWindow', 'Left', Left);
    Top := Ini.ReadInteger('SimMemWindow', 'Top', Top);
    Width := Ini.ReadInteger('SimMemWindow', 'Width', Width);
    Height := Ini.ReadInteger('SimMemWindow', 'Height', Height);

    FComName := Ini.ReadString('SimMemWindow', 'ComName', 'COM0');
    Baud := Ini.ReadInteger('SimMemWindow', 'Baud', 256000);

    chkAutoScrollToSelectedCommands.Checked := Ini.ReadBool('SimMemWindow', 'AutoScrollToSelectedCommands', chkAutoScrollToSelectedCommands.Checked);
    chkAutoSendCommandsToCmpWindow.Checked := Ini.ReadBool('SimMemWindow', 'AutoSendCommandsToCmpWindow', chkAutoSendCommandsToCmpWindow.Checked);
    chkAppendUserNotesOnCmpWindow.Checked := Ini.ReadBool('SimMemWindow', 'AppendUserNotesOnCmpWindow', chkAppendUserNotesOnCmpWindow.Checked);
  finally
    Ini.Free;
  end;

  COMIndex := cmbCOMPort.Items.IndexOf(FComName);
  cmbCOMPort.ItemIndex := COMIndex;
                                                              
  BaudStr := IntToStr(Baud);
  cmbBaud.ItemIndex := cmbBaud.Items.IndexOf(BaudStr);
end;


procedure TfrmSimulatedMem.SaveSettingsToIni;
var
  Ini: TMemIniFile;
  Baud: Integer;
begin    //saving again, the file from main window
  Ini := TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'MemStat.ini');
  try
    Ini.WriteInteger('SimMemWindow', 'Left', Left);
    Ini.WriteInteger('SimMemWindow', 'Top', Top);
    Ini.WriteInteger('SimMemWindow', 'Width', Width);
    Ini.WriteInteger('SimMemWindow', 'Height', Height);

    Ini.WriteString('SimMemWindow', 'ComName', GetCurrentCOMName);

    if cmbBaud.ItemIndex = -1 then
      Baud := 0
    else
      Baud := StrToIntDef(cmbBaud.Items.Strings[cmbBaud.ItemIndex], 0);

    Ini.WriteInteger('SimMemWindow', 'Baud', Baud);

    Ini.WriteBool('SimMemWindow', 'AutoScrollToSelectedCommands', chkAutoScrollToSelectedCommands.Checked);
    Ini.WriteBool('SimMemWindow', 'AutoSendCommandsToCmpWindow', chkAutoSendCommandsToCmpWindow.Checked);
    Ini.WriteBool('SimMemWindow', 'AppendUserNotesOnCmpWindow', chkAppendUserNotesOnCmpWindow.Checked);

    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;


procedure TfrmSimulatedMem.CreateRemainingComponents;
var
  NewColum: TVirtualTreeColumn;
begin
  vstMemCommands := TVirtualStringTree.Create(Self);
  vstMemCommands.Parent := Self;

  vstMemCommands.Colors.UnfocusedSelectionColor := clGradientInactiveCaption;
  vstMemCommands.Font.Size := 8;
  vstMemCommands.Font.Height := -11;
  vstMemCommands.Font.Name := 'Tahoma';
  vstMemCommands.Font.Style := [];
  vstMemCommands.Left := 8;
  vstMemCommands.Top := 108;
  {$IFDEF UNIX}
    vstMemCommands.Width := 643;
  {$ELSE}
    vstMemCommands.Width := 673;
  {$ENDIF}
  vstMemCommands.Height := 183;
  vstMemCommands.Anchors := [akLeft, akTop, akRight, akBottom];
  vstMemCommands.Header.AutoSizeIndex := 0;
  vstMemCommands.Header.DefaultHeight := 17;
  vstMemCommands.Header.Font.Charset := DEFAULT_CHARSET;
  vstMemCommands.Header.Font.Color := clWindowText;
  vstMemCommands.Header.Font.Height := -11;
  vstMemCommands.Header.Font.Name := 'Tahoma';
  vstMemCommands.Header.Font.Style := [];
  vstMemCommands.Header.Options := vstMemCommands.Header.Options + [hoVisible];
  vstMemCommands.ParentShowHint := False;
  vstMemCommands.ShowHint := True;
  vstMemCommands.StateImages := imglstCmds;
  vstMemCommands.TabOrder := 8;
  vstMemCommands.TreeOptions.PaintOptions := [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages];
  vstMemCommands.TreeOptions.SelectionOptions := [toFullRowSelect, toRightClickSelect, toMultiSelect];
  vstMemCommands.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus];
  vstMemCommands.OnGetText := vstMemCommandsGetText;
  vstMemCommands.OnGetImageIndex := vstMemCommandsGetImageIndex;
  vstMemCommands.OnMouseUp := vstMemCommandsMouseUp;

  NewColum := vstMemCommands.Header.Columns.Add;
  NewColum.MinWidth := 73;
  NewColum.Position := 0;
  NewColum.Width := 73;
  NewColum.Text := 'Index';

  NewColum := vstMemCommands.Header.Columns.Add;
  NewColum.MinWidth := 10000;
  NewColum.Position := 1;
  NewColum.Width := 10000;
  NewColum.Text := 'Command';
end;


procedure TfrmSimulatedMem.FormCreate(Sender: TObject);
begin
  CreateRemainingComponents;

  FFIFO := TPollingFIFO.Create;
  FAllCommands := TStringList.Create;
  FCOMName := '';
  FTh := nil;

  tmrStartup.Enabled := True;
end;


procedure TfrmSimulatedMem.FormDestroy(Sender: TObject);
begin
  tmrReadFIFO.Enabled := False;
  FreeAndNil(FFIFO);
  FreeAndNil(FAllCommands);

  TerminateTh;

  try
    if COMIsConnected(FComName) then
      DisconnectFromCOM(FComName);
  except
  end;

  try
    SaveSettingsToIni;
  except
  end;
end;


procedure TfrmSimulatedMem.FormShow(Sender: TObject);
begin
  UpdateAvailableCmpWindowSelection;
end;


procedure TfrmSimulatedMem.UpdateAvailableCmpWindowSelection;
begin
  FillInListOfAvailableCmpWindows;
  FillInListOfAvailableSlots;
end;


procedure TfrmSimulatedMem.vstMemCommandsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
begin
  case Column of
    0: CellText := IntToStr(Node^.Index); 
    1: CellText := '"' + FAllCommands.Strings[Node^.Index] + '"';
  end;
end;


procedure TfrmSimulatedMem.vstMemCommandsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  s: string;
begin
  if Column = 1 then
  begin
    ImageIndex := 0;
    s := FAllCommands.Strings[Node^.Index];

    if Pos(CDevCmd_Erase + '=', s) = 1 then
      ImageIndex := 1
    else
      if Pos(CDevCmd_Write_Word + '=', s) = 1 then
        ImageIndex := 2
      else
        if Pos(CDevCmd_Write_Row + '=', s) = 1 then
          ImageIndex := 3;
  end;
end;


procedure TfrmSimulatedMem.vstMemCommandsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: PVirtualNode;
  CmpWinIdx, SlotIdx: Integer;
begin
  Node := vstMemCommands.GetFirstSelected;
  if Node = nil then
    Exit;

  CmpWinIdx := cmbCompareWindow.ItemIndex;
  SlotIdx := cmbSlots.ItemIndex;
  
  ListOfFrmMemStatCompare[CmpWinIdx].ClearMemoryHighlighting;
  repeat
    if vstMemCommands.Selected[Node] then
      HighlightCmdToCompareWindowByIndex(FAllCommands, Node^.Index, CmpWinIdx, SlotIdx);

    Node := Node^.NextSibling;
  until Node = nil;
end;



procedure TfrmSimulatedMem.ReadFromFIFO;
var
  FIFOContent: TStringList;
  i: Integer;
  CmpWinIdx, SlotIdx: Integer;
  AppendUserNotes: Boolean;
begin
  if FFIFO.GetLength = 0 then
    Exit;

  FIFOContent := TStringList.Create;
  try
    FFIFO.PopAll(FIFOContent);
    FAllCommands.AddStrings(FIFOContent);

    vstMemCommands.BeginUpdate;
    vstMemCommands.RootNodeCount := FAllCommands.Count;
    vstMemCommands.EndUpdate;

    lblAllReceivedCommands.Caption := 'All received commands (' + IntToStr(FAllCommands.Count) + '):';

    if chkAutoSendCommandsToCmpWindow.Checked then
    begin
      CmpWinIdx := cmbCompareWindow.ItemIndex;
      SlotIdx := cmbSlots.ItemIndex;
      AppendUserNotes := chkAppendUserNotesOnCmpWindow.Checked;

      for i := 0 to FIFOContent.Count - 1 do
        SendCmdToCompareWindowByIndex(FIFOContent, i, CmpWinIdx, SlotIdx, AppendUserNotes);
    end;
  finally
    FIFOContent.Free;
  end;
end;


procedure TfrmSimulatedMem.tmrReadFIFOTimer(Sender: TObject);
begin
  ReadFromFIFO;
end;


procedure TfrmSimulatedMem.tmrStartupTimer(Sender: TObject);
begin
  tmrStartup.Enabled := False;

  UpdateListOfCOMPorts;
  LoadSettingsFromIni;
end;

end.
