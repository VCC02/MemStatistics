{
    Copyright (C) 2023 VCC
    creation date: 2016
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


unit MiniMap;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF} 

interface

uses
  SysUtils, Classes, Graphics, Controls, MemStatUtils;

type
  TMiniMap = class(TGraphicControl)
  private
    FSelectedEntryIndex: Integer;
    FUseOverlapColor: Boolean;
    FOverlapColor: TColor;

    FSlot1: PFileSlot;
    FSlot2: PFileSlot;
    FSlot3: PFileSlot;
    FSlot4: PFileSlot;

    FFirstFileEntryChartColor: TColor;
    FSecondFileEntryChartColor: TColor;
    FThirdFileEntryChartColor: TColor;
    FFourthFileEntryChartColor: TColor;

    FFirstFileSelectedEntryChartColor: TColor;
    FSecondFileSelectedEntryChartColor: TColor;
    FThirdFileSelectedEntryChartColor: TColor;
    FFourthFileSelectedEntryChartColor: TColor;

    FDiffColor12: TColor;
    FDiffColor23: TColor;
    FDiffColor34: TColor;

    FBkColor1: TColor;
    FBkColor2: TColor;
    FBkColor3: TColor;
    FBkColor4: TColor;

    FEntryColorTableArr: TColorArr;

    procedure SetSelectedEntryIndex(Value: Integer);
    procedure SetDiffColors(Len1, Len2, Len3, Len4: Int64);
    procedure DrawSelectedLine(Start1, End1, Start2, End2, Start3, End3, Start4, End4: Integer; FullHEXLen: Int64);
  public
    constructor Create(AOwner: TComponent); override;
    procedure DrawMiniMap;
    procedure SetSetEntryColorTable(NewLength: Integer);
    procedure SetEntryColorTable(Index: Integer; AColor: TColor);
    procedure SaveToFile(AFileName: TFileName);
    procedure CopyToClipboard;

    procedure Paint; override;

    property OnMouseDown;
    property OnMouseMove;
    property PopupMenu;

    property SelectedEntryIndex: Integer read FSelectedEntryIndex write SetSelectedEntryIndex;
    property UseOverlapColor: Boolean read FUseOverlapColor write FUseOverlapColor;
    property OverlapColor: TColor read FOverlapColor write FOverlapColor;

    property Slot1: PFileSlot read FSlot1 write FSlot1;
    property Slot2: PFileSlot read FSlot2 write FSlot2;
    property Slot3: PFileSlot read FSlot3 write FSlot3;
    property Slot4: PFileSlot read FSlot4 write FSlot4;

    property FirstFileEntryChartColor: TColor read FFirstFileEntryChartColor write FFirstFileEntryChartColor;
    property SecondFileEntryChartColor: TColor read FSecondFileEntryChartColor write FSecondFileEntryChartColor;
    property ThirdFileEntryChartColor: TColor read FThirdFileEntryChartColor write FThirdFileEntryChartColor;
    property FourthFileEntryChartColor: TColor read FFourthFileEntryChartColor write FFourthFileEntryChartColor;

    property FirstFileSelectedEntryChartColor: TColor read FFirstFileSelectedEntryChartColor write FFirstFileSelectedEntryChartColor;
    property SecondFileSelectedEntryChartColor: TColor read FSecondFileSelectedEntryChartColor write FSecondFileSelectedEntryChartColor;
    property ThirdFileSelectedEntryChartColor: TColor read FThirdFileSelectedEntryChartColor write FThirdFileSelectedEntryChartColor;
    property FourthFileSelectedEntryChartColor: TColor read FFourthFileSelectedEntryChartColor write FFourthFileSelectedEntryChartColor;

    property BkColor1: TColor read FBkColor1 write FBkColor1;
    property BkColor2: TColor read FBkColor2 write FBkColor2;
    property BkColor3: TColor read FBkColor3 write FBkColor3;
    property BkColor4: TColor read FBkColor4 write FBkColor4;
  end;

implementation


uses
  Clipbrd;


constructor TMiniMap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSlot1 := nil;
  FSlot2 := nil;
  FSlot3 := nil;
  FSlot4 := nil;
end;


procedure TMiniMap.SetSelectedEntryIndex(Value: Integer);
begin
  if FSelectedEntryIndex <> Value then
  begin
    FSelectedEntryIndex := Value;
    //do not call DrawMiniMap here
  end;
end;


procedure TMiniMap.SetDiffColors(Len1, Len2, Len3, Len4: Int64);
var
  a: array of TColor;
begin
  if FUseOverlapColor then
  begin
    FDiffColor12 := FOverlapColor;
    FDiffColor23 := FOverlapColor;
    FDiffColor34 := FOverlapColor;
  end
  else
  begin
    FDiffColor12 := clFuchsia;
    FDiffColor23 := clFuchsia;
    FDiffColor34 := clFuchsia;

    if (Len1 > 0) and (Len2 > 0) then
    begin
      SetLength(a, 2);
      a[0] := FBkColor1;
      a[1] := FBkColor2;
    
      FDiffColor12 := AverageColor(a);
    end;

    if (Len2 > 0) and (Len3 > 0) then
    begin
      SetLength(a, 2);
      a[0] := FBkColor2;
      a[1] := FBkColor3;

      FDiffColor23 := AverageColor(a);
    end;

    if (Len3 > 0) and (Len4 > 0) then
    begin
      SetLength(a, 2);
      a[0] := FBkColor3;
      a[1] := FBkColor4;
    
      FDiffColor34 := AverageColor(a);
    end;
  end;
end;


procedure TMiniMap.DrawSelectedLine(Start1, End1, Start2, End2, Start3, End3, Start4, End4: Integer; FullHEXLen: Int64);
var
  y: Int64;
begin
  y := Round(Int64(FSelectedEntryIndex) * Int64(Height) / FullHEXLen);
  if y > Int64(Height) - 1 then
    y := Int64(Height) - 1;

  Canvas.Pen.Color := FirstFileSelectedEntryChartColor;
  Line(Canvas, Start1, y, End1, y);

  Canvas.Pen.Color := SecondFileSelectedEntryChartColor;
  Line(Canvas, Start2, y, End2, y);

  Canvas.Pen.Color := ThirdFileSelectedEntryChartColor;
  Line(Canvas, Start3, y, End3, y);

  Canvas.Pen.Color := FourthFileSelectedEntryChartColor;
  Line(Canvas, Start4, y, End4, y);
end;


procedure TMiniMap.DrawMiniMap;
const
  DrawingOffset: Integer = 6;
var
  Start1, End1: Integer;
  Start2, End2: Integer;
  Start3, End3: Integer;
  Start4, End4: Integer;

  Len1, Len2, Len3, Len4, FullHEXLen: Int64;
  CellWidth3, CellWidth3_Mul2: Integer;

  i: Integer;
  y, y1, y2, LastY: Int64;

  DrawingWidth: Integer;
  YOfLn: array of Integer;
  SectionLengths: TSectionArr;
  SumOfSectionLengths: Cardinal;
  Acc: Int64;
  LocalBkColor1, LocalBkColor2, LocalBkColor3, LocalBkColor4: TColor;

  DrawingBuffer: TBitmap;
begin
  Len1 := Length(FSlot1.FullHEX);
  Len2 := Length(FSlot2.FullHEX);
  Len3 := Length(FSlot3.FullHEX);
  Len4 := Length(FSlot4.FullHEX);

  //compute edges
  DrawingWidth := Width - DrawingOffset;
  Start1 := DrawingOffset;
  End1 := DrawingOffset + DrawingWidth shr 2 {- 1};

  Start2 := DrawingOffset + DrawingWidth shr 2;
  End2 := DrawingOffset + DrawingWidth shr 1 {- 1};

  Start3 := DrawingOffset + DrawingWidth shr 1;
  End3 := DrawingOffset + DrawingWidth shr 1 + DrawingWidth shr 2 {- 1};

  Start4 := DrawingOffset + DrawingWidth shr 1 + DrawingWidth shr 2;
  End4 := DrawingOffset + DrawingWidth {- 1};

  //Compute background colors
  if Len1 > 0 then
    LocalBkColor1 := FBkColor1
  else
    LocalBkColor1 := clWindow;

  if Len2 > 0 then
    LocalBkColor2 := FBkColor2
  else
    LocalBkColor2 := clWindow;

  if Len3 > 0 then
    LocalBkColor3 := FBkColor3
  else
    LocalBkColor3 := clWindow;

  if Len4 > 0 then
    LocalBkColor4 := FBkColor4
  else
    LocalBkColor4 := clWindow;

  DrawingBuffer := TBitmap.Create;
  try
    DrawingBuffer.Width := Width;
    DrawingBuffer.Height := Height;

    //draw background
    DrawingBuffer.Canvas.Brush.Color := LocalBkColor1;
    DrawingBuffer.Canvas.Pen.Color := DrawingBuffer.Canvas.Brush.Color;
    DrawingBuffer.Canvas.Rectangle(Start1, 0, End1, Height);

    DrawingBuffer.Canvas.Brush.Color := LocalBkColor2;
    DrawingBuffer.Canvas.Pen.Color := DrawingBuffer.Canvas.Brush.Color;
    DrawingBuffer.Canvas.Rectangle(Start2, 0, End2, Height);

    DrawingBuffer.Canvas.Brush.Color := LocalBkColor3;
    DrawingBuffer.Canvas.Pen.Color := DrawingBuffer.Canvas.Brush.Color;
    DrawingBuffer.Canvas.Rectangle(Start3, 0, End3, Height);

    DrawingBuffer.Canvas.Brush.Color := LocalBkColor4;
    DrawingBuffer.Canvas.Pen.Color := DrawingBuffer.Canvas.Brush.Color;
    DrawingBuffer.Canvas.Rectangle(Start4, 0, End4, Height);

    try
      //draw different entries

      if Len1 > 0 then
      begin
        FullHEXLen := Len1;

        SetLength(SectionLengths, Length(FSlot1.Sections));
        for i := 0 to Length(SectionLengths) - 1 do
          SectionLengths[i] := FSlot1.Sections[i];
      end
      else
        if Len2 > 0 then
        begin
          FullHEXLen := Len2;

          SetLength(SectionLengths, Length(FSlot2.Sections));
          for i := 0 to Length(SectionLengths) - 1 do
            SectionLengths[i] := FSlot2.Sections[i];
        end
        else
          if Len3 > 0 then
          begin
            FullHEXLen := Len3;

            SetLength(SectionLengths, Length(FSlot3.Sections));
            for i := 0 to Length(SectionLengths) - 1 do
              SectionLengths[i] := FSlot3.Sections[i];
          end
          else
            if Len4 > 0 then
            begin
              FullHEXLen := Len4;

              SetLength(SectionLengths, Length(FSlot4.Sections));
              for i := 0 to Length(SectionLengths) - 1 do
                SectionLengths[i] := FSlot4.Sections[i];
            end
            else
              Exit;

      CellWidth3 := Round(DrawingWidth / 12); // 12 = 4 * 3
      CellWidth3_Mul2 := CellWidth3 shl 1;

      SetDiffColors(Len1, Len2, Len3, Len4);

      SetLength(YOfLn, FullHEXLen);
      try
        for i := 0 to FullHEXLen - 1 do
          YOfLn[i] := Round(Int64(i) * Int64(Height) / FullHEXLen);

        DrawingBuffer.Canvas.Lock;
        try
          DrawingBuffer.Canvas.Brush.Color := FDiffColor12;
          DrawingBuffer.Canvas.Pen.Color := FDiffColor12;

          LastY := -1;

          if (Len1 > 0) and (Len2 > 0) then
            for i := 0 to FullHEXLen - 1 do
            begin
              //overlapped
              y := YOfLn[i];

              if FSlot1.FullHEX[i].HData <> FSlot2.FullHEX[i].HData then
                if LastY <> y then
                begin
                  LastY := y;
                  Line(DrawingBuffer.Canvas, Start1 + CellWidth3_Mul2, y, End1, y);
                  Line(DrawingBuffer.Canvas, Start2, y, Start2 + CellWidth3, y);
                end;
            end;

          DrawingBuffer.Canvas.Brush.Color := FDiffColor23;
          DrawingBuffer.Canvas.Pen.Color := FDiffColor23;

          if (Len2 > 0) and (Len3 > 0) then
            for i := 0 to FullHEXLen - 1 do
            begin
              //overlapped
              y := YOfLn[i];

              if FSlot2.FullHEX[i].HData <> FSlot3.FullHEX[i].HData then
                if LastY <> y then
                begin
                  LastY := y;
                  Line(DrawingBuffer.Canvas, Start2 + CellWidth3_Mul2, y, End2, y);
                  Line(DrawingBuffer.Canvas, Start3, y, Start3 + CellWidth3, y);
                end;
            end;

          DrawingBuffer.Canvas.Brush.Color := FDiffColor34;
          DrawingBuffer.Canvas.Pen.Color := FDiffColor34;

          if (Len3 > 0) and (Len4 > 0) then
            for i := 0 to FullHEXLen - 1 do
            begin
              //overlapped
              y := YOfLn[i];
              if FSlot3.FullHEX[i].HData <> FSlot4.FullHEX[i].HData then
                if LastY <> y then
                begin
                  LastY := y;
                  Line(DrawingBuffer.Canvas, Start3 + CellWidth3_Mul2, y, End3, y);
                  Line(DrawingBuffer.Canvas, Start4, y, Start4 + CellWidth3, y);
                end;
            end; //for
        finally
          DrawingBuffer.Canvas.Unlock;
        end;
      finally
        SetLength(YOfLn, 0);
      end;

      //sections bar (to the left of the minimap)
      DrawingBuffer.Canvas.Lock;
      try
        Acc := 0;
        for i := 0 to Length(SectionLengths) - 1 do
        begin
          SumOfSectionLengths := GetSumOfSectionLengths(SectionLengths[i].AddrRanges);

          y1 := Round(Acc * Cardinal(Height) / FullHEXLen);
          y2 := Round((Acc + SumOfSectionLengths) * Cardinal(Height) / FullHEXLen);

          Acc := Acc + SumOfSectionLengths;

          DrawingBuffer.Canvas.Pen.Color := clGray;
          DrawingBuffer.Canvas.Brush.Color := FEntryColorTableArr[i];
          DrawingBuffer.Canvas.Rectangle(0, y1, DrawingOffset, y2);
        end;
      finally
        DrawingBuffer.Canvas.Unlock;
      end;
    finally
      Canvas.Draw(0, 0, DrawingBuffer);
    end;

    //currently selected line
    if FSelectedEntryIndex = -1 then
      Exit;
  finally
    DrawingBuffer.Free;
  end;

  DrawSelectedLine(Start1, End1, Start2, End2, Start3, End3, Start4, End4, FullHEXLen);
end;


procedure TMiniMap.SetSetEntryColorTable(NewLength: Integer);
begin
  if NewLength < 0 then
    raise Exception.Create('Bad length');

  SetLength(FEntryColorTableArr, NewLength);
end;


procedure TMiniMap.SetEntryColorTable(Index: Integer; AColor: TColor);
begin
  if (Index < 0) or (Index > Length(FEntryColorTableArr) - 1) then
    raise Exception.Create('Bad index when setting color.');

  FEntryColorTableArr[Index] := AColor;
end;


procedure TMiniMap.Paint;
begin
  DrawMiniMap;
end;


procedure TMiniMap.SaveToFile(AFileName: TFileName);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;

  try
    ABitmap.Width := Width;
    ABitmap.Height := Height;
    ABitmap.Canvas.CopyRect(Self.ClientRect, Canvas, Self.ClientRect);
    ABitmap.SaveToFile(AFileName);
  finally
    ABitmap.Free;
  end;
end;


procedure TMiniMap.CopyToClipboard;
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;

  try
    ABitmap.Width := Width;
    ABitmap.Height := Height;
    ABitmap.Canvas.CopyRect(Self.ClientRect, Canvas, Self.ClientRect);
    Clipboard.Assign(ABitmap);
  finally
    ABitmap.Free;
  end;
end;

end.
