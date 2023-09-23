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


unit MemStatUtils;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF} 

interface

uses
  {$IFDEF FPC}
    LCLIntf, LCLType,
  {$ELSE}
    Windows, 
  {$ENDIF}
	SysUtils, Graphics, Dialogs, Classes, Forms, VirtualTrees;

type
  TColorArr = array of TColor;
  
  TAllSlotsColorArr = array of record
    Slot1, Slot2, Slot3, Slot4: TColor;
  end;  
  
  PRoutinesRec = ^TRoutinesRec;
  TRoutinesRec = record
    EntryNumber: Cardinal;
    Address: Cardinal;
    Size: Cardinal;
    Name: string;
  end;

  THexEntry = record
    HAddr: DWord;
    HData: DWord;
    HAddrStr: string;
    HDataStr: string;
  end;

  THexContent = array of THexEntry;

  TDefSectionAddrRange = record
    MinAddr, MaxAddr: Cardinal;
    Len: Cardinal;  //(MaxAddr - MinAddr + 1) shr ShiftAmount.   ShiftAmount is:  1 for PIC16/PIC18,   2 for PIC24/dsPIC,   4 for PIC32.   Computed in SetRangeLengthsFromMemoryMinMax below.
  end;

  TDefSectionAddrRangeArr = array of TDefSectionAddrRange;
  TDefSectionAddrRangeArrArr = array of TDefSectionAddrRangeArr;

  TAddressOffset = record
    S1, S2: Integer; //scheme 1, scheme 2  - mostly for PIC32, where there are two addressing schemes, like KSEG0 / KSEG1  or  KSEG2 / KSEG3 .  Other architectures might not need this.
  end;

  TAddressOffsetArr = array of TAddressOffset;

  TSection = record
    DisplayName: string;
    LongDisplayName: string; //'Program Flash' vs. 'PFM'    'Boot Flash vs. 'BFM'
    DefName: string;
    AddrRanges: TDefSectionAddrRangeArr;
    //see code like GetIndexOfDeviceSectionByDefName and GetDeviceSectionAddrRanges if adding new members.  Better, rename one of the existing members, to get errors about all the places where this structure is used. Updated it, then rename back.
  end;

  TSectionArr = array of TSection;
  
  TFileSlot = record
    DecodedHEX: THexContent;
    //LST
    FileNameHex: TFileName;
    FileNameLst: TFileName;
    HasHex: Boolean; //has content
    HasLst: Boolean; //has content
    FullHEX: THexContent;
    
    Sections: TSectionArr;
  end;

  PFileSlot = ^TFileSlot;
  PFileSlotArr = array of PFileSlot;

  TAddressTranslationOperation = (atoNone, atoADD, atoOR);
  TDeviceBitness = (db8, db16, db32);
  TDefsFolderPriority = (dfpDefFolder, dfpLocal);

  TMemoryTranslationInfo = record
    Operation: TAddressTranslationOperation;
    Value: DWord;
  end;

  TMemoryTranslationInfoArr = array of TMemoryTranslationInfo;

  TDevInfoEdit = record
    Section: TSection;
    MemoryTranslationInfo: TMemoryTranslationInfo;
    AddressOffsets: TAddressOffset;
    DefaultAddrRange: TDefSectionAddrRange; //single min-max address range, used in case it can't be found in definition file

    EntryColor: TColor;
    SelectedEntryColor: TColor;
    TableEntryColor: TColor;
    TableTextColor: TColor;

    VisibleOnTable: Boolean;
    VisibleOnCompare: Boolean;
    DisplayEvenIfMissingFromDefinition: Boolean;
  end;

  TDevInfoEditArr = array of TDevInfoEdit;

  TMemStatColorOptions = record
    FirstFileEntryChart: TColor;
    SecondFileEntryChart: TColor;
    ThirdFileEntryChart: TColor;
    FourthFileEntryChart: TColor;

    FirstFileSelectedEntryChart: TColor;
    SecondFileSelectedEntryChart: TColor;
    ThirdFileSelectedEntryChart: TColor;
    FourthFileSelectedEntryChart: TColor;

    Overlap: TColor;
    UseOverlapColor: Boolean; //False = average color, True = Selected Overlap color

    TextBackgroundChart: TColor;
    TextColorChart: TColor;

    BackgroundChart: TColor;
    LineChart: TColor;

    //Duplicates of TDevInfoEditArr colors.  ///////////////////////////////// To be decided which one to keep. Or, use the following arrays as column positions for TDevInfoEditArr.
    EntryColorArr: TColorArr;          //EntryColor
    SelectedEntryColorArr: TColorArr;  //SelectedEntryColor
    EntryColorTableArr: TColorArr;     //TableEntryColor       //this should eventually be removed, because it can be replaced by TDevInfoEditArr.TableEntryColor
    TextColorTableArr: TColorArr;      //TableTextColor
  end;

  TMemStatMiscOptions = record
    DisplayDecimalAddressesCmpTable: Boolean;
    DisplayTableHints: Boolean;
    DisplayChartHints: Boolean;
    DisplayZoomWindow: Boolean;

    DefaultChipName: string; //Used when no chip is provided from cmdline. It should be prefixed by the full prefix name (e.g. "PIC" instead of "P").
    DefFilePrefix: string; //e.g. "P32", "P24", "P30", "P33"
    ExpectedPrefix: string;  //e.g. "PIC32", "PIC24", "PIC30", "PIC33"
    DeviceBitness: TDeviceBitness; // db8, db16, db32

    DefsFolder: string;
    DefsFolderPriority: TDefsFolderPriority;
  end;

  TMemStatOptions = record
    Colors: TMemStatColorOptions;
    Misc: TMemStatMiscOptions;
    DevInfoEditArr: TDevInfoEditArr;
  end;


procedure Line(Cnv: TCanvas; x1, y1, x2, y2: Integer);
function HexaDigitToByte(ch: Char): Byte;
function Pow16(x: Byte): Integer;
function HexToInt(s: string): Integer;
function AverageColor(var Src: array of TColor): TColor;
function WeightedAverage2Colors(Color1, Color2: TColor; Weight1: Extended): TColor; //Weight1 can be 0 to 1
function IncreaseBrightnessBy8(SrcColor: TColor): TColor;
function DecreaseBrightnessBy8(SrcColor: TColor): TColor;

function IsDir(fa: Integer): Boolean;
function Swap4BytesHex(Number: DWord): DWord;
procedure PhysicalAddrToKseg(var CurrentAddressKSEGStr: string);
function CompareTwoMemStatColorOptions(Op1, Op2: TMemStatColorOptions): Boolean;
procedure SaveTableToFile(Handle: THandle; TableContent: string; SaveDialog: TSaveDialog);

function GetNodeByIndex(ATree: TVirtualStringTree; AIndex: Cardinal): PVirtualNode;
function SelectNodeByIndex(ATree: TVirtualStringTree; AIndex: Cardinal): PVirtualNode; //returns node
procedure ScrollIntoViewNodeByIndex(vst: TVirtualStringTree; AIndex: Cardinal; SelectNode: Boolean);
procedure AddTrailingSlash(var s: string); overload;
procedure AddTrailingSlash(var s: TFileName); overload;

function GetLocalDefinitionFileName: string;
function GetDefinitionFileName(ADefsFolder, ADeviceName: string; ADefsFolderPriority: TDefsFolderPriority): string;

procedure GetAllSlotsLengths(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; out Len1, Len2, Len3, Len4: Integer);
procedure InitSlotSectionLengths(var Slot: TFileSlot);
procedure GetSections(AFileSlot: TFileSlot; var ASections: TSectionArr);
procedure GetSectionsFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; var ASections: TSectionArr);

function GetAddressFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; EntryIndex: Int64): DWord;
function GetAddressStrFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; EntryIndex: Int64): string;

function GetSumOfSectionLengths(var ASectionLengths: TDefSectionAddrRangeArr): DWord;
function GetSectionIndexByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64; ComputeMemRange: Boolean; out MemRangeIndex: Integer): Integer; overload;
function GetSectionIndexByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64): Integer; overload;
function GetDisplaySectionNameByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64; Default: string = ''): string;
function GetAccumulatedLen(var ASections: TSectionArr; SectionIndex: Integer): Int64;

function GetIndexOfDevSectionByDefName(var ADeviceSections: TSectionArr; SectionName: string): Integer;
procedure GetDevSections(var ASrcDeviceSections: TSectionArr; var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
function IsSameSectionContent(var ASections1, ASections2: TSectionArr): Boolean;
procedure SetDevSectionAddrRanges(var ADeviceSections: TSectionArr; ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
procedure SetRangeLengthsFromMemoryMinMax(var ADeviceSections: TSectionArr; AShiftAmout: Byte = 0);

procedure UpdateDevBitness(ADeviceBitness: TDeviceBitness; out ADevShiftAmount, ADevPointerSize: Byte);
procedure GetDeviceMemoryContentFromLocalFile(ADeviceName: string; AMemSectionNames: TStringList; var AAddressRanges: TDefSectionAddrRangeArrArr);
procedure GetListOfDevicesFromLocalFile(AListOfDevices: TStringList);

const
  CAddressOffset_Data1: DWord = 0;
  CAddressOffset_Data2: DWord = 4;
  CAddressOffset_Data3: DWord = 8;
  CAddressOffset_Data4: DWord = 12;

  CLocalDefsFile = 'Defs.ini';

implementation


uses
  Math, IniFiles;


procedure Line(Cnv: TCanvas; x1, y1, x2, y2: Integer);
begin
  with Cnv do
  begin
    MoveTo(x1, y1);
    LineTo(x2, y2);
  end;
end;


function HexaDigitToByte(ch: Char): Byte;
begin
  Result := 0;
  Ch := UpCase(Ch);
  if Ch in ['0'..'9'] then
    Result := Ord(Ch) - 48;

  if Ch in ['A'..'F'] then
    Result := Ord(Ch) - 65 + 10;
end;


function Pow16(x: Byte): Integer;
var
  i: Byte;
begin
  Result := 1;
  for i := 1 to x do
    Result := Result shl 4;
end;


function HexToInt(s: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Length(s) = 0 then
    Exit;

  for i := Length(s) downto 1 do
    if s[i] in ['0'..'9', 'a'..'f', 'A'..'F'] then
      Result := Result + HexaDigitToByte(s[i]) * Pow16(Length(s) - i);

  if s[1] = '-' then
    Result := - Result;
end;


function AverageColor(var Src: array of TColor): TColor;
var
  i: Integer;
  R, G, B: TColor;
begin
  if Length(Src) = 0 then
    Result := 0
  else
  begin
    R := 0;
    G := 0;
    B := 0;
    for i := 0 to Length(Src) - 1 do
    begin
      R := R + Src[i] and $000000FF;
      G := G + (Src[i] shr 8) and $000000FF;
      B := B + (Src[i] shr 16) and $000000FF;
    end;
    R := Round(R / Length(Src));
    G := Round(G / Length(Src));
    B := Round(B / Length(Src));

    Result := B and $000000FF;
    Result := Result shl 8;
    Result := Result + (G and $000000FF);
    Result := Result shl 8;
    Result := Result + (R and $000000FF);
  end;
end;


function WeightedAverage2Colors(Color1, Color2: TColor; Weight1: Extended): TColor; //Weight1 can be 0 to 1
var
  R, G, B: TColor;
  R1, G1, B1: TColor;
  R2, G2, B2: TColor;
  Weight2: Extended;
begin
  Weight2 := 1 - Weight1;

  R1 := Color1 and $000000FF;
  G1 := (Color1 shr 8) and $000000FF;
  B1 := (Color1 shr 16) and $000000FF;

  R2 := Color2 and $000000FF;
  G2 := (Color2 shr 8) and $000000FF;
  B2 := (Color2 shr 16) and $000000FF;

  {R := Round((R1 * Weight1 + R2 * Weight2) / 2);
  G := Round((G1 * Weight1 + G2 * Weight2) / 2);
  B := Round((B1 * Weight1 + B2 * Weight2) / 2); }

  R := Min(Round(R1 + R2 * Weight2), 255);
  G := Min(Round(G1 + G2 * Weight2), 255);
  B := Min(Round(B1 + B2 * Weight2), 255);

  Result := B and $000000FF;
  Result := Result shl 8;
  Result := Result + (G and $000000FF);
  Result := Result shl 8;
  Result := Result + (R and $000000FF);
end;


function IncreaseBrightnessBy8(SrcColor: TColor): TColor;
var
  R, G, B: TColor;
begin
  R := SrcColor and $000000FF;
  G := (SrcColor shr 8) and $000000FF;
  B := (SrcColor shr 16) and $000000FF;

  Inc(R, 12);
  if R > 255 then
    R := 255;

  Inc(G, 12);
  if G > 255 then
    G := 255;

  Inc(B, 12);
  if B > 255 then
    B := 255;    

  Result := B and $000000FF;
  Result := Result shl 8;
  Result := Result + (G and $000000FF);
  Result := Result shl 8;
  Result := Result + (R and $000000FF);
end;


function DecreaseBrightnessBy8(SrcColor: TColor): TColor;
var
  R, G, B: TColor;
begin
  SrcColor := SrcColor and $00FFFFFF;
  R := SrcColor and $000000FF;
  G := (SrcColor shr 8) and $000000FF;
  B := (SrcColor shr 16) and $000000FF;

  Dec(R, 12);
  if R < 0 then
    R := 0;

  Dec(G, 12);
  if G < 0 then
    G := 0;

  Dec(B, 12);
  if B < 0 then
    B := 0;

  Result := B and $000000FF;
  Result := Result shl 8;
  Result := Result + (G and $000000FF);
  Result := Result shl 8;
  Result := Result + (R and $000000FF);
end;


function IsDir(fa: Integer): Boolean;
begin
  Result := (fa and 16) = 16;
end;

{Converts from Byte3:Byte2:Byte1:Byte0 to Byte0:Byte1:Byte2:Byte3
}
function Swap4BytesHex(Number: DWord): DWord;
begin
  Result := (Number and $000000FF) shl 24 + (Number and $0000FF00) shl 8 + (Number and $00FF0000) shr 8 + (Number and $FF000000) shr 24;
end;

{PhysicalAddrToKseg - Converts from PHY address to KSEG address.
Program Flash addresses are converted to KSEG0.
RAM addresses are converted to KSEG1.
Boot Flash are converted to KSEG1.

Requirements: CurrentAddressKSEGStr should not contain characters like '$' or 'x'
}
procedure PhysicalAddrToKseg(var CurrentAddressKSEGStr: string);
begin
  if (CurrentAddressKSEGStr[1] = '0') and (CurrentAddressKSEGStr[2] = '0') then   //RAM
    CurrentAddressKSEGStr[1] := 'A';

  if (CurrentAddressKSEGStr[1] = '1') and (CurrentAddressKSEGStr[2] = 'D') then   //Program Flash
    CurrentAddressKSEGStr[1] := '9';

  if (CurrentAddressKSEGStr[1] = '1') and (CurrentAddressKSEGStr[2] = 'F') and (CurrentAddressKSEGStr[3] = 'C') then  //Bootflash
    CurrentAddressKSEGStr[1] := 'B';

  if (CurrentAddressKSEGStr[1] = '2') and (CurrentAddressKSEGStr[2] in ['0'..'3']) then   //EBI (PIC32MZ only)
    CurrentAddressKSEGStr[1] := 'C';

  if (CurrentAddressKSEGStr[1] = '3') and (CurrentAddressKSEGStr[2] in ['0'..'3']) then   //SQI (PIC32MZ only)
    CurrentAddressKSEGStr[1] := 'D';
end;


function CompareEntryColorTable(Op1, Op2: TMemStatColorOptions): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Length(Op1.EntryColorTableArr) - 1 do
    Result := Result and
             (Op1.EntryColorTableArr[i] = Op2.EntryColorTableArr[i]);
end;

//returns True if equal
function CompareTwoMemStatColorOptions(Op1, Op2: TMemStatColorOptions): Boolean;
begin
  Result :=
            (Op1.FirstFileEntryChart = Op2.FirstFileEntryChart) and
            (Op1.SecondFileEntryChart = Op2.SecondFileEntryChart) and
            (Op1.ThirdFileEntryChart = Op2.ThirdFileEntryChart) and
            (Op1.FourthFileEntryChart = Op2.FourthFileEntryChart) and
            (Op1.FirstFileSelectedEntryChart = Op2.FirstFileSelectedEntryChart) and
            (Op1.SecondFileSelectedEntryChart = Op2.SecondFileSelectedEntryChart) and
            (Op1.ThirdFileSelectedEntryChart = Op2.ThirdFileSelectedEntryChart) and
            (Op1.FourthFileSelectedEntryChart = Op2.FourthFileSelectedEntryChart) and
            (Op1.Overlap = Op2.Overlap) and
            (Op1.UseOverlapColor = Op2.UseOverlapColor) and
            (Op1.TextBackgroundChart = Op2.TextBackgroundChart) and
            (Op1.TextColorChart = Op2.TextColorChart) and
            (Op1.BackgroundChart = Op2.BackgroundChart) and
            (Op1.LineChart = Op2.LineChart) and
            CompareEntryColorTable(Op1, Op2)
            ;
end;

//SaveDialog.Filter should be 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
procedure SaveTableToFile(Handle: THandle; TableContent: string; SaveDialog: TSaveDialog);
var
  AStringList: TStringList;
begin
  AStringList := TStringList.Create;

  try
    AStringList.Text := TableContent;
    if SaveDialog.Execute then
    begin
      if SaveDialog.FilterIndex = 1 then //.txt  //no 0 position. FilterIndex starts at 1
        if Pos('.TXT', UpperCase(SaveDialog.FileName)) <> Length(SaveDialog.FileName) - 3 then  //no .txt extension
          SaveDialog.FileName := SaveDialog.FileName + '.txt';
              
      if FileExists(SaveDialog.FileName) then
      begin
        if MessageBox(Handle, 'Do you want to replace the existing file?', PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = IDYES then
          AStringList.SaveToFile(SaveDialog.FileName);
      end
      else  //file doesn't exist
        AStringList.SaveToFile(SaveDialog.FileName);
    end; //exec
  finally
    AStringList.Free;
  end;
end;


function GetNodeByIndex(ATree: TVirtualStringTree; AIndex: Cardinal): PVirtualNode;
var
  Node: PVirtualNode;
begin
  Node := ATree.GetFirst;

  if Node = nil then
  begin
    Result := nil;
    Exit;
  end;

  repeat
    if Node.Index = AIndex then
    begin
      Result := Node;
      Exit;
    end;

    Node := Node^.NextSibling;
  until Node = nil;

  Result := nil;
end;


function SelectNodeByIndex(ATree: TVirtualStringTree; AIndex: Cardinal): PVirtualNode;
var
  Node: PVirtualNode;
begin
  Node := GetNodeByIndex(ATree, AIndex);

  if Node <> nil then
    ATree.Selected[Node] := True;

  Result := Node; //even if nil
end;


procedure ScrollIntoViewNodeByIndex(vst: TVirtualStringTree; AIndex: Cardinal; SelectNode: Boolean);
var
  CurrentNode, FirstSel, ToSel: PVirtualNode;
  IsMultiSelect, Found: Boolean;
begin
  CurrentNode := vst.GetFirst;
  if CurrentNode = nil then
    Exit;

  FirstSel := vst.GetFirstSelected;  
  ToSel := nil;
  IsMultiSelect := toMultiSelect in vst.TreeOptions.SelectionOptions;

  if IsMultiSelect then
    vst.TreeOptions.SelectionOptions := vst.TreeOptions.SelectionOptions - [toMultiSelect];

  Found := False;
  try
    repeat
      if CurrentNode.Index = AIndex then
      begin
        if SelectNode then
        begin
          ToSel := CurrentNode;
          Found := True;
        end;

        vst.ScrollIntoView(CurrentNode, True, True);
        Exit;
      end;

      CurrentNode := CurrentNode.NextSibling;
    until CurrentNode = nil;
  finally
    if IsMultiSelect then
    begin
      vst.TreeOptions.SelectionOptions := vst.TreeOptions.SelectionOptions + [toMultiSelect];

      if not Found then
        if FirstSel <> nil then
          vst.Selected[FirstSel] := True;  //restore selection
    end;

    if ToSel <> nil then
      vst.Selected[ToSel] := True;
  end;
end;


procedure AddTrailingSlash(var s: string); overload;
const
  CSlash = {$IFDEF UNIX} '/' {$ELSE} '\' {$ENDIF};     //to be tested on Delphi XE.# (Linux build). Expected that "UNIX" is defined. Otherwise, something else has to be used.
begin
  if s[Length(s)] <> CSlash then
    s := s + CSlash;
end;


procedure AddTrailingSlash(var s: TFileName); overload;
begin
  AddTrailingSlash(string(s));
end;


function GetLocalDefinitionFileName: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + CLocalDefsFile;
end;


function GetDefinitionFileName(ADefsFolder, ADeviceName: string; ADefsFolderPriority: TDefsFolderPriority): string;
var
  DevName: string;
begin
  if ADefsFolderPriority = dfpLocal then
  begin
    Result := GetLocalDefinitionFileName;
    if FileExists(Result) then
      Exit; //do not look for other file
    // else look for file in defs folder 
  end;
  
  if (ADefsFolder = '') and (ADefsFolderPriority = dfpDefFolder) then
  begin  //look for local file
    Result := ExtractFilePath(ParamStr(0)) + CLocalDefsFile;
    if FileExists(Result) then
      Exit;

    Result := '';
    Exit;
  end;

  AddTrailingSlash(ADefsFolder);

  DevName := ADeviceName;
  Delete(DevName, 2, 2); // 'PIC32MX' -> 'P32MX'
  Result := ADefsFolder + DevName + '.mlk';

  if not FileExists(Result) then
  begin
    DevName := ADeviceName; //do not delete 'IC' from 'PIC' on necto
    Result := ADefsFolder + DevName + '.json';

    if not FileExists(Result) and (ADefsFolderPriority = dfpDefFolder) then
      Result := ExtractFilePath(ParamStr(0)) + CLocalDefsFile;  //Even if it doesn't exist, the caller should veriy it again.
  end;
end;


procedure GetAllSlotsLengths(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; out Len1, Len2, Len3, Len4: Integer);
begin
  Len1 := Length(AFileSlot1.FullHEX);
  Len2 := Length(AFileSlot2.FullHEX);
  Len3 := Length(AFileSlot3.FullHEX);
  Len4 := Length(AFileSlot4.FullHEX);
end;


procedure InitSlotSectionLengths(var Slot: TFileSlot);
var
  i, j: Integer;
begin
  for i := 0 to Length(Slot.Sections) - 1 do
  begin
    for j := 0 to Length(Slot.Sections[i].AddrRanges) - 1 do
      Slot.Sections[i].AddrRanges[j].Len := 0;

    Slot.Sections[i].DisplayName := '';
    Slot.Sections[i].LongDisplayName := '';
    Slot.Sections[i].DefName := '';

    for j := 0 to Length(Slot.Sections[i].AddrRanges) - 1 do
    begin
      Slot.Sections[i].AddrRanges[j].MinAddr := 0;
      Slot.Sections[i].AddrRanges[j].MaxAddr := 0;
    end;
  end;  
end;


procedure GetSections(AFileSlot: TFileSlot; var ASections: TSectionArr);
var
  i, j: Integer;
begin
  SetLength(ASections, Length(AFileSlot.Sections));

  for i := 0 to Length(AFileSlot.Sections) - 1 do
  begin
    SetLength(ASections[i].AddrRanges, Length(AFileSlot.Sections[i].AddrRanges));
    for j := 0 to Length(AFileSlot.Sections[i].AddrRanges) - 1 do
      ASections[i].AddrRanges[j].Len := AFileSlot.Sections[i].AddrRanges[j].Len;

    ASections[i].DisplayName := AFileSlot.Sections[i].DisplayName;
    ASections[i].LongDisplayName := AFileSlot.Sections[i].LongDisplayName;
    ASections[i].DefName := AFileSlot.Sections[i].DefName;

    SetLength(ASections[i].AddrRanges, Length(AFileSlot.Sections[i].AddrRanges));
    for j := 0 to Length(AFileSlot.Sections[i].AddrRanges) - 1 do
      ASections[i].AddrRanges[j] := AFileSlot.Sections[i].AddrRanges[j];
  end;
end;


procedure GetSectionsFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; var ASections: TSectionArr);
var
  Len1, Len2, Len3, Len4: Integer;
begin
  GetAllSlotsLengths(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4, Len1, Len2, Len3, Len4);

  if Len1 > 0 then
    GetSections(AFileSlot1, ASections)
  else
    if Len2 > 0 then
      GetSections(AFileSlot2, ASections)
    else
      if Len3 > 0 then
        GetSections(AFileSlot3, ASections)
      else
        if Len4 > 0 then
          GetSections(AFileSlot4, ASections)
        else
          Exit;
end;


function GetAddressFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; EntryIndex: Int64): DWord;
var
  Len1, Len2, Len3, Len4: Integer;
begin
  GetAllSlotsLengths(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4, Len1, Len2, Len3, Len4);

  if Len1 > 0 then
    Result := AFileSlot1.FullHEX[EntryIndex].HAddr
  else
    if Len2 > 0 then
      Result := AFileSlot2.FullHEX[EntryIndex].HAddr
    else
      if Len3 > 0 then
        Result := AFileSlot3.FullHEX[EntryIndex].HAddr
      else
        if Len4 > 0 then
          Result := AFileSlot4.FullHEX[EntryIndex].HAddr
        else
          Result := $FFFFFFFF; //some default value
end;


function GetAddressStrFromAllFileSlots(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4: TFileSlot; EntryIndex: Int64): string;
var
  Len1, Len2, Len3, Len4: Integer;
begin
  GetAllSlotsLengths(AFileSlot1, AFileSlot2, AFileSlot3, AFileSlot4, Len1, Len2, Len3, Len4);

  if Len1 > 0 then
    Result := AFileSlot1.FullHEX[EntryIndex].HAddrStr
  else
    if Len2 > 0 then
      Result := AFileSlot2.FullHEX[EntryIndex].HAddrStr
    else
      if Len3 > 0 then
        Result := AFileSlot3.FullHEX[EntryIndex].HAddrStr
      else
        if Len4 > 0 then
          Result := AFileSlot4.FullHEX[EntryIndex].HAddrStr
        else
          Result := ''; //some default value
end;


function GetSumOfSectionLengths(var ASectionLengths: TDefSectionAddrRangeArr): DWord;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(ASectionLengths) - 1 do
    Result := Result + ASectionLengths[i].Len;
end;


function GetSectionIndexByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64; ComputeMemRange: Boolean; out MemRangeIndex: Integer): Integer; overload;
var
  i, j: Integer;
  Acc, AccRange: Int64;
  SumOfSectionLengths: DWord;
begin
  Result := -1;
  Acc := 0;
  MemRangeIndex := -1;

  for i := 0 to Length(ASections) - 1 do
  begin
    SumOfSectionLengths := GetSumOfSectionLengths(ASections[i].AddrRanges);

    if (EntryIndex > Acc - 1) and (EntryIndex < Acc + SumOfSectionLengths) then
    begin
      Result := i;

      if ComputeMemRange then
      begin
        AccRange := Acc;
        for j := 0 to Length(ASections[i].AddrRanges) - 1 do
        begin
          if (EntryIndex > AccRange - 1) and (EntryIndex < AccRange + ASections[i].AddrRanges[j].Len) then
          begin
            MemRangeIndex := j;
            Exit;
          end;

          AccRange := AccRange + ASections[i].AddrRanges[j].Len;
        end;
      end;

      Exit;
    end;

    Acc := Acc + SumOfSectionLengths;
  end; //for i
end;


function GetSectionIndexByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64): Integer; overload;
var
  MemRangeIndex: Integer;
begin
  Result := GetSectionIndexByEntryIndex(ASections, EntryIndex, False, MemRangeIndex);
end;


function GetDisplaySectionNameByEntryIndex(var ASections: TSectionArr; EntryIndex: Int64; Default: string = ''): string;   //used for displaying section name or copying table to clipboard
var
  Index: Integer;
  MemRangeIndex: Integer;
begin
  Result := Default;
  Index := GetSectionIndexByEntryIndex(ASections, EntryIndex, True, MemRangeIndex);

  if Index > -1 then
  begin
    Result := ASections[Index].DisplayName;
    if (MemRangeIndex > -1) and (Length(ASections[Index].AddrRanges) > 1) then
      Result := Result + IntToStr(MemRangeIndex);
  end;
end;


function GetAccumulatedLen(var ASections: TSectionArr; SectionIndex: Integer): Int64;   //used to get section boundaries in the full hex display
var
  i: Integer;
  SumOfSectionLengths: DWord;
begin
  Result := 0;
  for i := 0 to SectionIndex - 1 do
  begin
    SumOfSectionLengths := GetSumOfSectionLengths(ASections[i].AddrRanges);
    Result := Result + SumOfSectionLengths {ASections[i].Len};
  end;
end;


function GetIndexOfDevSectionByDefName(var ADeviceSections: TSectionArr; SectionName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(ADeviceSections) - 1 do
    if ADeviceSections[i].DefName = SectionName then
    begin
      Result := i;
      Exit;
    end;
end;


procedure GetDevSections(var ASrcDeviceSections: TSectionArr; var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
var
  i, j, n: Integer;
  ListOfExcludedSections: TStringList;
begin
  ListOfExcludedSections := TStringList.Create;
  try
    ListOfExcludedSections.Text := AListOfExcludedSectionsByDefName;

    for i := 0 to Length(ASrcDeviceSections) - 1 do
    begin
      if ListOfExcludedSections.IndexOf(ASrcDeviceSections[i].DefName) > -1 then  //exclude this one
        Continue;

      n := Length(ADestAllSections);

      SetLength(ADestAllSections, n + 1);
      SetLength(ADestAllSections[n].AddrRanges, Length(ASrcDeviceSections[i].AddrRanges));

      for j := 0 to Length(ASrcDeviceSections[i].AddrRanges) - 1 do
        ADestAllSections[n].AddrRanges[j].Len := ASrcDeviceSections[i].AddrRanges[j].Len;

      ADestAllSections[n].DisplayName := ASrcDeviceSections[i].DisplayName;
      ADestAllSections[n].LongDisplayName := ASrcDeviceSections[i].LongDisplayName;
      ADestAllSections[n].DefName := ASrcDeviceSections[i].DefName;

      SetLength(ADestAllSections[n].AddrRanges, Length(ASrcDeviceSections[i].AddrRanges));

      for j := 0 to Length(ASrcDeviceSections[i].AddrRanges) - 1 do
        ADestAllSections[n].AddrRanges[j] := ASrcDeviceSections[i].AddrRanges[j];
    end;
  finally
    ListOfExcludedSections.Free;
  end;
end;


function IsSameSectionContent(var ASections1, ASections2: TSectionArr): Boolean;
var
  i, j: Integer;
begin
  Result := True;

  if Length(ASections1) <> Length(ASections2) then
  begin
    Result := False;
    Exit;
  end;

  for i := 0 to Length(ASections1) - 1 do
  begin
    if Length(ASections1[i].AddrRanges) <> Length(ASections2[i].AddrRanges) then
    begin
      Result := False;
      Exit;
    end;

    if Length(ASections1[i].AddrRanges) <> Length(ASections2[i].AddrRanges) then
    begin
      Result := False;
      Exit;
    end;

    for j := 0 to Length(ASections1[i].AddrRanges) - 1 do
      if ASections1[i].AddrRanges[j].Len <> ASections2[i].AddrRanges[j].Len then
      begin
        Result := False;
        Exit;
      end;

    if ASections1[i].DisplayName <> ASections2[i].DisplayName then
    begin
      Result := False;
      Exit;
    end;

    if ASections1[i].LongDisplayName <> ASections2[i].LongDisplayName then
    begin
      Result := False;
      Exit;
    end;

    if ASections1[i].DefName <> ASections2[i].DefName then
    begin
      Result := False;
      Exit;
    end;

    for j := 0 to Length(ASections1[i].AddrRanges) - 1 do
      if (ASections1[i].AddrRanges[j].MinAddr <> ASections2[i].AddrRanges[j].MinAddr) or
         (ASections1[i].AddrRanges[j].MaxAddr <> ASections2[i].AddrRanges[j].MaxAddr) then
      begin
        Result := False;
        Exit;
      end;
  end;
end;


procedure SetDevSectionAddrRanges(var ADeviceSections: TSectionArr; ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
var
  i: Integer;
begin
  if (ASectionIndex < 0) or (ASectionIndex > Length(ADeviceSections) - 1) then
    raise Exception.Create('Section index out of range when setting address ranges.');

  SetLength(ADeviceSections[ASectionIndex].AddrRanges, Length(AAddrRanges));

  for i := 0 to Length(AAddrRanges) - 1 do
  begin
    case ATranslationOperation of
      atoNone: //added later
      begin
        ADeviceSections[ASectionIndex].AddrRanges[i].MinAddr := AAddrRanges[i].MinAddr;
        ADeviceSections[ASectionIndex].AddrRanges[i].MaxAddr := AAddrRanges[i].MaxAddr;
      end;

      atoADD:
      begin
        ADeviceSections[ASectionIndex].AddrRanges[i].MinAddr := AAddrRanges[i].MinAddr + TranslationValue;
        ADeviceSections[ASectionIndex].AddrRanges[i].MaxAddr := AAddrRanges[i].MaxAddr + TranslationValue;
      end;

      atoOR:
      begin
        ADeviceSections[ASectionIndex].AddrRanges[i].MinAddr := AAddrRanges[i].MinAddr or TranslationValue;
        ADeviceSections[ASectionIndex].AddrRanges[i].MaxAddr := AAddrRanges[i].MaxAddr or TranslationValue;
      end;
    end;
  end;
end;


procedure SetRangeLengthsFromMemoryMinMax(var ADeviceSections: TSectionArr; AShiftAmout: Byte = 0);
var
  i, j: Integer;
begin
  for i := 0 to Length(ADeviceSections) - 1 do
  begin
    for j := 0 to Length(ADeviceSections[i].AddrRanges) - 1 do
      ADeviceSections[i].AddrRanges[j].Len := (ADeviceSections[i].AddrRanges[j].MaxAddr - ADeviceSections[i].AddrRanges[j].MinAddr + 1) shr AShiftAmout;
  end;
end;


procedure UpdateDevBitness(ADeviceBitness: TDeviceBitness; out ADevShiftAmount, ADevPointerSize: Byte);
begin
  case ADeviceBitness of
    db8:
    begin
      ADevShiftAmount := 0;
      ADevPointerSize := 1;
    end;

    db16:
    begin
      ADevShiftAmount := 1;
      ADevPointerSize := 2;
    end;

    db32:
    begin
      ADevShiftAmount := 2;
      ADevPointerSize := 4;
    end;

    else
    begin
      ADevShiftAmount := 2;
      ADevPointerSize := 4;
    end;
  end;
end;


procedure GetDeviceMemoryContentFromLocalFile(ADeviceName: string; AMemSectionNames: TStringList; var AAddressRanges: TDefSectionAddrRangeArrArr);
var
  Fnm, MemSectionName: string;
  Ini: TMemIniFile;
  i, j, RangeCount: Integer;
  MinKey, MaxKey, Suffix: string;
  MinAddrStr, MaxAddrStr: string;
begin
  Fnm := GetLocalDefinitionFileName;
  if not FileExists(Fnm) then
    Exit;

  //This can be optimized by opening the file as TStringList and cropping the section, then working with it.
  Ini := TMemIniFile.Create(Fnm);
  try
    SetLength(AAddressRanges, AMemSectionNames.Count);

    for i := 0 to AMemSectionNames.Count - 1 do
    begin
      MemSectionName := AMemSectionNames.Strings[i];
      RangeCount := Ini.ReadInteger(ADeviceName, MemSectionName + '_RangeCount', 1);   //the default value is 1, because it is expected that every memory section has at least one range

      SetLength(AAddressRanges[i], RangeCount);

      for j := 0 to RangeCount - 1 do
      begin
        if RangeCount = 1 then
        begin
          MinKey := MemSectionName + '_Min';
          MaxKey := MemSectionName + '_Max';
        end
        else
        begin
          Suffix := IntToStr(j);
          MinKey := MemSectionName + '_Min_' + Suffix;
          MaxKey := MemSectionName + '_Max_' + Suffix;
        end;

        MinAddrStr := Ini.ReadString(ADeviceName, MinKey, '0');
        MaxAddrStr := Ini.ReadString(ADeviceName, MaxKey, '0');

        AAddressRanges[i][j].MinAddr := HexToInt(MinAddrStr);
        AAddressRanges[i][j].MaxAddr := HexToInt(MaxAddrStr);
        AAddressRanges[i][j].Len := 0; //Computed later. Not needed here.
      end;
    end;
  finally
    Ini.Free;
  end;
end;


procedure GetListOfDevicesFromLocalFile(AListOfDevices: TStringList);
var
  Fnm: string;
  Ini: TMemIniFile;
begin
  Fnm := GetLocalDefinitionFileName;
  if not FileExists(Fnm) then
    Exit;

  Ini := TMemIniFile.Create(Fnm);
  try
    Ini.ReadSections(AListOfDevices);
  finally
    Ini.Free;
  end;
end;

end.
