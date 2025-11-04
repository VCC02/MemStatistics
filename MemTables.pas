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


unit MemTables;

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
  Dialogs, ExtCtrls, VirtualTrees, ComCtrls, MemStatUtils, DeviceInfo;

type
  TOnGetVisibleColumnCount = function: Integer of object;
  TOnGetColumnVisibility = function(AColumnIndex: Integer): Boolean of object;

  TRoutineIndex_Visibility = record
    S1, S2: Boolean;
  end;

  TRoutineIndex_VisibilityArr = array of TRoutineIndex_Visibility;
  
  TMemTable = class(TGraphicControl)
  private
    FOnGetVisibleColumnCount: TOnGetVisibleColumnCount;
    FOnGetColumnVisibility: TOnGetColumnVisibility;

    FMemContent: TMemEntryArr;
    FMemContentFromRaw: TMemEntryArr;
    FMemContentFromRawNames: TMemEntryArr;  //this should be the same content as displayed on main window (raw table)
    FRawMemContent: array of Cardinal;    //array of addresses

    FMemScales: array of Double;

    FEntryToFocusOn: Integer;
    FEntryToFocusOnRaw: Integer;
    FPaintGraphicOnlyOption: Boolean;
    FDisplayFocusedEntry: Boolean;
    FWhatEntriesToDisplay: Byte;
    FMemStatColorOptions: TMemStatColorOptions;
    FMemStatMiscOptions: TMemStatMiscOptions;

    FDeviceInfo: TDeviceInfo;

    procedure ComputeMemScales(YOffset: Cardinal);
    procedure DrawEntry(AddrMin, Addr, Size, YOffset: Cardinal; AddrOffset: Integer; MemScale: Double; x1, x2: Integer; Color: TColor);
    procedure DrawEntryByIndex(ASrc: Boolean; YOffset: Cardinal; EntryByIndex: Integer; var ARoutineIndex_Visibilities: TRoutineIndex_VisibilityArr; var AAddressOffsets: TAddressOffsetArr; var ColumnXs: TBoundArray; WidthDiv: Integer; var ColColors: TColorArr);

    procedure DrawMem(Src: Boolean; YOffset: Cardinal; var ColumnXs: TBoundArray; AWidthDiv: Integer; var AddressOffsets: TAddressOffsetArr);
    procedure DrawMemFocusedEntry(Src: Boolean; YOffset: Cardinal; EntryByIndex: Integer; var ColumnXs: TBoundArray; AWidthDiv: Integer; var AddressOffsets: TAddressOffsetArr);
    procedure DrawTableText(YOffset: Cardinal; var AddressOffsets: TAddressOffsetArr; var ColumnXs: TBoundArray);
    //procedure DrawTableText(YOffset: Cardinal; Col2Left, Col3Left, Col4Left, Col5Left: Integer);
    procedure SetEntryToFocusOn(Value: Integer);
    procedure SetEntryToFocusOnRaw(Value: Integer);
    procedure SetWhatEntriesToDisplay(Value: Byte);
  protected
    //procedure Paint; override;  //moved to public

    function DoOnGetVisibleColumnCount: Integer;
    function DoOnGetColumnVisibility(AColumnIndex: Integer): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Paint; override;

    procedure AddEntry(Address, Size: Cardinal; EntryName: string);
    procedure AddRawEntry(Address: Cardinal);
    procedure AddEntryFromRaw(Address, Size: Cardinal; EntryName: string);      //block entry
    procedure AddEntryFromRawNames(Address, Size: Cardinal; EntryName: string); //item entry

    function GetNumberOfProcessedRawEntries: Integer; //moved from private

    procedure Clear;

    function GetMemContent(Index: Integer): TMemEntry;
    function GetRawMemContent(Index: Integer): Cardinal;
    function GetMemContentFromRaw(Index: Integer): TMemEntry;
    function GetMemContentLength: Integer;
    function GetRawMemContentLength: Integer;
    procedure GetEntireMemContent(var AMemContent: TMemEntryArr);
    procedure GetEntireMemContentFromRawNames(var AMemContent: TMemEntryArr);

    function RawIndexIn_MemRange(ASectionIndex, ARawIndex: Integer; AddrOffset: Int64): Boolean;
    function AddressIn_MemRange(ASectionIndex: Integer; AAddress, AddrOffset: Int64): Boolean;
    function RoutineIndexIn_MemRange(ASectionIndex: Integer; RoutineIndex, AddrOffset: Int64): Boolean;
    function RoutineIndexFromRawIn_MemRange(ASectionIndex: Integer; RoutineIndex, AddrOffset: Int64): Boolean;

    procedure PaintGraphicOnly;

    property Canvas;
    property Font;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property PopupMenu;

    property EntryToFocusOn: Integer read FEntryToFocusOn write SetEntryToFocusOn;
    property EntryToFocusOnRaw: Integer read FEntryToFocusOnRaw write SetEntryToFocusOnRaw;
    property DisplayFocusedEntry: Boolean read FDisplayFocusedEntry write FDisplayFocusedEntry;
    property WhatEntriesToDisplay: Byte read FWhatEntriesToDisplay write SetWhatEntriesToDisplay;
    property NumberOfProcessedRawEntries: Integer read GetNumberOfProcessedRawEntries;

    property MemStatColorOptions: TMemStatColorOptions read FMemStatColorOptions write FMemStatColorOptions;
    property MemStatMiscOptions: TMemStatMiscOptions read FMemStatMiscOptions write FMemStatMiscOptions;
    property DeviceInfo: TDeviceInfo read FDeviceInfo;

    property PaintGraphicOnlyOption: Boolean read FPaintGraphicOnlyOption write FPaintGraphicOnlyOption;

    property OnGetVisibleColumnCount: TOnGetVisibleColumnCount write FOnGetVisibleColumnCount;
    property OnGetColumnVisibility: TOnGetColumnVisibility write FOnGetColumnVisibility;
  end;

implementation


procedure TMemTable.ComputeMemScales(YOffset: Cardinal);
var
  i: Integer;
  ASum: DWord;
begin
  SetLength(FMemScales, FDeviceInfo.GetDeviceSectionCount);

  for i := 0 to Length(FMemScales) - 1 do
  begin
    ASum := FDeviceInfo.GetSectionLength(i) shl 2;
    FMemScales[i] := ASum / (Cardinal(Height) - 6 - YOffset);
  end;
end;


{
AddrMin:     e.g. FProgramFlashAddrMin
Addr:        Addr (i.e. FMemContent[i].Address)
Size:        Size (i.e. FMemContent[i].Size)
YOffset:     YOffset
AddrOffset:  +/- $20000000 for PIC32,  0 for others
MemScale:    e.g. FMemScaleProgramFlash
x1:          e.g. Col2Left - WidthDiv + 1
x2:          e.g. Col2Left
Color:       e.g. FMemStatColorOptions.PFMEntryChart
}
procedure TMemTable.DrawEntry(AddrMin, Addr, Size, YOffset: Cardinal; AddrOffset: Integer; MemScale: Double; x1, x2: Integer; Color: TColor);
var
  y1, y2, y3, y4: Int64;
begin
  if Canvas.Pen.Color <> Color then   //A simple comparison, to avoid setting color if already set. This is because setting colors implies locking the canvas (internally).
  begin
    Canvas.Pen.Color := Color;
    Canvas.Brush.Color := Color;
  end;

  y3 := Int64(Addr) - Int64(AddrMin) + AddrOffset;
  y4 := y3 + Size;

  y1 := Round(y3 / MemScale) + YOffset;
  y2 := Round(y4 / MemScale) + YOffset;

  if y2 = y1 then
    y2 := y1 + 1;

  Canvas.Rectangle(x1, y1, x2, y2);
end;


procedure TMemTable.DrawEntryByIndex(ASrc: Boolean; YOffset: Cardinal; EntryByIndex: Integer; var ARoutineIndex_Visibilities: TRoutineIndex_VisibilityArr; var AAddressOffsets: TAddressOffsetArr; var ColumnXs: TBoundArray; WidthDiv: Integer; var ColColors: TColorArr);
var
  j, x1, x2: Integer;
  Addr, Size: Cardinal;
  FMemScalesGreaterThan0: Boolean;
begin
  if not ASrc then
  begin
    Addr := FMemContent[EntryByIndex].Address;
    Size := FMemContent[EntryByIndex].Size;

    for j := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
    begin
      FMemScalesGreaterThan0 := FMemScales[j] > 0;
      ARoutineIndex_Visibilities[j].S1 := FMemScalesGreaterThan0 and RoutineIndexIn_MemRange(j, EntryByIndex, AAddressOffsets[j].S1);
      ARoutineIndex_Visibilities[j].S2 := FMemScalesGreaterThan0 and RoutineIndexIn_MemRange(j, EntryByIndex, AAddressOffsets[j].S2);
    end;
  end
  else
  begin
    Addr := FMemContentFromRaw[EntryByIndex].Address;
    Size := FMemContentFromRaw[EntryByIndex].Size;

    for j := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
    begin
      FMemScalesGreaterThan0 := FMemScales[j] > 0;
      ARoutineIndex_Visibilities[j].S1 := FMemScalesGreaterThan0 and RoutineIndexFromRawIn_MemRange(j, EntryByIndex, AAddressOffsets[j].S1);
      ARoutineIndex_Visibilities[j].S2 := FMemScalesGreaterThan0 and RoutineIndexFromRawIn_MemRange(j, EntryByIndex, AAddressOffsets[j].S2);
    end;
  end;

  for j := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
  begin
    if ARoutineIndex_Visibilities[j].S1 then
    begin
      x1 := ColumnXs[j] + 1;
      x2 := ColumnXs[j] + WidthDiv;
      DrawEntry(FDeviceInfo.GetAddressRangesByIndex(j, 0).MinAddr, Addr, Size, YOffset, -AAddressOffsets[j].S1, FMemScales[j], x1, x2, ColColors[j]);
    end;

    if ARoutineIndex_Visibilities[j].S2 then
    begin
      x1 := ColumnXs[j] + WidthDiv + 1;
      x2 := ColumnXs[j] + WidthDiv shl 1;

      if x2 > Width - 1 then
        x2 := Width - 1;

      DrawEntry(FDeviceInfo.GetAddressRangesByIndex(j, 0).MinAddr, Addr, Size, YOffset, -AAddressOffsets[j].S2, FMemScales[j], x1, x2, ColColors[j]);
    end;
  end;
end;  


procedure TMemTable.DrawMem(Src: Boolean; YOffset: Cardinal; var ColumnXs: TBoundArray; AWidthDiv: Integer; var AddressOffsets: TAddressOffsetArr);
var
  i, n: Integer;
  RoutineIndex_Visibilities: TRoutineIndex_VisibilityArr;
  ColColors: TColorArr;
begin
  if not Src then
    n := Length(FMemContent)
  else
    n := Length(FMemContentFromRaw);

  Inc(YOffset, 4);  //required by entries, reset for text (see below)

  SetLength(RoutineIndex_Visibilities, FDeviceInfo.GetDeviceSectionCount);
  SetLength(ColColors, FDeviceInfo.GetDeviceSectionCount);

  if Length(ColColors) = 0 then
    SetLength(ColColors, 6); //something to be displayed

  if Length(FMemStatColorOptions.EntryColorArr) > 0 then   //prevent startup exceptions
    for i := 0 to Length(ColColors) - 1 do
    begin
      try
        ColColors[i] := FMemStatColorOptions.EntryColorArr[i];
      except
        ColColors[i] := clRed; //in case EntryColorTableArr has fewer items than ColColors
      end;
    end;

  for i := 0 to n - 1 do
    DrawEntryByIndex(Src, YOffset, i, RoutineIndex_Visibilities, AddressOffsets, ColumnXs, AWidthDiv, ColColors);
end;


procedure TMemTable.DrawMemFocusedEntry(Src: Boolean; YOffset: Cardinal; EntryByIndex: Integer; var ColumnXs: TBoundArray; AWidthDiv: Integer; var AddressOffsets: TAddressOffsetArr);
var
  n, i: Integer;
  RoutineIndex_Visibilities: TRoutineIndex_VisibilityArr;
  ColColors: TColorArr;
begin
  if not Src then
    n := Length(FMemContent)
  else
    n := Length(FMemContentFromRaw);

  if n = 0 then
    Exit; 

  Inc(YOffset, 4);  //required by entries, reset for text (see below)

  SetLength(RoutineIndex_Visibilities, FDeviceInfo.GetDeviceSectionCount);
  SetLength(ColColors, FDeviceInfo.GetDeviceSectionCount);

  if Length(ColColors) = 0 then
  begin
    SetLength(ColColors, 6); //something to be displayed
    SetLength(FMemStatColorOptions.EntryColorArr, Length(ColColors)); //EntryColorArr should not be set here, but it's an easy fix to a further AV.
    SetLength(FMemStatColorOptions.SelectedEntryColorArr, Length(ColColors));  //same as above
  end;

  if FDisplayFocusedEntry then
  begin
    for i := 0 to Length(ColColors) - 1 do
    begin
      try
        ColColors[i] := FMemStatColorOptions.SelectedEntryColorArr[i];
      except
        ColColors[i] := clRed;
      end;
    end;
  end
  else
  begin
    for i := 0 to Length(ColColors) - 1 do
    begin
      try
        ColColors[i] := FMemStatColorOptions.EntryColorArr[i];
      except
        ColColors[i] := clRed;
      end;
    end;
  end;

  //paints the selected address
  DrawEntryByIndex(Src, YOffset, EntryByIndex, RoutineIndex_Visibilities, AddressOffsets, ColumnXs, AWidthDiv, ColColors);
end;


procedure TMemTable.DrawTableText(YOffset: Cardinal; var AddressOffsets: TAddressOffsetArr; var ColumnXs: TBoundArray);
var
  i: Integer;
  WidthDivD: Double;
  VisibleCount: Integer;
  AText: string;
  XL, XR: Integer;
  WidthTooSmall: Boolean;
  YOffsetOnSmall: Cardinal;
  ATextWidth: Integer;
begin
  //line and background, not text !!!
  Canvas.Pen.Color := clRed; // FMemStatColorOptions.LineChart;
  Canvas.Brush.Color := FMemStatColorOptions.TextBackgroundChart;

  VisibleCount := DoOnGetVisibleColumnCount;

  if VisibleCount = 0 then
    VisibleCount := 4;

  WidthDivD := Width / VisibleCount;

  ATextWidth := Canvas.TextWidth('0xFDFDFDFD');
  WidthTooSmall := WidthDivD < 18 + ATextWidth shl 1; //about 144px
  YOffsetOnSmall := Cardinal(Ord(WidthTooSmall) * (Canvas.TextHeight('F') + 2));

  for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
  begin
    if not DoOnGetColumnVisibility(i) then
      Continue;

    XL := 9 + ColumnXs[i];
    XR := Round(ColumnXs[i] + WidthDivD - 9);

    //MinAddr S1
    AText := '0x' + IntToHex(Int64(FDeviceInfo.GetAddressRangesByIndex(i, 0).MinAddr) + AddressOffsets[i].S1, 8); ///////////////////////////////// get a concatenated range, and make sure DrawMem and DrawMemFocusedEntry will also use that!!!
    Canvas.TextOut(XL, YOffset + 6, AText);

    //MinAddr S2
    AText := '0x' + IntToHex(Int64(FDeviceInfo.GetAddressRangesByIndex(i, 0).MinAddr) + AddressOffsets[i].S2, 8);
    Canvas.TextOut(XR - Canvas.TextWidth(AText), YOffset + 6 + YOffsetOnSmall, AText);

    //MaxAddr S1
    AText := '0x' + IntToHex(Int64(FDeviceInfo.GetAddressRangesByIndex(i, 0).MaxAddr) + AddressOffsets[i].S1, 8);
    Canvas.TextOut(XL, Cardinal(Height) - YOffset - 2, AText);
    
    //MaxAddr S2
    AText := '0x' + IntToHex(Int64(FDeviceInfo.GetAddressRangesByIndex(i, 0).MaxAddr) + AddressOffsets[i].S2, 8);
    Canvas.TextOut(XR - Canvas.TextWidth(AText), Cardinal(Height) - YOffset - 2 - YOffsetOnSmall, AText);
  end;
end;


procedure TMemTable.SetEntryToFocusOn(Value: Integer);
begin
  if FEntryToFocusOn <> Value then
  begin
    FEntryToFocusOn := Value;
    PaintGraphicOnly;
  end;
end;


procedure TMemTable.SetEntryToFocusOnRaw(Value: Integer);
begin
  if FEntryToFocusOnRaw <> Value then
  begin
    FEntryToFocusOnRaw := Value;
    PaintGraphicOnly;
  end;
end;


procedure TMemTable.SetWhatEntriesToDisplay(Value: Byte);
begin
  if FWhatEntriesToDisplay <> Value then
  begin
    FWhatEntriesToDisplay := Value;
    Paint;
  end;
end;


procedure TMemTable.Paint;
var
  YOffset: Cardinal;
  ColumnXs: TBoundArray;
  i: Integer;
  CurrentDrawingXPos: Integer;
  VisibleColPos, VisibleCount: Integer;
  WidthDiv: Integer;
  AddressOffsets: TAddressOffsetArr;
begin
  try
    if not FPaintGraphicOnlyOption then
    begin
      Canvas.Pen.Color := FMemStatColorOptions.LineChart;
      Canvas.Brush.Color := FMemStatColorOptions.BackgroundChart;
      Canvas.Pen.Width := 1;
      Canvas.Rectangle(0, 0, Width, Height);
    end;

    SetLength(ColumnXs, FDeviceInfo.GetDeviceSectionCount);
    try
      VisibleCount := DoOnGetVisibleColumnCount;

      CurrentDrawingXPos := 0;
      VisibleColPos := 0;
      Canvas.Pen.Color := FMemStatColorOptions.LineChart;

      for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
      begin
        if not DoOnGetColumnVisibility(i) then
          Continue;

        ColumnXs[i] := CurrentDrawingXPos;

        Inc(VisibleColPos);
        CurrentDrawingXPos := Round(VisibleColPos * Width div VisibleCount);

        Line(Canvas, CurrentDrawingXPos, 0, CurrentDrawingXPos, Height - 1);
      end;

      if VisibleCount = 0 then
        WidthDiv := 4
      else
        WidthDiv := Round(Width / VisibleCount / 2);

      YOffset := Canvas.TextHeight('W');
      Line(Canvas, 0, YOffset + 2, Width - 1, YOffset + 2);

      Canvas.Pen.Color := FMemStatColorOptions.LineChart; //Canvas.Pen.Color := clGreen;
      Line(Canvas, 0, YOffset + 3, Width - 2, YOffset + 3);


      Canvas.Font.Color := FMemStatColorOptions.TextColorChart;

      for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
      begin
        if not DoOnGetColumnVisibility(i) then
          Continue;

        Canvas.TextOut(10 + ColumnXs[i], 1, FDeviceInfo.GetDeviceDisplaySectionLongNameByIndex(i)); 
      end;

      ComputeMemScales(YOffset);
      FDeviceInfo.GetAddressOffsets(AddressOffsets);

      if FWhatEntriesToDisplay and 1 = 1 then  //at least routines
        DrawMem(False, YOffset, ColumnXs, WidthDiv, AddressOffsets);

      if FWhatEntriesToDisplay and 2 = 2 then  //at least raw addresses
        DrawMem(True, YOffset, ColumnXs, WidthDiv, AddressOffsets);

      if FWhatEntriesToDisplay and 1 = 1 then  //at least routines
        DrawMemFocusedEntry(False, YOffset, FEntryToFocusOn, ColumnXs, WidthDiv, AddressOffsets);

      if FWhatEntriesToDisplay and 2 = 2 then  //at least raw addresses
        DrawMemFocusedEntry(True, YOffset, FEntryToFocusOnRaw, ColumnXs, WidthDiv, AddressOffsets);

      DrawTableText(YOffset, AddressOffsets, ColumnXs);  
    finally
      FPaintGraphicOnlyOption := False; //reset flag
      SetLength(ColumnXs, 0);
    end;
  except
    //
  end;
end;


procedure TMemTable.PaintGraphicOnly;
begin
  FPaintGraphicOnlyOption := True;
  Paint;
end;


constructor TMemTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetLength(FMemContent, 0);
  SetLength(FRawMemContent, 0);
  SetLength(FMemContentFromRaw, 0);
  SetLength(FMemContentFromRawNames, 0);

  FDeviceInfo := TDeviceInfo.Create;

  FEntryToFocusOn := 0;
  FEntryToFocusOnRaw := 0;
  FPaintGraphicOnlyOption := False;
  FDisplayFocusedEntry := False;
  FWhatEntriesToDisplay := 3;

  FOnGetVisibleColumnCount := nil;
  FOnGetColumnVisibility := nil;
end;


destructor TMemTable.Destroy;
begin
  SetLength(FMemContent, 0);
  SetLength(FRawMemContent, 0);
  SetLength(FMemContentFromRaw, 0);
  SetLength(FMemContentFromRawNames, 0);

  FDeviceInfo.Free;

  inherited Destroy;
end;


function TMemTable.DoOnGetVisibleColumnCount: Integer;
begin
  if not Assigned(FOnGetVisibleColumnCount) then
    raise Exception.Create('OnGetVisibleColumnCount is not assigned.');

  Result := FOnGetVisibleColumnCount;
end;


function TMemTable.DoOnGetColumnVisibility(AColumnIndex: Integer): Boolean;
begin
  if not Assigned(FOnGetColumnVisibility) then
    raise Exception.Create('OnGetColumnVisibility is not assigned.');

  Result := FOnGetColumnVisibility(AColumnIndex);
end;


procedure TMemTable.AddEntry(Address, Size: Cardinal; EntryName: string);
var
  n: Integer;
begin
  SetLength(FMemContent, Length(FMemContent) + 1);
  n := Length(FMemContent) - 1;
  FMemContent[n].Address := Address;
  FMemContent[n].Size := Size;
  FMemContent[n].EntryName := EntryName;
end;


procedure TMemTable.AddRawEntry(Address: Cardinal);
var
  n: Integer;
begin
  SetLength(FRawMemContent, Length(FRawMemContent) + 1);
  n := Length(FRawMemContent) - 1;
  FRawMemContent[n] := Address;
end;


procedure TMemTable.AddEntryFromRaw(Address, Size: Cardinal; EntryName: string);
var
  n: Integer;
begin
  SetLength(FMemContentFromRaw, Length(FMemContentFromRaw) + 1);
  n := Length(FMemContentFromRaw) - 1;
  FMemContentFromRaw[n].Address := Address;
  FMemContentFromRaw[n].Size := Size;
  FMemContentFromRaw[n].EntryName := '';
end;


procedure TMemTable.AddEntryFromRawNames(Address, Size: Cardinal; EntryName: string);
var
  n: Integer;
begin
  SetLength(FMemContentFromRawNames, Length(FMemContentFromRawNames) + 1);
  n := Length(FMemContentFromRawNames) - 1;
  FMemContentFromRawNames[n].Address := Address;
  FMemContentFromRawNames[n].Size := Size;
  FMemContentFromRawNames[n].EntryName := EntryName; //this field is used by cmp window
end;


procedure TMemTable.Clear;
begin
  SetLength(FMemContent, 0);
  SetLength(FRawMemContent, 0);
  SetLength(FMemContentFromRaw, 0);

  Paint;
end;


function TMemTable.GetMemContent(Index: Integer): TMemEntry;
begin
  Result := FMemContent[Index];
end;


function TMemTable.GetRawMemContent(Index: Integer): Cardinal;
begin
  Result := FRawMemContent[Index];
end;


function TMemTable.GetMemContentFromRaw(Index: Integer): TMemEntry;
begin
  Result := FMemContentFromRaw[Index];
end;


function TMemTable.GetMemContentLength: Integer;
begin
  Result := Length(FMemContent);
end;


function TMemTable.GetRawMemContentLength: Integer;
begin
  Result := Length(FRawMemContent);
end;


procedure TMemTable.GetEntireMemContent(var AMemContent: TMemEntryArr);
var
  i: Integer;
begin
  SetLength(AMemContent, Length(FMemContent));
  for i := 0 to Length(FMemContent) - 1 do
    AMemContent[i] := FMemContent[i];
end;


procedure TMemTable.GetEntireMemContentFromRawNames(var AMemContent: TMemEntryArr);
var
  i: Integer;
begin
  SetLength(AMemContent, Length(FMemContentFromRawNames));
  for i := 0 to Length(FMemContentFromRawNames) - 1 do
    AMemContent[i] := FMemContentFromRawNames[i];
end;


function TMemTable.GetNumberOfProcessedRawEntries: Integer;
begin
  Result := Length(FMemContentFromRaw);
end;



//==================================================================


function TMemTable.RawIndexIn_MemRange(ASectionIndex, ARawIndex: Integer; AddrOffset: Int64): Boolean;
var
  i: Integer;
  AMemRange: TDefSectionAddrRange;
begin
  Result := False;
  for i := 0 to FDeviceInfo.GetAddressRangesCountFromSection(ASectionIndex) - 1 do
  begin
    AMemRange := FDeviceInfo.GetAddressRangesByIndex(ASectionIndex, i);
    
    if (FRawMemContent[ARawIndex] >= Int64(AMemRange.MinAddr) + AddrOffset) and
       (FRawMemContent[ARawIndex] <= Int64(AMemRange.MaxAddr) + AddrOffset) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


function TMemTable.AddressIn_MemRange(ASectionIndex: Integer; AAddress, AddrOffset: Int64): Boolean;
var
  i: Integer;
  AMemRange: TDefSectionAddrRange;
begin
  Result := False;
  for i := 0 to FDeviceInfo.GetAddressRangesCountFromSection(ASectionIndex) - 1 do
  begin
    AMemRange := FDeviceInfo.GetAddressRangesByIndex(ASectionIndex, i);
    
    if (AAddress >= Int64(AMemRange.MinAddr) + AddrOffset) and
       (AAddress <= Int64(AMemRange.MaxAddr) + AddrOffset) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


function TMemTable.RoutineIndexIn_MemRange(ASectionIndex: Integer; RoutineIndex, AddrOffset: Int64): Boolean;
var
  i: Integer;
  AMemRange: TDefSectionAddrRange;
begin
  Result := False;
  for i := 0 to FDeviceInfo.GetAddressRangesCountFromSection(ASectionIndex) - 1 do
  begin
    AMemRange := FDeviceInfo.GetAddressRangesByIndex(ASectionIndex, i);
    
    if (FMemContent[RoutineIndex].Address >= Int64(AMemRange.MinAddr) + AddrOffset) and
       (FMemContent[RoutineIndex].Address <= Int64(AMemRange.MaxAddr) + AddrOffset) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


function TMemTable.RoutineIndexFromRawIn_MemRange(ASectionIndex: Integer; RoutineIndex, AddrOffset: Int64): Boolean;
var
  i: Integer;
  AMemRange: TDefSectionAddrRange;
begin
  Result := False;
  for i := 0 to FDeviceInfo.GetAddressRangesCountFromSection(ASectionIndex) - 1 do
  begin
    AMemRange := FDeviceInfo.GetAddressRangesByIndex(ASectionIndex, i);

    if (FMemContentFromRaw[RoutineIndex].Address >= Int64(AMemRange.MinAddr) + AddrOffset) and
       (FMemContentFromRaw[RoutineIndex].Address <= Int64(AMemRange.MaxAddr) + AddrOffset) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.
