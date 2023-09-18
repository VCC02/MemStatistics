{
    Copyright (C) 2023 VCC
    creation date: 2014
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


unit MikroStuff;

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
    SysUtils, Variants, Classes, Graphics, MemTables,
  MemStatUtils, DefParser;

type
  TOnBeginLoadingLst = procedure(MaxLines: Integer) of object;
  TOnLoadingLstProgressUpdate = procedure(Position: Integer) of object;
  TOnEndLoadingLst = procedure(MaxLines: Integer) of object;
  TOnAddMemTableEntry = procedure(DataToBeAdded: PRoutinesRec) of object;
  TOnAddRawTableEntry = procedure(DataToBeAdded: PRoutinesRec) of object;

  
  TMikroComp = class(TComponent)
  private
    FDefsFolder: string;
    FAllowSearch: Boolean;
    FMemTableVisibleEntries: Cardinal;
    FRawTableVisibleEntries: Cardinal;

    FMemTable: TMemTable;
    FMainFormHandle: THandle;
    FAppTitle: string;

    FLstFile: TStringList;
    FLstAddr: TStringList;
    FLstAddrDec: TStringList;
    FLstSize: TStringList;
    FLstName: TStringList;
    FLstAddrRaw: TStringList;
    FLstAddrRawDec: TStringList;
    FLstDataRaw: TStringList;

  protected
    FOnBeginLoadingLst: TOnBeginLoadingLst;
    FOnLoadingLstProgressUpdate: TOnLoadingLstProgressUpdate;
    FOnEndLoadingLst: TOnEndLoadingLst;
    FOnAddMemTableEntry: TOnAddMemTableEntry;
    FOnAddRawTableEntry: TOnAddRawTableEntry;
    
  public
    procedure GetDeviceSections(var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
    procedure GetMemoryTranslationInfo(var ADest: TMemoryTranslationInfoArr; AListOfExcludedSectionsByDefName: string = '');
    procedure LoadMlk(DeviceName: string);
    procedure LoadLST(LstFileFnm: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property MemTable: TMemTable read FMemTable write FMemTable;
    property MainFormHandle: THandle read FMainFormHandle write FMainFormHandle;
    property AppTitle: string read FAppTitle write FAppTitle;

    property LstFile: TStringList read FLstFile write FLstFile;
    property LstAddr: TStringList read FLstAddr write FLstAddr;
    property LstAddrDec: TStringList read FLstAddrDec write FLstAddrDec;
    property LstSize: TStringList read FLstSize write FLstSize;
    property LstName: TStringList read FLstName write FLstName;
    property LstAddrRaw: TStringList read FLstAddrRaw write FLstAddrRaw;
    property LstAddrRawDec: TStringList read FLstAddrRawDec write FLstAddrRawDec;
    property LstDataRaw: TStringList read FLstDataRaw write FLstDataRaw;

    property DefsFolder: string read FDefsFolder write FDefsFolder;
    property AllowSearch: Boolean read FAllowSearch write FAllowSearch;
    property MemTableVisibleEntries: Cardinal read FMemTableVisibleEntries write FMemTableVisibleEntries;
    property RawTableVisibleEntries: Cardinal read FRawTableVisibleEntries write FRawTableVisibleEntries;

    property OnBeginLoadingLst: TOnBeginLoadingLst read FOnBeginLoadingLst write FOnBeginLoadingLst;
    property OnLoadingLstProgressUpdate: TOnLoadingLstProgressUpdate read FOnLoadingLstProgressUpdate write FOnLoadingLstProgressUpdate;
    property OnEndLoadingLst: TOnEndLoadingLst read FOnEndLoadingLst write FOnEndLoadingLst;
    property OnAddMemTableEntry: TOnAddMemTableEntry read FOnAddMemTableEntry write FOnAddMemTableEntry;
    property OnAddRawTableEntry: TOnAddRawTableEntry read FOnAddRawTableEntry write FOnAddRawTableEntry;
  end;

function LoadHEXFile(FileName: string; ConvertPHYToKSEG: Boolean; var DecodedHEX: THexContent; var DebugMessages: string): Boolean;


implementation


uses
  DeviceInfo;


constructor TMikroComp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLstFile := TStringList.Create;
  FLstAddr := TStringList.Create;
  FLstAddrDec := TStringList.Create;
  FLstSize := TStringList.Create;
  FLstName := TStringList.Create;
  FLstAddrRaw := TStringList.Create;
  FLstAddrRawDec := TStringList.Create;
  FLstDataRaw := TStringList.Create;
end;


destructor TMikroComp.Destroy;
begin
  FLstFile.Free;
  inherited Destroy;
end;


procedure TMikroComp.GetDeviceSections(var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
begin
  FMemTable.DeviceInfo.GetDeviceSections(ADestAllSections, AListOfExcludedSectionsByDefName);
end;


procedure TMikroComp.GetMemoryTranslationInfo(var ADest: TMemoryTranslationInfoArr; AListOfExcludedSectionsByDefName: string = '');
begin
  FMemTable.DeviceInfo.GetMemoryTranslationInfoArr(ADest, AListOfExcludedSectionsByDefName);
end;


procedure TMikroComp.LoadMlk(DeviceName: string);
var
  AStringList: TStringList;
  MlkFileName: string;
  i: Integer;
  s: string;
  AddrRange: TDefSectionAddrRangeArr;
  DefType: TMCUDef;
  SectionIndex: Integer;
  AMemTranslationInfo: TMemoryTranslationInfo;
  //TempRange: TDefSectionAddrRange;
begin
  MlkFileName := GetDefinitionFileName(FDefsFolder, DeviceName);

  if not FileExists(MlkFileName) then
  begin
//    MemTable.SetProgramFlashAddr($9D000000, $9D07FFFF);       //these default values are PIC32 specific
//    MemTable.SetBootFlashAddr($BFC00000, $BFC02FEF);
//    MemTable.SetRAMAddr($A0000000, $A001FFFF);
//    MemTable.SetCFGAddr($BFC02FF0, $BFC02FFF);
//    MemTable.SetEBIAddr($C0000000, $C0000000);
//    MemTable.SetSQIAddr($D0000000, $D0000000);
    
    MessageBox(FMainFormHandle, PChar('Definition file not found: '#13#10 + MlkFileName + #13#10 + 'Please set the "Defs" folder. The program will use ' + MemTable.DeviceInfo.DefaultChipName + ' settings.'), PChar(AppTitle), MB_ICONWARNING);
    Exit;
  end;

  AStringList := TStringList.Create;
  try
    AStringList.LoadFromFile(MlkFileName);
    DefType := CBoolToMCUDef[UpperCase(ExtractFileExt(MlkFileName)) = '.JSON'];

    s := '';
    for i := 0 to AStringList.Count - 1 do
    begin
      s := s + AStringList.Strings[i] + #3;
      if (DefType = mdMlk) and (Pos('<LIBRARIES>', AStringList.Strings[i]) > 0) then
        Break;
    end;

    for i := 0 to MemTable.DeviceInfo.GetDeviceSectionCount - 1 do
      if GetDefAddresses(DefType, s, MemTable.DeviceInfo.GetDeviceDefSectionNameByIndex(i), AddrRange) then
      begin
        SectionIndex := MemTable.DeviceInfo.GetIndexOfDeviceSectionByDefName(MemTable.DeviceInfo.GetDeviceDefSectionNameByIndex(i));
        if SectionIndex <> -1 then
        begin
          AMemTranslationInfo := MemTable.DeviceInfo.MemoryTranslationInfo[i];
          MemTable.DeviceInfo.SetDeviceSectionAddrRanges(SectionIndex, AddrRange, AMemTranslationInfo.Value, AMemTranslationInfo.Operation);
          MemTable.DeviceInfo.SectionFoundInDefFile[i] := True;
        end
        else
          MemTable.DeviceInfo.SectionFoundInDefFile[i] := False;
      end;
       
    for i := 0 to MemTable.DeviceInfo.GetDeviceSectionCount - 1 do
      {TempRange :=} MemTable.DeviceInfo.GetAddressRangesByIndex(i, 0);

    MemTable.DeviceInfo.UpdateRangeLengthsFromMemoryMinMax;
  finally
    AStringList.Free;
  end;
end;


procedure TMikroComp.LoadLST(LstFileFnm: string);        /////////////////////////////////////////////////this parser is PIC32 specific -  make sure it can read PIC16, PIC18, PIC24 and PIC32
const
  CmikroListExporterVersion = ';  LST file generated by mikroListExporter - v.2.0 ';
  CRoutinesHeader = '//** Routines locations **';
var
  i: Integer;
  s: string;
  AddrStr, SizeStr, NameStr, DataStr: string;
  HeaderFound: Boolean;
  Address, PrevAddress, BlockAddress, Size: Cardinal;
  LastRawBlock: Boolean;
  vstData: TRoutinesRec;

  LstFileCount: Integer;
begin
  if not FileExists(LstFileFnm) then
  begin
    MessageBox(FMainFormHandle, PChar('File "' + LstFileFnm + '" not found.'), PChar(AppTitle), MB_ICONERROR);
    Exit;
  end;

  FLstFile.LoadFromFile(LstFileFnm);
  s := FLstFile.Strings[0];

  MemTable.Clear;

  FLstAddr.Clear;
  FLstAddrDec.Clear;
  FLstSize.Clear;
  FLstName.Clear;
  FLstAddrRaw.Clear;
  FLstDataRaw.Clear;
  FLstAddrRawDec.Clear;

  Address := 0;
  Size := 4;
  BlockAddress := 0;
  LastRawBlock := False;

  LstFileCount := FLstFile.Count;
  if Assigned(OnBeginLoadingLst) then
    FOnBeginLoadingLst(LstFileCount);

  FMemTableVisibleEntries := 0;
  FRawTableVisibleEntries := 0;

  //check mikroListExporter version

  s := Trim(s);
  if s <> ';  LST file generated by mikroListExporter - v.2.0' then
    MessageBox(FMainFormHandle, 'This application was compiled for mikroListExporter - v.2.0. Another version was detected. The parser may crash.', PChar(AppTitle), MB_ICONWARNING);

  HeaderFound := False;  //RoutinesHeader
  for i := 0 to LstFileCount - 1 do
  begin
    if i and 4095 = 4095 then
      if Assigned(OnLoadingLstProgressUpdate) then
        FOnLoadingLstProgressUpdate(i);

    s := FLstFile.Strings[i];
    if i > 3 then
      if FLstFile.Strings[i - 3] = CRoutinesHeader then
        HeaderFound := True;

    if HeaderFound then            //mem routines
    begin
      if Pos('0x', s) = 1 then
      begin
        AddrStr := Copy(s, 3, 8);
        SizeStr := Copy(s, Pos('[', s) + 1, Pos(']', s) - Pos('[', s) - 1);
        NameStr := Copy(s, Pos(']', s) + 5, MaxInt);

        FLstAddr.Add(AddrStr);
        FLstAddrDec.Add(IntToStr(HexToInt(AddrStr)));
        FLstSize.Add(SizeStr);
        FLstName.Add(NameStr);

        MemTable.AddEntry(HexToInt(AddrStr), StrToInt(SizeStr), NameStr);

        if Assigned(OnAddMemTableEntry) then
        begin
          vstData.EntryNumber := lstAddr.Count - 1;
          vstData.Address := HexToInt(AddrStr);
          vstData.Size := StrToInt(SizeStr);
          vstData.Name := NameStr;
          OnAddMemTableEntry(@vstData);
          //AddMemTableEntry(@vstData);
        end;
        Inc(FMemTableVisibleEntries);

        if not LastRawBlock then
        begin
          LastRawBlock := True;
          MemTable.AddEntryFromRaw(BlockAddress, Size, '');
        end;
      end;
    end
    else //before header - raw addresses (no routine names)
    begin
      if Pos('0x', s) = 1 then
      begin
        AddrStr := Copy(s, 3, 8);
        DataStr := Trim(Copy(s, 11, MaxInt));
        FLstAddrRaw.Add(AddrStr);
        FLstAddrRawDec.Add(IntToStr(HexToInt(AddrStr)));
        FLstDataRaw.Add(DataStr);

        PrevAddress := Address;
        Address := HexToInt(AddrStr);

        MemTable.AddRawEntry(Address);

        if Assigned(OnAddRawTableEntry) then
        begin
          vstData.EntryNumber := lstAddrRaw.Count - 1;
          vstData.Address := HexToInt(AddrStr);
          vstData.Size := 4;
          vstData.Name := DataStr;
          OnAddRawTableEntry(@vstData);
          //AddRawTableEntry(@vstData);
        end;
        Inc(FRawTableVisibleEntries);

        {if Address = $9D01F130 then       //Debug code
          Caption := 'Break';}

        if Address - PrevAddress = 4 then
          Inc(Size, 4)
        else
        begin  //found a new block, add it to list
          if BlockAddress > 0 then
          begin
            MemTable.AddEntryFromRaw(BlockAddress, Size, '');
          end;
          Size := 4;
        end;
          
        if Address - PrevAddress > 4 then
          BlockAddress := Address;
      end;
    end;
  end;

  if Assigned(OnEndLoadingLst) then
    OnEndLoadingLst(FLstAddrRaw.Count);
end;




{Loads a hex file from disk and decodes it into addresses and data.
Limitations: Function does not check for hex file integrity.
             Function assumes the hex file exists and is readable.

Returns true if successful.

Parameters:
FileName - .HEX file.
ConvertPHYToKSEG - if true, the physical addresses read from hex file are converted to virtual addresses.
DecodedHEX - content of the decoded hex file.
DebugMessage - contains an error message in case of error.

Details about hex file format: http://en.wikipedia.org/wiki/Intel_HEX
}
//{$DEFINE DebugMessages}
function LoadHEXFile(FileName: string; ConvertPHYToKSEG: Boolean; var DecodedHEX: THexContent; var DebugMessages: string): Boolean;
var
  i: Integer;
  ByteCount: Word;
  AddrWord: Word;   //read from hex
  CurrentAddress: Cardinal; //computed address
  BaseAddress: Cardinal;
  RecordType: Byte;
  Data: Cardinal; //string read from hex
  Data1: Cardinal;
  Data2: Cardinal;
  Data3: Cardinal;
  Data4: Cardinal;
  s, Field: string;
  Data2Found, Data3Found, Data4Found: Boolean;

  lstHexFile: TStringList;
  ResultMessages: TStringList;
begin
  Result := True;
  lstHexFile := TStringList.Create;
  ResultMessages := TStringList.Create;
  SetLength(DecodedHEX, 0); 

  if not FileExists(FileName) then
  begin
    MessageBox(0, PChar(FileName + ' does not exist.'), 'PIC32 Memory Statistics', MB_ICONERROR);
    Exit;
  end;

  try
    BaseAddress := 0;
    lstHexFile.LoadFromFile(FileName);

    for i := 0 to lstHexFile.Count - 1 do
    begin
      s := lstHexFile.Strings[i];

      Field := Copy(s, 2, 2);
      ByteCount := HexToInt(Field);

      Field := Copy(s, 4, 4);
      AddrWord := HexToInt(Field);

      Field := Copy(s, 8, 2);
      RecordType := HexToInt(Field);

      Field := Copy(s, 10, ByteCount shl 1{* 2});
      Data := 0;
      Data1 := 0;
      Data2 := 0;
      Data3 := 0;
      Data4 := 0;

      Data2Found := False;
      Data3Found := False;
      Data4Found := False;

      if RecordType = 0 then
      begin
        Data := HexToInt(Copy(Field, 1, 8));

        Data1 := HexToInt(Copy(Field, 1, 8));
        Delete(Field, 1, 8);

        if ByteCount > 4 then
        begin
          Data2 := HexToInt(Copy(Field, 1, 8));
          Delete(Field, 1, 8);
          Data2Found := True;
        end;

        if ByteCount > 8 then
        begin
          Data3 := HexToInt(Copy(Field, 1, 8));
          Delete(Field, 1, 8);
          Data3Found := True;
        end;

        if ByteCount > 12 then
        begin
          Data4 := HexToInt(Copy(Field, 1, 8));
          Delete(Field, 1, 8);
          Data4Found := True;
        end;
      end;

      if (RecordType = 2) or (RecordType = 4) then
        Data := HexToInt(Field);

      case RecordType of
        0:
        begin
          CurrentAddress := BaseAddress + AddrWord;

          SetLength(DecodedHEX, Length(DecodedHEX) + 1);
          DecodedHEX[Length(DecodedHEX) - 1].HAddr := CurrentAddress + CAddressOffset_Data1;
          DecodedHEX[Length(DecodedHEX) - 1].HData := Swap4BytesHex(Data1);

          if Data2Found then
          begin
            SetLength(DecodedHEX, Length(DecodedHEX) + 1);
            DecodedHEX[Length(DecodedHEX) - 1].HAddr := CurrentAddress + CAddressOffset_Data2;
            DecodedHEX[Length(DecodedHEX) - 1].HData := Swap4BytesHex(Data2);
          end;

          if Data3Found then
          begin
            SetLength(DecodedHEX, Length(DecodedHEX) + 1);
            DecodedHEX[Length(DecodedHEX) - 1].HAddr := CurrentAddress + CAddressOffset_Data3;
            DecodedHEX[Length(DecodedHEX) - 1].HData := Swap4BytesHex(Data3);
          end;

          if Data4Found then
          begin
            SetLength(DecodedHEX, Length(DecodedHEX) + 1);
            DecodedHEX[Length(DecodedHEX) - 1].HAddr := CurrentAddress + CAddressOffset_Data4;
            DecodedHEX[Length(DecodedHEX) - 1].HData := Swap4BytesHex(Data4);
          end;
        end;

        {$IFDEF DebugMessages}
          1: ResultMessages.Add('End of file');
        {$ENDIF}

        2:
        begin
          BaseAddress := Data shl 4; //* 16;
          {$IFDEF DebugMessages}
            ResultMessages.Add('Record type 2 encountered.');
          {$ENDIF}
        end;

        3:
        begin
          {$IFDEF DebugMessages}
            ResultMessages.Add('Record type 3 is not handled.');
          {$ENDIF}
          Result := False;
        end;

        4: BaseAddress := Data shl 16; //* 65536;

        5:
        begin
          {$IFDEF DebugMessages}
            ResultMessages.Add('Record type 4 is not handled.');
          {$ENDIF}
          Result := False;
        end;
      end; //case RecordType of
    end; //for i

    //convert to KSEG
    if ConvertPHYToKSEG then                       /////////////////////////////// this should not be a feature of this function
      for i := 0 to Length(DecodedHEX) - 1 do
      begin
        s := IntToHex(DecodedHEX[i].HAddr, 8);
        PhysicalAddrToKseg(s);
        DecodedHEX[i].HAddr := HexToInt(s);
      end;
    //
    {$IFDEF DebugMessages}
      DebugMessages := ResultMessages.Text; //messages separated by CR+LF or LF depending on OS
    {$ENDIF}
  finally
    lstHexFile.Free;
    ResultMessages.Free;
  end;
end;              

end.
