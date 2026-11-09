{
    Copyright (C) 2026 VCC
    creation date: 05 Nov 2026
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
  {$IFnDEF FPC}
    DWord = Cardinal;
  {$ENDIF}

  TMemEntryAPI = record
    Address: Cardinal;
    Size: Cardinal; //in Bytes
    EntryName: Pointer;//string;
    EntryNameLen: Cardinal;
    Index: Cardinal; //reserved for future use
  end;

  TAddressTranslationOperationAPI = (atoNone, atoADD, atoOR);

  TMemoryTranslationInfoAPI = record
    Operation: TAddressTranslationOperationAPI;
    Value: DWord;
  end;

  TGetRawMemContentCallback = function(AIndex: Integer): Cardinal; cdecl;
  TGetMemContentAddressCallback = function(AIndex: Integer): Cardinal; cdecl;
  TGetMemContentSizeCallback = function(AIndex: Integer): Cardinal; cdecl;
  TAddressInMemRangeCallback = function(ASectionIndex: Integer; AAddress, AddrOffset: Int64): Boolean; cdecl;
  TGetMemTranslationInfoCallback = procedure(ASectionIndex: Integer; var AMemoryTranslationInfo: TMemoryTranslationInfoAPI); cdecl;
  TGetAddressOffsetsCallback = procedure(ASectionIndex: Integer; var ASeg1, ASeg2: Integer); cdecl;
  TGetDefSectionNameCallback = procedure(ASectionIndex: Integer; var ASectionName: Pointer; var ASectionNameLength: Cardinal); cdecl;
  TGetSectionEntryAddressesCallback = procedure(ASectionIndex: Integer; var MinAddrSeg1, MinAddrSeg2, MaxAddrSeg1, MaxAddrSeg2: Cardinal); cdecl;

  TMemTableInfo = record
    SectionCount, MemContentLength, RawMemContentLength: Integer;
    DeviceName: Pointer;  //used to identify if it's PIC32 or PIC24/dsPIC
    DeviceNameLength: Cardinal;

    GetRawMemContentCallback: TGetRawMemContentCallback;
    GetMemContentAddressCallback: TGetMemContentAddressCallback;
    GetMemContentSizeCallback: TGetMemContentSizeCallback;
    AddressInMemRangeCallback: TAddressInMemRangeCallback;
    GetMemTranslationInfoCallback: TGetMemTranslationInfoCallback;
    GetAddressOffsetsCallback: TGetAddressOffsetsCallback;
    GetDefSectionNameCallback: TGetDefSectionNameCallback; //ROM, RAM, BOOTROM, CFGREG, EBIROM, SQIROM, EEPROM  /  rom, ram, bootrom, cfgreg, ebirom, sqirom, eeprom
    GetSectionEntryAddressesCallback: TGetSectionEntryAddressesCallback;
  end;


  TGetMemEntryCallback = procedure(AEntry: TMemEntryAPI); cdecl;
  TGetPluginStatisticsCallback = procedure(AText: Pointer; ATextLen: DWord); cdecl; //AText is expected to be a CRLF or LF - separated string

  TLoadLstFile = procedure(AFileName: Pointer; AFileNameLen: DWord); cdecl;
  TLoadHexFile = procedure(AFileName: Pointer; AFileNameLen: DWord); cdecl;
  TGetMemEntryCount = function: DWord; cdecl;
  TGetMemEntry = procedure(AResultCallback: TGetMemEntryCallback; AEntryIndex: DWord); cdecl;  //AEntryIndex can go from 0 to GetMemEntryCount - 1
  TGetStatistics = procedure(AResultCallback: TGetPluginStatisticsCallback; AMemTableInfo: TMemTableInfo); cdecl;

implementation

end.

