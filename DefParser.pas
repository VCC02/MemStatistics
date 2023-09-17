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


unit DefParser;

interface

uses
  MemStatUtils;

type
  TMCUDef = (mdMlk, mdJson);

const
  CBoolToMCUDef: array[Boolean] of TMCUDef = (mdMlk, mdJson);

function GetDefAddresses(AMCUDef: TMCUDef; AMlkContent, ASectionName: string; var AAddressRange: TDefSectionAddrRangeArr): Boolean;  

implementation


uses
  SysUtils;


procedure AddAddrStrToRange(AMinAddrStr, AMaxAddrStr: string; var AAddressRange: TDefSectionAddrRangeArr);
begin
  SetLength(AAddressRange, Length(AAddressRange) + 1);
  AAddressRange[Length(AAddressRange) - 1].MinAddr := HexToInt(AMinAddrStr);
  AAddressRange[Length(AAddressRange) - 1].MaxAddr := HexToInt(AMaxAddrStr);

  if AAddressRange[Length(AAddressRange) - 1].MaxAddr < AAddressRange[Length(AAddressRange) - 1].MinAddr then
    AAddressRange[Length(AAddressRange) - 1].MaxAddr := AAddressRange[Length(AAddressRange) - 1].MinAddr + 1;
end;


//returns True if Section found
function GetMlkAddresses(AContent, ASectionName: string; var AAddressRange: TDefSectionAddrRangeArr): Boolean;
const
  CMIN_ADDR_FIELD_Open = '<MIN_ADDR>';
  CMIN_ADDR_FIELD_Close = '</MIN_ADDR>';
  CMAX_ADDR_FIELD_Open = '<MAX_ADDR>';
  CMAX_ADDR_FIELD_Close = '</MAX_ADDR>';
var
  StartSectionPos, EndSectionPos: Integer;
  Section: string;
  MinAddrStr, MaxAddrStr: string;
begin
  SetLength(AAddressRange, 0);
  StartSectionPos := Pos('<' + ASectionName + '>', AContent);

  if StartSectionPos = 0 then
  begin
    Result := False;
    Exit;
  end;

  while StartSectionPos > 0 do
  begin
    StartSectionPos := Pos('<' + ASectionName + '>', AContent);

    if StartSectionPos = 0 then
      Break;

    EndSectionPos := Pos('</' + ASectionName + '>', AContent);

    Section := Copy(AContent, StartSectionPos, EndSectionPos - StartSectionPos);

    Delete(AContent, 1, EndSectionPos + Length('</' + ASectionName + '>'));

    //reuse StartSectionPos and EndSectionPos for MIN_ADDR
    StartSectionPos := Pos(CMIN_ADDR_FIELD_Open, Section);
    EndSectionPos := Pos(CMIN_ADDR_FIELD_Close, Section);
    MinAddrStr := Copy(Section, StartSectionPos, EndSectionPos - StartSectionPos);

    //reuse StartSectionPos and EndSectionPos for MIN_ADDR
    StartSectionPos := Pos(CMAX_ADDR_FIELD_Open, Section);
    EndSectionPos := Pos(CMAX_ADDR_FIELD_Close, Section);
    MaxAddrStr := Copy(Section, StartSectionPos, EndSectionPos - StartSectionPos);

    Delete(MinAddrStr, 1, Length(CMIN_ADDR_FIELD_Open));
    Delete(MaxAddrStr, 1, Length(CMAX_ADDR_FIELD_Open));

    MinAddrStr := Trim(MinAddrStr);
    MaxAddrStr := Trim(MaxAddrStr);

    Delete(MinAddrStr, 1, 2); //delete '0x'
    Delete(MaxAddrStr, 1, 2); //delete '0x'

    if MinAddrStr > '' then
      AddAddrStrToRange(MinAddrStr, MaxAddrStr, AAddressRange);
  end;

  Result := True;
end;


function GetJsonAddresses(AContent, ASectionName: string; var AAddressRange: TDefSectionAddrRangeArr): Boolean;
const
  CMIN_ADDR_FIELD_Open = '"min_addr"';
  CMAX_ADDR_FIELD_Open = '"max_addr"';
var
  StartSectionPos, EndSectionPos: Integer;
  Section: string;
  MinAddrStr, MaxAddrStr: string;
  ContentAfterSection, SubSection: string;
  PosCol: Integer; // pos of ':'
  PosLeftCurlyBrace, PosRightCurlyBrace: Integer;    //  '{'  '}'
  PosLeftBracket{, PosRightBracket}: Integer;          //  '['  ']'
  MultiSection: Boolean;
begin
  SetLength(AAddressRange, 0);
  StartSectionPos := Pos('"' + ASectionName + '"', AContent);

  if StartSectionPos = 0 then
  begin
    Result := False;
    Exit;
  end;

  //StartSectionPos := Pos('"' + ASectionName + '"', AMlkContent);
  ContentAfterSection := Copy(AContent, StartSectionPos + Length(ASectionName) + 2, MaxInt);
  PosCol := Pos(':', ContentAfterSection);

  ContentAfterSection := Copy(ContentAfterSection, PosCol + 1, MaxInt); //the next non-whitespace character should be either '{' or '['

  PosLeftCurlyBrace := Pos('{', ContentAfterSection);
  PosLeftBracket := Pos('[', ContentAfterSection);

  MultiSection := ((PosLeftBracket > 0) and (PosLeftCurlyBrace > 0) and (PosLeftBracket < PosLeftCurlyBrace)) or
                  ((PosLeftBracket > 0) and (PosLeftCurlyBrace = 0)); // '[' is found before any '{'

  if MultiSection then
    EndSectionPos := Pos(']', ContentAfterSection)
  else
    EndSectionPos := Pos('}', ContentAfterSection);

  ContentAfterSection := Copy(ContentAfterSection, 1, EndSectionPos);

  PosLeftCurlyBrace := Pos('{', ContentAfterSection);
  while PosLeftCurlyBrace > 0 do
  begin
    PosLeftCurlyBrace := Pos('{', ContentAfterSection);
    Section := Copy(ContentAfterSection, PosLeftCurlyBrace, MaxInt);

    PosRightCurlyBrace := Pos('}', Section);
    Section := Copy(Section, 1, PosRightCurlyBrace);

    if (Section = '') or (Pos(',', Section) = 0) then   //expecting a pair of values
      Break;

    Delete(ContentAfterSection, Pos(Section, ContentAfterSection), Length(Section));

    //reuse StartSectionPos and EndSectionPos for MIN_ADDR
    StartSectionPos := Pos(CMIN_ADDR_FIELD_Open, Section);
    SubSection := Copy(Section, StartSectionPos, MaxInt);
    if Pos(',', SubSection) > 0 then
      Delete(SubSection, Pos(',', SubSection), MaxInt);

    MinAddrStr := Copy(SubSection, Length(CMIN_ADDR_FIELD_Open) + 1, MaxInt);
    MinAddrStr := StringReplace(MinAddrStr, #3, '', [rfReplaceAll]);
    MinAddrStr := StringReplace(MinAddrStr, '}', '', [rfReplaceAll]);
    MinAddrStr := StringReplace(MinAddrStr, ':', '', [rfReplaceAll]);

    //reuse StartSectionPos and EndSectionPos for MAX_ADDR
    StartSectionPos := Pos(CMAX_ADDR_FIELD_Open, Section);
    SubSection := Copy(Section, StartSectionPos, MaxInt);
    if Pos(',', SubSection) > 0 then
      Delete(SubSection, Pos(',', SubSection), MaxInt);

    MaxAddrStr := Copy(SubSection, Length(CMAX_ADDR_FIELD_Open) + 1, MaxInt);
    MaxAddrStr := StringReplace(MaxAddrStr, #3, '', [rfReplaceAll]);
    MaxAddrStr := StringReplace(MaxAddrStr, '}', '', [rfReplaceAll]);
    MaxAddrStr := StringReplace(MaxAddrStr, ':', '', [rfReplaceAll]);

    MinAddrStr := Trim(MinAddrStr);
    MaxAddrStr := Trim(MaxAddrStr);

    MinAddrStr := StringReplace(MinAddrStr, '"', '', [rfReplaceAll]);
    MaxAddrStr := StringReplace(MaxAddrStr, '"', '', [rfReplaceAll]);

    Delete(MinAddrStr, 1, 2); //delete '0x'
    Delete(MaxAddrStr, 1, 2); //delete '0x'

    if MinAddrStr > '' then
      AddAddrStrToRange(MinAddrStr, MaxAddrStr, AAddressRange);
  end;

  Result := True;
end;


function GetDefAddresses(AMCUDef: TMCUDef; AMlkContent, ASectionName: string; var AAddressRange: TDefSectionAddrRangeArr): Boolean;
begin
  if AMCUDef = mdMlk then
    Result := GetMlkAddresses(AMlkContent, ASectionName, AAddressRange)
  else
  begin
    ASectionName := LowerCase(ASectionName);
    Result := GetJsonAddresses(AMlkContent, ASectionName, AAddressRange);
  end;
end;

end.
