{
    Copyright (C) 2026 VCC
    creation date: 2026
    initial release date: 05 Nov 2026

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


unit MemStatPlugins;

{$IFDEF FPC}
  {$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils;

type
  TMemEntryAPI = record
    Address: Cardinal;
    Size: Cardinal; //in Bytes
    EntryName: Pointer;//string;
    EntryNameLen: Cardinal;
    Index: Cardinal; //reserved for future use
  end;

  {$IFnDEF FPC}
    DWord = Cardinal;
  {$ENDIF}

  TGetMemEntryCallback = procedure(AEntry: TMemEntryAPI); cdecl;
  TGetPluginStatisticsCallback = procedure(AText: Pointer; ATextLen: DWord); cdecl; //AText is expected to be a CRLF or LF - separated string

  TLoadLstFile = procedure(AFileName: Pointer; AFileNameLen: DWord); cdecl;
  TLoadHexFile = procedure(AFileName: Pointer; AFileNameLen: DWord); cdecl;
  TGetMemEntryCount = function: DWord; cdecl;
  TGetMemEntry = procedure(ACallback: TGetMemEntryCallback; AEntryIndex: DWord); cdecl;  //AEntryIndex can go from 0 to GetMemEntryCount - 1
  TGetStatistics = procedure(ACallback: TGetPluginStatisticsCallback); cdecl;

implementation

end.

