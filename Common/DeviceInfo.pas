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


unit DeviceInfo;

interface

uses
  Windows, SysUtils, Classes, MemStatUtils;

type
  TDevicePrefix = record
    DefFile: string;   //P32,  P24, P30, P33
    Expected: string;  //PIC32,  PIC24, PIC30, PIC33
  end;

  TDevicePrefixArr = array of TDevicePrefix;
  
  TDeviceInfo = class
  private
    FDefaultChipName: string; //Fallback chip, used if the selected one is not available. It is usually a big chip, like PIC32MX795F512L (for PIC32 MemStat) and PIC24F512GU810 (for PIC24/dsPIC MemStat).
    FDevicePrefix: TDevicePrefixArr; //P32,  P24, P30, P33

    FDeviceBitness: TDeviceBitness;
    FDevShiftAmount: Byte;   //used in shl and shr operations  (it is:  1 for PIC16/PIC18,   2 for PIC24/dsPIC,   4 for PIC32)
    FDevPointerSize: Byte;  //used in "jumping" from one entry to another, at aligned addresses  (when incrementing by pointer size). Can be 1, 2, 4 (bytes).

    FDeviceSections: TSectionArr;    //contains address ranges
    FMemoryTranslationInfo: TMemoryTranslationInfoArr;
    FAddressOffsets: TAddressOffsetArr;
    FSectionFoundInDefFile: array of Boolean;

    function GetMemoryTranslationInfo(Index: Integer): TMemoryTranslationInfo;
    function GetSectionFoundInDefFile(Index: Integer): Boolean;
    procedure SetSectionFoundInDefFile(Index: Integer; Value: Boolean);

    procedure SetDeviceBitness(Value: TDeviceBitness);
    procedure UpdateDeviceBitness;

  public
    constructor Create;
    destructor Destroy; override;

    function GetDeviceSectionCount: Integer;
    function GetAddressRangesCountFromSection(ASectionIndex: Integer): Integer;
    function GetRangesLengthsCountFromSection(ASectionIndex: Integer): Integer;

    procedure AddDeviceSection(ADeviceSections: TSection);
    procedure AddMemoryTranslationInfo(AInfo: TMemoryTranslationInfo);  //expected to be called as may times as AddDeviceSection is called  (like TSection and TMemoryTranslationInfo would be part of the same structure)
    procedure AddAddressOffsets(AOffsets: TAddressOffset);
    procedure AddDevicePrefix(APrefix: TDevicePrefix); //e.g. a pair of 'P32' and 'PIC32'   - used for mlk filenames
    procedure ClearInfo;
    function HasSameSectionContent(var ASections: TSectionArr): Boolean;

    function GetReplacedDevPrefix(ADevName: string): string;

    function GetIndexOfDeviceSectionByDefName(SectionName: string): Integer;
    procedure GetDeviceSectionAddrRanges(var AAllSections: TSectionArr);
    procedure SetDeviceSectionAddrRanges(ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
    function GetDeviceDefSectionNameByIndex(ASectionIndex: Integer): string;
    function GetDeviceDisplaySectionNameByIndex(ASectionIndex: Integer): string;
    function GetDeviceDisplaySectionLongNameByIndex(ASectionIndex: Integer): string;
    function GetAddressRangesByIndex(ASectionIndex, ARangeIndex: Integer): TDefSectionAddrRange;
    function GetSumOfAllSectionLengths: DWord;
    function GetSectionLength(ASectionIndex: Integer): DWord;
    function GetAddressOffsetByIndex(ASectionIndex: Integer): TAddressOffset;
    procedure GetAddressOffsets(var AAddressOffsets: TAddressOffsetArr);
    procedure GetDeviceSections(var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
    procedure GetMemoryTranslationInfoArr(var ADest: TMemoryTranslationInfoArr; AListOfExcludedSectionsByDefName: string = '');
    procedure UpdateRangeLengthsFromMemoryMinMax;

    property DefaultChipName: string read FDefaultChipName write FDefaultChipName; //Fallback chip, used if the selected one is not available. It is usually a big chip, like PIC32MX795F512L (for PIC32 MemStat) and PIC24F512GU810 (for PIC24/dsPIC MemStat).
    property DeviceBitness: TDeviceBitness read FDeviceBitness write SetDeviceBitness;
    property MemoryTranslationInfo[Index: Integer]: TMemoryTranslationInfo read GetMemoryTranslationInfo;
    property DevShiftAmount: Byte read FDevShiftAmount;
    property DevPointerSize: Byte read FDevPointerSize;
    property SectionFoundInDefFile[Index: Integer]: Boolean read GetSectionFoundInDefFile write SetSectionFoundInDefFile;
  end;


implementation


constructor TDeviceInfo.Create;
begin
  SetLength(FDeviceSections, 0);
  SetLength(FDevicePrefix, 0);
  SetLength(FMemoryTranslationInfo, 0);
  SetLength(FAddressOffsets, 0);
  SetLength(FSectionFoundInDefFile, 0);

  FDeviceBitness := db32;   //some default value
  UpdateDeviceBitness;
end;


destructor TDeviceInfo.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(FDeviceSections) - 1 do
    SetLength(FDeviceSections[i].AddrRanges, 0);

  SetLength(FDeviceSections, 0);
  SetLength(FDevicePrefix, 0);
  SetLength(FMemoryTranslationInfo, 0);
  SetLength(FAddressOffsets, 0);
  SetLength(FSectionFoundInDefFile, 0);

  inherited Destroy;
end;


function TDeviceInfo.GetMemoryTranslationInfo(Index: Integer): TMemoryTranslationInfo;
begin
  if (Index < 0) or (Index > Length(FMemoryTranslationInfo) - 1) then
    raise Exception.Create('Index out of bounds (' + IntToStr(Index) + ') when reading MemoryTranslationInfo.');
  Result := FMemoryTranslationInfo[Index];
end;


function TDeviceInfo.GetSectionFoundInDefFile(Index: Integer): Boolean;
begin
  if (Index < 0) or (Index > Length(FSectionFoundInDefFile) - 1) then
    raise Exception.Create('Index out of bounds (' + IntToStr(Index) + ') when searching for section in def file.');

  Result := FSectionFoundInDefFile[Index];
end;


procedure TDeviceInfo.SetSectionFoundInDefFile(Index: Integer; Value: Boolean);
begin
  FSectionFoundInDefFile[Index] := Value;
end;


procedure TDeviceInfo.SetDeviceBitness(Value: TDeviceBitness);
begin
  if FDeviceBitness <> Value then
  begin
    FDeviceBitness := Value;
    UpdateDeviceBitness;
  end;
end;


procedure TDeviceInfo.UpdateDeviceBitness;
begin
  UpdateDevBitness(FDeviceBitness, FDevShiftAmount, FDevPointerSize);
end;


function TDeviceInfo.GetDeviceSectionCount: Integer;
begin
  Result := Length(FDeviceSections);
end;


function TDeviceInfo.GetAddressRangesCountFromSection(ASectionIndex: Integer): Integer;
begin
  Result := Length(FDeviceSections[ASectionIndex].AddrRanges);
end;


function TDeviceInfo.GetRangesLengthsCountFromSection(ASectionIndex: Integer): Integer;
begin
  Result := Length(FDeviceSections[ASectionIndex].AddrRanges);
end;


procedure TDeviceInfo.AddDeviceSection(ADeviceSections: TSection);
var
  n, i: Integer;
begin
  n := Length(FDeviceSections);
  SetLength(FDeviceSections, n + 1);

  SetLength(FDeviceSections[n].AddrRanges, Length(ADeviceSections.AddrRanges));

  for i := 0 to Length(FDeviceSections[n].AddrRanges) - 1 do
    FDeviceSections[n].AddrRanges[i].Len := ADeviceSections.AddrRanges[i].Len;

  FDeviceSections[n].DisplayName := ADeviceSections.DisplayName;
  FDeviceSections[n].LongDisplayName := ADeviceSections.LongDisplayName;
  FDeviceSections[n].DefName := ADeviceSections.DefName;

  SetLength(FDeviceSections[n].AddrRanges, Length(ADeviceSections.AddrRanges));

  for i := 0 to Length(FDeviceSections[n].AddrRanges) - 1 do
    FDeviceSections[n].AddrRanges[i] := ADeviceSections.AddrRanges[i];

  SetLength(FSectionFoundInDefFile, n + 1);
  FSectionFoundInDefFile[n] := False;
end;


procedure TDeviceInfo.AddMemoryTranslationInfo(AInfo: TMemoryTranslationInfo);
var
  n: Integer;
begin
  n := Length(FMemoryTranslationInfo);
  SetLength(FMemoryTranslationInfo, n + 1);
  FMemoryTranslationInfo[n] := AInfo;
end;


procedure TDeviceInfo.AddAddressOffsets(AOffsets: TAddressOffset);
var
  n: Integer;
begin
  n := Length(FAddressOffsets);
  SetLength(FAddressOffsets, n + 1);
  FAddressOffsets[n] := AOffsets;
end;


procedure TDeviceInfo.AddDevicePrefix(APrefix: TDevicePrefix);
begin
  SetLength(FDevicePrefix, Length(FDevicePrefix) + 1);
  FDevicePrefix[Length(FDevicePrefix) - 1] := APrefix;
end;


procedure TDeviceInfo.ClearInfo;
begin
  SetLength(FDeviceSections, 0);
  SetLength(FDevicePrefix, 0);
  SetLength(FMemoryTranslationInfo, 0);
  SetLength(FAddressOffsets, 0);
end;


function TDeviceInfo.GetIndexOfDeviceSectionByDefName(SectionName: string): Integer;
begin
  Result := GetIndexOfDevSectionByDefName(FDeviceSections, SectionName);
end;


procedure TDeviceInfo.GetDeviceSectionAddrRanges(var AAllSections: TSectionArr);
begin
  GetDevSections(FDeviceSections, AAllSections);
end;


procedure TDeviceInfo.SetDeviceSectionAddrRanges(ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
begin
  SetDevSectionAddrRanges(FDeviceSections, ASectionIndex, AAddrRanges, TranslationValue, ATranslationOperation);
end;


function TDeviceInfo.GetDeviceDefSectionNameByIndex(ASectionIndex: Integer): string;
begin
  if (ASectionIndex < 0) or (ASectionIndex > Length(FDeviceSections) - 1) then
    raise Exception.Create('Section name out of bounds (' + IntToStr(ASectionIndex) + ') when reading def name.');

  Result := FDeviceSections[ASectionIndex].DefName;
end;


function TDeviceInfo.GetDeviceDisplaySectionNameByIndex(ASectionIndex: Integer): string;
begin
  //if (ASectionIndex < 0) or (ASectionIndex > Length(FDeviceSections) - 1) then      //do not verify the index on every call, because this function will be called in long for loops
  //  raise Exception.Create('Section name out of bounds (' + IntToStr(ASectionIndex) + ') when reading display name.');

  Result := FDeviceSections[ASectionIndex].DisplayName;
end;


function TDeviceInfo.GetDeviceDisplaySectionLongNameByIndex(ASectionIndex: Integer): string;
begin
  //if (ASectionIndex < 0) or (ASectionIndex > Length(FDeviceSections) - 1) then      //do not verify the index on every call, because this function will be called in long for loops
  //  raise Exception.Create('Section name out of bounds (' + IntToStr(ASectionIndex) + ') when reading display name.');

  Result := FDeviceSections[ASectionIndex].LongDisplayName;
end;


function TDeviceInfo.GetAddressRangesByIndex(ASectionIndex, ARangeIndex: Integer): TDefSectionAddrRange;
begin
  if Length(FDeviceSections[ASectionIndex].AddrRanges) < ARangeIndex + 1 then
    SetLength(FDeviceSections[ASectionIndex].AddrRanges, ARangeIndex + 1);
                                                                             
  Result := FDeviceSections[ASectionIndex].AddrRanges[ARangeIndex];
end;


function TDeviceInfo.GetSectionLength(ASectionIndex: Integer): DWord;
begin
  Result := GetSumOfSectionLengths(FDeviceSections[ASectionIndex].AddrRanges);
end;


function TDeviceInfo.GetAddressOffsetByIndex(ASectionIndex: Integer): TAddressOffset;
begin
  Result := FAddressOffsets[ASectionIndex];
end;


procedure TDeviceInfo.GetAddressOffsets(var AAddressOffsets: TAddressOffsetArr);
var
  i: Integer;
begin
  SetLength(AAddressOffsets, Length(FAddressOffsets));
  for i := 0 to Length(FAddressOffsets) - 1 do
    AAddressOffsets[i] := FAddressOffsets[i];
end;


function TDeviceInfo.GetSumOfAllSectionLengths: DWord;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(FDeviceSections) - 1 do
    Result := Result + GetSumOfSectionLengths(FDeviceSections[i].AddrRanges);
end;


procedure TDeviceInfo.GetDeviceSections(var ADestAllSections: TSectionArr; AListOfExcludedSectionsByDefName: string = '');
begin
  GetDevSections(FDeviceSections, ADestAllSections, AListOfExcludedSectionsByDefName);
end;


procedure TDeviceInfo.GetMemoryTranslationInfoArr(var ADest: TMemoryTranslationInfoArr; AListOfExcludedSectionsByDefName: string = '');
var
  i: Integer;
  ListOfExcludedSections: TStringList;
begin
  if Length(FMemoryTranslationInfo) <> GetDeviceSectionCount then
    raise Exception.Create('Structures are not in sync.');  //maybe, one day, there will be a wrapper structure

  ListOfExcludedSections := TStringList.Create;
  try
    ListOfExcludedSections.Text := AListOfExcludedSectionsByDefName;

    for i := 0 to Length(FMemoryTranslationInfo) - 1 do
    begin
      if ListOfExcludedSections.IndexOf(FDeviceSections[i].DefName) > -1 then  //exclude this one
        Continue;
        
      SetLength(ADest, Length(ADest) + 1);
      ADest[Length(ADest) - 1] := FMemoryTranslationInfo[i];
    end;
  finally
    ListOfExcludedSections.Free;
  end;
end;


procedure TDeviceInfo.UpdateRangeLengthsFromMemoryMinMax;
begin
  SetRangeLengthsFromMemoryMinMax(FDeviceSections, FDevShiftAmount);
end;


function TDeviceInfo.GetReplacedDevPrefix(ADevName: string): string;
var
  i: Integer;
begin
  Result := ADevName;
  for i := 0 to Length(FDevicePrefix) - 1 do
    Result := StringReplace(Result, FDevicePrefix[i].DefFile, FDevicePrefix[i].Expected, [rfReplaceAll]);
end;


function TDeviceInfo.HasSameSectionContent(var ASections: TSectionArr): Boolean;
begin
  Result := IsSameSectionContent(ASections, FDeviceSections);
end;

end.
