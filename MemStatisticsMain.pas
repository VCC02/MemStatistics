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


unit MemStatisticsMain;

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
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, ComCtrls, Buttons, SettingsForm,
  MemTables, MikroStuff, MemStatUtils, IniFiles, MemStatCompareForm, Menus;

type

  { TfrmMemStatisticsMain }

  TfrmMemStatisticsMain = class(TForm)
    lblListName: TLabel;
    lblChipName: TLabel;
    lblVstBackgroundRaw: TLabel;
    tmrStartup: TTimer;
    lblDefsFolder: TLabel;
    tmrBlinkGraphicFocus: TTimer;
    prbLoading: TProgressBar;
    StatusBar1: TStatusBar;
    PageControlEntries: TPageControl;
    TabSheetRoutines: TTabSheet;
    TabSheetRaw: TTabSheet;
    rdgrpChartContent: TRadioGroup;
    lblVstBackground: TLabel;
    prbUpdateSignalsListRun1: TProgressBar;
    lbeMem: TLabeledEdit;
    lbeAddrHex: TLabeledEdit;
    lbeAddrDec: TLabeledEdit;
    lbeSize: TLabeledEdit;
    lbeEntryName: TLabeledEdit;
    spdClearFilters: TSpeedButton;
    pnlVisibleEntries: TPanel;
    TabSheetStatistics: TTabSheet;
    lstFreeMemory: TListBox;
    btnSettings: TButton;
    btnNewCompareWindow: TButton;
    SaveDialog1: TSaveDialog;
    pnlSplitter: TPanel;
    tmrDrawZoom: TTimer;
    pmEntries: TPopupMenu;
    MenuItem_VSTHints: TMenuItem;
    pmChart: TPopupMenu;
    MenuItem_Reload: TMenuItem;
    MenuItem_SetDefsFolder: TMenuItem;
    N1: TMenuItem;
    MenuItem_BlinkFocusedEntry: TMenuItem;
    MenuItem_EnableZoomWindow: TMenuItem;
    MenuItem_ChartHints: TMenuItem;
    pnlHorizontalResize: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure tmrStartupTimer(Sender: TObject);
    procedure vstMemTableGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstMemTableBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstMemTableClick(Sender: TObject);
    procedure tmrBlinkGraphicFocusTimer(Sender: TObject);
    procedure vstMemTableKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstMemTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vstRawTableBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstRawTableClick(Sender: TObject);
    procedure vstRawTableGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstRawTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstRawTableKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgrpChartContentClick(Sender: TObject);
    procedure vstMemTableCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstMemTableHeaderClick(Sender: TVTHeader; {$IFDEF FPC} HitInfo: TVTHeaderHitInfo{$ELSE} Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer{$ENDIF});
    procedure vstMemTableFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);

    procedure vstMemTablePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure vstRawTablePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);

    procedure lbeMemChange(Sender: TObject);
    procedure lbeAddrHexKeyPress(Sender: TObject; var Key: Char);
    procedure lbeSizeKeyPress(Sender: TObject; var Key: Char);
    procedure lbeAddrDecKeyPress(Sender: TObject; var Key: Char);
    procedure spdClearFiltersClick(Sender: TObject);
    procedure vstRawTableFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstRawTableCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstRawTableHeaderClick(Sender: TVTHeader; {$IFDEF FPC} HitInfo: TVTHeaderHitInfo{$ELSE} Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer{$ENDIF});
    procedure PageControlEntriesChange(Sender: TObject);
    procedure lstFreeMemoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnNewCompareWindowClick(Sender: TObject);
    procedure pnlSplitterMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlSplitterMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlSplitterMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrDrawZoomTimer(Sender: TObject);
    procedure MenuItem_VSTHintsClick(Sender: TObject);
    procedure MenuItem_ReloadClick(Sender: TObject);
    procedure MenuItem_ChartHintsClick(Sender: TObject);
    procedure MenuItem_SetDefsFolderClick(Sender: TObject);
    procedure MenuItem_BlinkFocusedEntryClick(Sender: TObject);
    procedure MenuItem_EnableZoomWindowClick(Sender: TObject);
    procedure pnlSplitterResize(Sender: TObject);
    procedure pnlHorizontalResizeResize(Sender: TObject);
  private
    { Private declarations }
    FMemTable: TMemTable;
    FMikroComp: TMikroComp;
    FCmdlineLstFile: TFileName;
   
    FMemStatOptions: TMemStatOptions;
    FHold: Boolean;
    FSplitterMouseDownGlobalPos: TPoint;
    FSplitterMouseDownImagePos: TPoint;
    FCurrentMousePosOnPreviewImg: TPoint;

    vstMemTable: TVirtualStringTree;
    vstRawTable: TVirtualStringTree;

    procedure CreateRemainingComponents;
    procedure RepositionSplitter;
    procedure SetMemTableHeightFromDefsFolder;

    function FastTabReplace(s: string): string;
    procedure GenerateTextStatistics;
    procedure ApplyDeviceSettings;

    procedure SetFocusedEntryBySelectedNode;
    procedure SetFocusedEntryFromRawBySelectedNode;
    
    function GetVstMemTableLine(Node: PVirtualNode): string;
    function VstMemTable_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;
    function GetVstRawTableLine(Node: PVirtualNode): string;
    function VstRawTable_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;

    function GetIndexOfSectionFromDataAddress(ADataAddress: DWord): Integer;
    function GetIndexOfSectionFromRawIndex(ARawIndex: Integer): Integer;

    procedure MikroCompOnBeginLoadingLst(MaxLines: Integer);
    procedure MikroCompOnLoadinLstProgressUpdate(Position: Integer);
    procedure MikroCompOnEndLoadingLst(MaxLines: Integer);
    procedure MikroCompOnAddMemTableEntry(DataToBeAdded: PRoutinesRec);
    procedure MikroCompOnAddRawTableEntry(DataToBeAdded: PRoutinesRec);

    procedure UpdateColorOptionsForAllOpenCompareForms;
    procedure SetBlinkTimerState;

    procedure MemTableMouseEnter(Sender: TObject);
    procedure MemTableMouseLeave(Sender: TObject);
    procedure MemTableMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure DisplayDefsFolder;
    function TableColumnIsVisible(AColIdx: Integer): Boolean;
    function HandleOnGetVisibleColumnCount: Integer;
    function HandleOnGetColumnVisibility(AColumnIndex: Integer): Boolean;
    procedure HandleOnCmpWindowDestroy(ACmpWindowHandle: THandle);
    procedure HandleOnGetTableMemContent(var AMemEntries: TMemEntryArr);
    procedure HandleOnGetTableMemContentFromRaw(var AMemEntries: TMemEntryArr);
  public
    { Public declarations }
    procedure CmpFrmOnChangeDevice(Sender: TfrmMemStatCompare);
    procedure SetDefsFolder;
    procedure SetDefsFolderToAllCmpInstances;

    procedure LoadMlk(DeviceName: string);
    procedure LoadLST(LstFileFnm: string);
    
    procedure LoadSettingsFromIni;
    procedure LoadColorsFromIni(Ini: TMemIniFile);
    procedure LoadMemSectionsFromIni(Ini: TMemIniFile);
    procedure SaveSettingsToIni;
    procedure SaveColorsToIni(Ini: TMemIniFile);
    procedure SaveMemSectionsToIni(Ini: TMemIniFile);

    procedure AddMemTableEntry(DataToBeAdded: PRoutinesRec);
    procedure AddRawTableEntry(DataToBeAdded: PRoutinesRec);
    procedure SearchInMemTable(Mem, EntryName, AddressHex, AddressDec, Size: string);
    procedure SearchInRawTable(Mem, EntryName, AddressHex, AddressDec: string);
  end;

var
  frmMemStatisticsMain: TfrmMemStatisticsMain;


{ToDo
 - Find a way to hide RAM section in cmp window. It should display sections, based on VisibleOnCompare flag.
 [] - There are many GetIndexOfSectionFromDataAddress and GetIndexOfSectionFromRawIndex calls in various handlers of the two tables.
   Their results should be cached in OnBeforePaint handler and used in the others.
 - Check if the compare VST can be loaded faster (on PIC32MZ), when EBI and SQI are visible
 - In TMemTable.Paint, the for loops should use the entries from TDevInfoEditArr, because the sections can be swapped. So far, only the colors are properly used.
   Maybe the old arrays have to be discarded. An alternative would be to have a DisplayPosition field, because TMemTable uses indexed sections.
   Once this task is implemented (i.e. MemTables can display positioned columns), then the MoveUp/MoveDown buttons, from settings form, should be enabled.
 - In LoadMlk, there should be some section concatenations, for those sections with multiple ranges.
 - KSEG statistics are PIC32 specific. They should be moved to a plugin. If the plugin is present, it should provide this info. Otherwise, nothing more should be displayed.
   There are "free words" calculations, which are currently commented and depend on a specific harcoded section order.
 - Displaying split columns (S1 and S2 schemes) is PIC32 specific, because of KSEGs. This should be an option in settings window. There is no proper support for this in MemTables.
 - See  "get a concatenated range, and make sure DrawMem and DrawMemFocusedEntry will also use that"  comment in MemTables.pas.
 - The setting window should not have the "Update" button. There should be only "Add" and "Delete". "Add" should add a new empty row.
 - Bug - the displayed ranges, for non-existent columns, look wrong. See EEPROM.
 [] - verify if both def parsers support reversed tag order  (max, then min)
   vstMemTableCompareNodes and vstRawTableCompareNodes require refactoring
 - Finish support for multiple address ranges / section. There are many hardcoded calls with the first range (index 0).
 - the minimap on cmp window should display grayed (desaturated) areas for 0xFFFFFFFF entries.
 - when writing to sim mem, make sure to properly mask bits, because Flash allows writing '0's only. This is required, to get same content as a read-back hex file. (Should be an option)
 - add an option to display selected command on minimap
 - SendCmdToCompareWindowByIndex - refactoring
 - verify if EraseMemoryChunk and WriteMemory really require calls to GetUserNoteAtAddress and UpdateUserNote
 - bug - when the def folder priority is set to folder (first option), the displayed list of devices (on cmp window) is empty
 - the VST on SimMem window, should have colored background, depending on target addresses, like all the other tables. On PIC32, there should be a memory translation.
 - verify if LoadRoutinesFromMainWindow can be further optimized by sorting Routines and EntriesFromRaw arrays, at least in FP, since it is slower than Delphi  (see SortAlgs unit)
 - the page control (with the two VSTs), buttons, editboxes, should sit on a panel. This panel can be modified by splitter.
 - verify various typecasting to Integer, which might cause wrong results on 64-bit

 - repainting the minimap from SimMem window should be done by a debounce timer. This should prevent the current amount of flickering.
 [] - Bug - fix AV in CopyDataFromFileSlot  (data sync error)
 - TRTLCriticalSection under Linux has different fields. See if they can be used in PollingFIFO.
 [in work] - Set timeouts in Linux (if required/possible)
 - BaudRateToConst should return an "error" value for unknown baud rates and that should end up in an error message on window (on tooltip)
 - display erase page and write page selection (Addr [Hex] column) on cmp window, based on received device info
 - load custom lst, instead of loading from main on cmp window
 - bug - the cmp window doesn't want to load lst info from main, until used by SimMem window
 - the SimMem window should highlight commands which will end up erasing or writing out of bounds memory
 - memory sections should have a flag, configurable from settings window, to highlight if they are erased/written by commands on SimWindow. The CFG sections should be set to True.
 - the .lst loader should read comments, because they contain names for most routines
}


implementation

{$IFDEF FPC}
  {$R *.frm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}

{$R MemStatisticsTheme.res}

uses
  {$IFnDEF FPC}
    FileCtrl,
  {$ENDIF}
  Math, ClipBrd, DeviceInfo, ClickerZoomPreviewForm, SimulatedMemForm;


{
  PIC32MZ2048EFH100  EBI & SQI  address range:

  PHY:   0x20000000 - 0x23FFFFFF  EBI
  PHY:   0x24000000 - 0x2FFFFFFF  Reserved
  PHY:   0x30000000 - 0x33FFFFFF  SQI
  PHY:   0x34000000 - 0x3FFFFFFF  Reserved
  PHY:   0x40000000 - 0xFFFFFFFF  Reserved

  KSEG2: 0xC0000000 - 0xC3FFFFFF  EBI
  KSEG2: 0xC4000000 - 0xCFFFFFFF  Reserved
  KSEG2: 0xD0000000 - 0xD3FFFFFF  SQI
  KSEG2: 0xD4000000 - 0xDFFFFFFF  Reserved

  KSEG3: 0xE0000000 - 0xE3FFFFFF  SQI
  KSEG3: 0xE4000000 - 0xE7FFFFFF  Reserved
  KSEG3: 0xF0000000 - 0xF3FFFFFF  SQI
  KSEG3: 0xF4000000 - 0xFFFFFFFF  Reserved
}


procedure TfrmMemStatisticsMain.LoadSettingsFromIni;
var
  Ini: TMemIniFile;
  i: Integer;
  s: string;
begin
  Ini := TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'MemStat.ini');
  try
    Left := Ini.ReadInteger('Window', 'Left', Left);
    Top := Ini.ReadInteger('Window', 'Top', Top);
    Width := Ini.ReadInteger('Window', 'Width', Width);
    Height := Ini.ReadInteger('Window', 'Height', Height);

    for i := 0 to vstMemTable.Header.Columns.Count - 1 do
      vstMemTable.Header.Columns.Items[i].Width := Ini.ReadInteger('Table', 'Col_' + IntToStr(i), vstMemTable.Header.Columns.Items[i].Width);

    for i := 0 to vstRawTable.Header.Columns.Count - 1 do
      vstRawTable.Header.Columns.Items[i].Width := Ini.ReadInteger('RawTable', 'Col_' + IntToStr(i), vstRawTable.Header.Columns.Items[i].Width);  

    FMemStatOptions.Misc.ShowDefsFolderOnMainWindow := Ini.ReadBool('mikro', 'ShowDefsFolderOnMainWindow', True);
    s := Ini.ReadString('mikro', 'DefsFolder', '');     //  'C:\Program Files\Mikroelektronika\mikroPascal PRO for PIC32\Defs'
    if DirectoryExists(s) then
    begin
      FMikroComp.DefsFolder := s;
      DisplayDefsFolder;
      lblDefsFolder.Hint := FMikroComp.DefsFolder;
      lblDefsFolder.Visible := FMemStatOptions.Misc.ShowDefsFolderOnMainWindow;
    end
    else
    begin
      FMikroComp.DefsFolder := s; //'';   //set it to the value from ini, to allow displaying it on settings window
      lblDefsFolder.Caption := '"Defs" Folder: not set';
      lblDefsFolder.Hint := FMikroComp.DefsFolder;
      lblDefsFolder.Visible := True;
    end;

    FMemStatOptions.Misc.DefsFolderPriority := TDefsFolderPriority(Min(Ord(High(TDefsFolderPriority)), Ini.ReadInteger('mikro', 'DefsFolderPriority', 0)));
    FMikroComp.DefsFolderPriority := FMemStatOptions.Misc.DefsFolderPriority;

    MenuItem_BlinkFocusedEntry.Checked := Ini.ReadBool('Table', 'BlinkSelected', True);

    rdgrpChartContent.ItemIndex := Ini.ReadInteger('Table', 'ChartContentSel', rdgrpChartContent.ItemIndex);

    LoadMemSectionsFromIni(Ini);
    LoadColorsFromIni(Ini);
    FMemTable.MemStatColorOptions := FMemStatOptions.Colors;
    FMemTable.MemStatMiscOptions := FMemStatOptions.Misc;

    MenuItem_VSTHints.Checked := FMemStatOptions.Misc.DisplayTableHints;
    MenuItem_ChartHints.Checked := FMemStatOptions.Misc.DisplayChartHints;
    MenuItem_EnableZoomWindow.Checked := FMemStatOptions.Misc.DisplayZoomWindow;

    vstMemTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;
    vstRawTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;    
    SetBlinkTimerState;
  finally
    Ini.Free;
  end;
end;


procedure TfrmMemStatisticsMain.LoadColorsFromIni(Ini: TMemIniFile);
var
  i, n: Integer;
  Suffix: string;
begin
  FMemStatOptions.Colors.FirstFileEntryChart := Ini.ReadInteger('Colors', 'FirstFileEntryChart', clRed);
  FMemStatOptions.Colors.SecondFileEntryChart := Ini.ReadInteger('Colors', 'SecondFileEntryChart', clLime);
  FMemStatOptions.Colors.ThirdFileEntryChart := Ini.ReadInteger('Colors', 'ThirdFileEntryChart', clSkyBlue);
  FMemStatOptions.Colors.FourthFileEntryChart := Ini.ReadInteger('Colors', 'FourthFileEntryChart', clGreen);

  FMemStatOptions.Colors.FirstFileSelectedEntryChart := Ini.ReadInteger('Colors', 'FirstFileSelectedEntryChart', clBlack);
  FMemStatOptions.Colors.SecondFileSelectedEntryChart := Ini.ReadInteger('Colors', 'SecondFileSelectedEntryChart', clBlack);
  FMemStatOptions.Colors.ThirdFileSelectedEntryChart := Ini.ReadInteger('Colors', 'ThirdFileSelectedEntryChart', clBlack);
  FMemStatOptions.Colors.FourthFileSelectedEntryChart := Ini.ReadInteger('Colors', 'FourthFileSelectedEntryChart', clBlack);

  FMemStatOptions.Colors.Overlap := Ini.ReadInteger('Colors', 'Overlap', clGray);
  FMemStatOptions.Colors.UseOverlapColor := Ini.ReadBool('Colors', 'UseOverlapColor', False);

  FMemStatOptions.Colors.TextBackgroundChart := Ini.ReadInteger('Colors', 'TextBackgroundChart', clCream);
  FMemStatOptions.Colors.TextColorChart := Ini.ReadInteger('Colors', 'TextColorChart', clBlack);

  FMemStatOptions.Colors.BackgroundChart := Ini.ReadInteger('Colors', 'BackgroundChart', clCream);
  FMemStatOptions.Colors.LineChart := Ini.ReadInteger('Colors', 'LineChart', clBlack);

  //a bit of overlap with LoadMemSectionsFromIni, until EntryColorTableArr can be replaced
  n := Ini.ReadInteger('MemSections', 'Count', 0);
  SetLength(FMemStatOptions.Colors.EntryColorArr, n);
  SetLength(FMemStatOptions.Colors.SelectedEntryColorArr, n);
  SetLength(FMemStatOptions.Colors.EntryColorTableArr, n);
  SetLength(FMemStatOptions.Colors.TextColorTableArr, n);
  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
  begin
    Suffix := IntToStr(i);
    FMemStatOptions.Colors.EntryColorArr[i] := Ini.ReadInteger('MemSections', 'EntryChartColor_' + Suffix, clRed);
    FMemStatOptions.Colors.SelectedEntryColorArr[i] := Ini.ReadInteger('MemSections', 'SelectedEntryChartColor_' + Suffix, clLime);
    FMemStatOptions.Colors.EntryColorTableArr[i] := Ini.ReadInteger('MemSections', 'TableEntryColor_' + Suffix, $00C8C8FF);
    FMemStatOptions.Colors.TextColorTableArr[i] := Ini.ReadInteger('MemSections', 'TableTextColor_' + Suffix, clBlack);
  end;

  FMemStatOptions.Misc.DisplayDecimalAddressesCmpTable := Ini.ReadBool('Misc', 'DisplayDecimalAddressesCmpTable', False);
  FMemStatOptions.Misc.DisplayTableHints := Ini.ReadBool('Misc', 'DisplayTableHints', True);
  FMemStatOptions.Misc.DisplayChartHints := Ini.ReadBool('Misc', 'DisplayChartHints', True);
  FMemStatOptions.Misc.DisplayZoomWindow := Ini.ReadBool('Misc', 'DisplayZoomWindow', True);
  FMemStatOptions.Misc.DefaultChipName := Ini.ReadString('Misc', 'DefaultChipName', 'PIC32MX795F512L');
  FMemStatOptions.Misc.DefFilePrefix := Ini.ReadString('Misc', 'DefFilePrefix', 'P32');
  FMemStatOptions.Misc.ExpectedPrefix := Ini.ReadString('Misc', 'ExpectedPrefix', 'PIC32');
  FMemStatOptions.Misc.DeviceBitness := TDeviceBitness(Min(Ini.ReadInteger('Misc', 'DeviceBitness', Ord(db32)), Ord(High(TDeviceBitness))));
end;


procedure TfrmMemStatisticsMain.LoadMemSectionsFromIni(Ini: TMemIniFile);
var
  i: Integer;
  Suffix: string;
begin
  SetLength(FMemStatOptions.DevInfoEditArr, Ini.ReadInteger('MemSections', 'Count', 0));
  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
  begin
    Suffix := IntToStr(i);
    FMemStatOptions.DevInfoEditArr[i].Section.DisplayName := Ini.ReadString('MemSections', 'DisplayName_' + Suffix, 'Mem');
    FMemStatOptions.DevInfoEditArr[i].Section.LongDisplayName := Ini.ReadString('MemSections', 'LongDisplayName_' + Suffix, 'Memory');
    FMemStatOptions.DevInfoEditArr[i].Section.DefName := Ini.ReadString('MemSections', 'DefName_' + Suffix, 'MEM');
    SetLength(FMemStatOptions.DevInfoEditArr[i].Section.AddrRanges, 0); //updated when reading the definition file, as this field is device specific

    FMemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo.Operation := TAddressTranslationOperation(Ini.ReadInteger('MemSections', 'MemoryTranslationInfo.Operation_' + Suffix, Ord(atoNone)));
    FMemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo.Value := Ini.ReadInteger('MemSections', 'MemoryTranslationInfo.Value_' + Suffix, 0);

    FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S1 := Ini.ReadInteger('MemSections', 'AddressOffsets.S1_' + Suffix, 0);
    FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S2 := Ini.ReadInteger('MemSections', 'AddressOffsets.S2_' + Suffix, 0);
    FMemStatOptions.DevInfoEditArr[i].EntryColor := Ini.ReadInteger('MemSections', 'EntryChartColor_' + Suffix, clRed);
    FMemStatOptions.DevInfoEditArr[i].SelectedEntryColor := Ini.ReadInteger('MemSections', 'SelectedEntryChartColor_' + Suffix, clLime);
    FMemStatOptions.DevInfoEditArr[i].TableEntryColor := Ini.ReadInteger('MemSections', 'TableEntryColor_' + Suffix, $00C8C8FF);
    FMemStatOptions.DevInfoEditArr[i].TableTextColor := Ini.ReadInteger('MemSections', 'TableTextColor_' + Suffix, clBlack);

    FMemStatOptions.DevInfoEditArr[i].VisibleOnTable := Ini.ReadBool('MemSections', 'VisibleOnTable_' + Suffix, True);
    FMemStatOptions.DevInfoEditArr[i].VisibleOnCompare := Ini.ReadBool('MemSections', 'VisibleOnCompare_' + Suffix, True);
    FMemStatOptions.DevInfoEditArr[i].DisplayEvenIfMissingFromDefinition := Ini.ReadBool('MemSections', 'DisplayEvenIfMissingFromDefinition_' + Suffix, True);
  end;
end;


procedure TfrmMemStatisticsMain.SaveSettingsToIni;
var
  Ini: TMemIniFile;
  i: Integer;
begin
  Ini := TMemIniFile.Create(ExtractFilePath(ParamStr(0)) + 'MemStat.ini');
  try
    Ini.WriteInteger('Window', 'Left', Left);
    Ini.WriteInteger('Window', 'Top', Top);
    Ini.WriteInteger('Window', 'Width', Width);
    Ini.WriteInteger('Window', 'Height', Height);

    for i := 0 to vstMemTable.Header.Columns.Count - 1 do
      Ini.WriteInteger('Table', 'Col_' + IntToStr(i), vstMemTable.Header.Columns.Items[i].Width);

    for i := 0 to vstRawTable.Header.Columns.Count - 1 do
      Ini.WriteInteger('RawTable', 'Col_' + IntToStr(i), vstRawTable.Header.Columns.Items[i].Width);

    Ini.WriteBool('mikro', 'ShowDefsFolderOnMainWindow', FMemStatOptions.Misc.ShowDefsFolderOnMainWindow);
    if Trim(FMikroComp.DefsFolder) <> '' then
      Ini.WriteString('mikro', 'DefsFolder', FMikroComp.DefsFolder);     //  'C:\Program Files\Mikroelektronika\mikroPascal PRO for PIC32\Defs'

    Ini.WriteInteger('mikro', 'DefsFolderPriority', Ord(FMemStatOptions.Misc.DefsFolderPriority));

    Ini.WriteBool('Table', 'BlinkSelected', MenuItem_BlinkFocusedEntry.Checked);
    Ini.WriteInteger('Table', 'ChartContentSel', rdgrpChartContent.ItemIndex);

    SaveMemSectionsToIni(Ini);
    SaveColorsToIni(Ini);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;


procedure TfrmMemStatisticsMain.SaveColorsToIni(Ini: TMemIniFile);
begin
  Ini.WriteInteger('Colors', 'FirstFileEntryChart', FMemStatOptions.Colors.FirstFileEntryChart);
  Ini.WriteInteger('Colors', 'SecondFileEntryChart', FMemStatOptions.Colors.SecondFileEntryChart);
  Ini.WriteInteger('Colors', 'ThirdFileEntryChart', FMemStatOptions.Colors.ThirdFileEntryChart);
  Ini.WriteInteger('Colors', 'FourthFileEntryChart', FMemStatOptions.Colors.FourthFileEntryChart);

  Ini.WriteInteger('Colors', 'FirstFileSelectedEntryChart', FMemStatOptions.Colors.FirstFileSelectedEntryChart);
  Ini.WriteInteger('Colors', 'SecondFileSelectedEntryChart', FMemStatOptions.Colors.SecondFileSelectedEntryChart);
  Ini.WriteInteger('Colors', 'ThirdFileSelectedEntryChart', FMemStatOptions.Colors.ThirdFileSelectedEntryChart);
  Ini.WriteInteger('Colors', 'FourthFileSelectedEntryChart', FMemStatOptions.Colors.FourthFileSelectedEntryChart);

  Ini.WriteInteger('Colors', 'Overlap', FMemStatOptions.Colors.Overlap);
  Ini.WriteBool('Colors', 'UseOverlapColor', FMemStatOptions.Colors.UseOverlapColor);

  Ini.WriteInteger('Colors', 'TextBackgroundChart', FMemStatOptions.Colors.TextBackgroundChart);
  Ini.WriteInteger('Colors', 'TextColorChart', FMemStatOptions.Colors.TextColorChart);

  Ini.WriteInteger('Colors', 'BackgroundChart', FMemStatOptions.Colors.BackgroundChart);
  Ini.WriteInteger('Colors', 'LineChart', FMemStatOptions.Colors.LineChart);

  Ini.WriteBool('Misc', 'DisplayDecimalAddressesCmpTable', FMemStatOptions.Misc.DisplayDecimalAddressesCmpTable);
  Ini.WriteBool('Misc', 'DisplayTableHints', FMemStatOptions.Misc.DisplayTableHints);
  Ini.WriteBool('Misc', 'DisplayChartHints', FMemStatOptions.Misc.DisplayChartHints);
  Ini.WriteBool('Misc', 'DisplayZoomWindow', FMemStatOptions.Misc.DisplayZoomWindow);

  Ini.WriteString('Misc', 'DefaultChipName', FMemStatOptions.Misc.DefaultChipName);
  Ini.WriteString('Misc', 'DefFilePrefix', FMemStatOptions.Misc.DefFilePrefix);
  Ini.WriteString('Misc', 'ExpectedPrefix', FMemStatOptions.Misc.ExpectedPrefix);
  Ini.WriteInteger('Misc', 'DeviceBitness', Ord(FMemStatOptions.Misc.DeviceBitness));
end;


procedure TfrmMemStatisticsMain.SaveMemSectionsToIni(Ini: TMemIniFile);
var
  i: Integer;
  Suffix: string;
begin
  Ini.WriteInteger('MemSections', 'Count', Length(FMemStatOptions.DevInfoEditArr));

  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
  begin
    Suffix := IntToStr(i);
    Ini.WriteString('MemSections', 'DisplayName_' + Suffix, FMemStatOptions.DevInfoEditArr[i].Section.DisplayName);
    Ini.WriteString('MemSections', 'LongDisplayName_' + Suffix, FMemStatOptions.DevInfoEditArr[i].Section.LongDisplayName);
    Ini.WriteString('MemSections', 'DefName_' + Suffix, FMemStatOptions.DevInfoEditArr[i].Section.DefName);

    Ini.WriteInteger('MemSections', 'MemoryTranslationInfo.Operation_' + Suffix, Ord(FMemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo.Operation));
    Ini.WriteInteger('MemSections', 'MemoryTranslationInfo.Value_' + Suffix, FMemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo.Value);

    Ini.WriteInteger('MemSections', 'AddressOffsets.S1_' + Suffix, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S1);
    Ini.WriteInteger('MemSections', 'AddressOffsets.S2_' + Suffix, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S2);
    Ini.WriteInteger('MemSections', 'EntryChartColor_' + Suffix, FMemStatOptions.DevInfoEditArr[i].EntryColor);
    Ini.WriteInteger('MemSections', 'SelectedEntryChartColor_' + Suffix, FMemStatOptions.DevInfoEditArr[i].SelectedEntryColor);
    Ini.WriteInteger('MemSections', 'TableEntryColor_' + Suffix, FMemStatOptions.DevInfoEditArr[i].TableEntryColor);
    Ini.WriteInteger('MemSections', 'TableTextColor_' + Suffix, FMemStatOptions.DevInfoEditArr[i].TableTextColor);

    Ini.WriteBool('MemSections', 'VisibleOnTable_' + Suffix, FMemStatOptions.DevInfoEditArr[i].VisibleOnTable);
    Ini.WriteBool('MemSections', 'VisibleOnCompare_' + Suffix, FMemStatOptions.DevInfoEditArr[i].VisibleOnCompare);
    Ini.WriteBool('MemSections', 'DisplayEvenIfMissingFromDefinition_' + Suffix, FMemStatOptions.DevInfoEditArr[i].DisplayEvenIfMissingFromDefinition);
  end;
end;


procedure TfrmMemStatisticsMain.lstFreeMemoryKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
    if Key = Ord('C') then
      Clipboard.AsText := lstFreeMemory.Items.Text; 
end;


procedure TfrmMemStatisticsMain.PageControlEntriesChange(Sender: TObject);
begin
  if PageControlEntries.ActivePageIndex = 0 then
  begin
    if FMikroComp.MemTableVisibleEntries = 1 then
      pnlVisibleEntries.Caption := '1 visible entry'
    else
      pnlVisibleEntries.Caption := IntToStr(FMikroComp.MemTableVisibleEntries) + ' visible entries';
  end
  else
  begin
    if FMikroComp.RawTableVisibleEntries = 1 then
      pnlVisibleEntries.Caption := '1 visible entry'
    else
      pnlVisibleEntries.Caption := IntToStr(FMikroComp.RawTableVisibleEntries) + ' visible entries';
  end;
end;


procedure TfrmMemStatisticsMain.pnlHorizontalResizeResize(Sender: TObject);
begin
  {$IFDEF FPC}
    RepositionSplitter;  //the OnResize event is not executed for main form, while resizing, so use this splitter. (FPC only)
  {$ENDIF}
end;


procedure TfrmMemStatisticsMain.pnlSplitterMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift <> [ssLeft] then
    Exit;
    
  if not FHold then
  begin
    GetCursorPos(FSplitterMouseDownGlobalPos);

    FSplitterMouseDownImagePos.X := pnlSplitter.Left;
    FHold := True;
  end;
end;


procedure TfrmMemStatisticsMain.pnlSplitterMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  tp: TPoint;
  NewLeft: Integer;
begin
  if Shift <> [ssLeft] then
    Exit;

  if not FHold then
    Exit;

  GetCursorPos(tp);
  NewLeft := FSplitterMouseDownImagePos.X + tp.X - FSplitterMouseDownGlobalPos.X;

  if NewLeft < 436 then
    NewLeft := 436;

  if NewLeft > Width - 560 then
    NewLeft := Width - 560;

  if pnlSplitter.Left <> NewLeft then
  begin
    pnlSplitter.Left := NewLeft;

    PageControlEntries.Left := pnlSplitter.Left + pnlSplitter.Width + 5;
    PageControlEntries.Width := Width - PageControlEntries.Left - 10;

    FMemTable.Width := pnlSplitter.Left - 5 - FMemTable.Left;

    //FMemTable.Repaint;
  end;
end;


procedure TfrmMemStatisticsMain.pnlSplitterMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FHold := False;
end;


procedure TfrmMemStatisticsMain.RepositionSplitter;
var
  NewLeft: Integer;
begin
  NewLeft := pnlSplitter.Left;

  if NewLeft < 436 then
    NewLeft := 436;

  if NewLeft > Width - 560 then
    NewLeft := Width - 560;

  pnlSplitter.Left := NewLeft;

  PageControlEntries.Left := pnlSplitter.Left + pnlSplitter.Width + 5;
  PageControlEntries.Width := Width - PageControlEntries.Left - 20;

  FMemTable.Width := pnlSplitter.Left - 5 - FMemTable.Left;
end;


procedure TfrmMemStatisticsMain.FormResize(Sender: TObject);
begin
  RepositionSplitter;
end;


procedure TfrmMemStatisticsMain.pnlSplitterResize(
  Sender: TObject);
begin
  {$IFDEF FPC}
    RepositionSplitter;  //the OnResize event is not executed for main form, while resizing, so use this splitter. (FPC only)
  {$ENDIF}
end;


procedure TfrmMemStatisticsMain.MikroCompOnBeginLoadingLst(MaxLines: Integer);
begin
  StatusBar1.Panels.Items[0].Text := 'Loading';
  prbLoading.Position := 0;
  prbLoading.Max := MaxLines;
end;


procedure TfrmMemStatisticsMain.MikroCompOnLoadinLstProgressUpdate(Position: Integer);
begin
  prbLoading.Position := Position;
end;


procedure TfrmMemStatisticsMain.MikroCompOnEndLoadingLst(MaxLines: Integer);
begin
  prbLoading.Position := 0;
  StatusBar1.Panels.Items[0].Text := 'Loaded';

  vstRawTable.RootNodeCount := FMikroComp.LstAddrRaw.Count;

  FMemTable.Repaint;
  GenerateTextStatistics;
end;


procedure TfrmMemStatisticsMain.MikroCompOnAddMemTableEntry(DataToBeAdded: PRoutinesRec);
begin
  AddMemTableEntry(DataToBeAdded);
end;


procedure TfrmMemStatisticsMain.MikroCompOnAddRawTableEntry(DataToBeAdded: PRoutinesRec);
begin
  AddRawTableEntry(DataToBeAdded);
end;


procedure TfrmMemStatisticsMain.rdgrpChartContentClick(Sender: TObject);
begin
  case rdgrpChartContent.ItemIndex of
    0: FMemTable.WhatEntriesToDisplay := 1;
    1: FMemTable.WhatEntriesToDisplay := 2;
    2: FMemTable.WhatEntriesToDisplay := 3;
  end;
end;


procedure TfrmMemStatisticsMain.DisplayDefsFolder;
var
  ADir: string;
begin
  ADir := FMikroComp.DefsFolder;

  if Length(ADir) <= 30 then
    lblDefsFolder.Caption := '"Defs" Folder: ' + ADir
  else
  {$IFnDEF UNIX}
    lblDefsFolder.Caption :=  '"Defs" Folder: ' + ExtractFileDrive(ADir) + '\...' + ExtractFileName(ExtractFileDir(ADir)) + '\' + ExtractFileName(ADir); //'"Defs" Folder: ' + Copy(ADir, 1, 3) + '...' + Copy(ADir, Length(ADir) - 30);
  {$ELSE}
    lblDefsFolder.Caption := '"Defs" Folder: ' + Copy(ADir, 1, Pos('/', Copy(ADir, 2, MaxInt))) + '/...' + Copy(ADir, Length(ADir) - 30);
  {$ENDIF}
end;


procedure TfrmMemStatisticsMain.SetDefsFolder;
var
  ADir: string;
begin
  ADir := FMikroComp.DefsFolder;
  {$IFDEF FPC}
    if SelectDirectory('"Defs" Folder', '', ADir) then
  {$ELSE}
    if SelectDirectory('"Defs" Folder', '', ADir, [sdNewFolder, sdShowEdit, sdShowShares, sdNewUI, sdValidateDir], Self) then
  {$ENDIF}
  begin
    FMikroComp.DefsFolder := ADir;
    FMemStatOptions.Misc.DefsFolder := ADir;
    DisplayDefsFolder;

    lblDefsFolder.Hint := ADir;
    SaveSettingsToIni;
  end;
end;


procedure TfrmMemStatisticsMain.UpdateColorOptionsForAllOpenCompareForms;
var
  i: Integer;
begin
  for i := 0 to Application.ComponentCount - 1 do
    if Application.Components[i] is TfrmMemStatCompare then
    begin
      (Application.Components[i] as TfrmMemStatCompare).MemStatColorOptions := FMemStatOptions.Colors;
      (Application.Components[i] as TfrmMemStatCompare).MemStatMiscOptions := FMemStatOptions.Misc;
    end;
end;


procedure TfrmMemStatisticsMain.SetMemTableHeightFromDefsFolder;
begin
  if not lblDefsFolder.Visible then
  begin
    FMemTable.Top := pnlSplitter.Top;
    FMemTable.Height := pnlSplitter.Height;
  end
  else
  begin
    FMemTable.Top := 80;
    FMemTable.Height := ClientHeight - 6 - FMemTable.Top - StatusBar1.Height;
  end;
end;


procedure TfrmMemStatisticsMain.btnSettingsClick(Sender: TObject);
var
  AMemStatOptions: TMemStatOptions;
begin
  AMemStatOptions := FMemStatOptions;
  AMemStatOptions.Misc.DefsFolder := FMikroComp.DefsFolder;   // FMikroComp.DefsFolder is the main setting.   MemStatOptions.Misc.DefsFolder is used for editor only.

  if EditMemStatOptions(AMemStatOptions) then
  begin
    FMemStatOptions := AMemStatOptions;
    FMemTable.MemStatColorOptions := FMemStatOptions.Colors;
    FMemTable.MemStatMiscOptions := FMemStatOptions.Misc;

    if FMikroComp.DefsFolder <> AMemStatOptions.Misc.DefsFolder then
    begin
      FMikroComp.DefsFolder := AMemStatOptions.Misc.DefsFolder;
      DisplayDefsFolder;
      lblDefsFolder.Hint := FMikroComp.DefsFolder;
    end;

    lblDefsFolder.Visible := FMemStatOptions.Misc.ShowDefsFolderOnMainWindow;
    SetMemTableHeightFromDefsFolder;

    vstMemTable.Repaint;
    vstRawTable.Repaint;

    vstMemTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;
    vstRawTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;

    FMemTable.Repaint;
    UpdateColorOptionsForAllOpenCompareForms;

    SaveSettingsToIni;
  end;
end;


procedure TfrmMemStatisticsMain.ApplyDeviceSettings;
//const
//  CSectionCount = 6;
//  CDefNames: array[0..CSectionCount - 1] of string = ('ROM', 'RAM', 'BOOTROM', 'CFGREG', 'EBIROM', 'SQIROM');
//  CDisplayNames: array[0..CSectionCount - 1] of string = ('PFM', 'RAM', 'BFM', 'CFG', 'EBI', 'SQI');
//  CLongDisplayNames: array[0..CSectionCount - 1] of string = ('Program Flash', 'RAM', 'Boot Flash', 'Config Flash', 'Ext Bus Interface', 'Ser Quad Interface');
var
  i: Integer;
  DevPrefix: TDevicePrefix;
begin
  FMikroComp.MemTable.DeviceInfo.ClearInfo;

  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
  begin
    FMikroComp.MemTable.DeviceInfo.AddDeviceSection(FMemStatOptions.DevInfoEditArr[i].Section);
    FMikroComp.MemTable.DeviceInfo.AddMemoryTranslationInfo(FMemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo);
    FMikroComp.MemTable.DeviceInfo.AddAddressOffsets(FMemStatOptions.DevInfoEditArr[i].AddressOffsets);
  end;

  FMikroComp.MemTable.DeviceInfo.DefaultChipName := FMemStatOptions.Misc.DefaultChipName;
  DevPrefix.DefFile := FMemStatOptions.Misc.DefFilePrefix;
  DevPrefix.Expected := FMemStatOptions.Misc.ExpectedPrefix;
  FMikroComp.MemTable.DeviceInfo.AddDevicePrefix(DevPrefix);
  FMikroComp.MemTable.DeviceInfo.DeviceBitness := FMemStatOptions.Misc.DeviceBitness;
end;


procedure TfrmMemStatisticsMain.btnNewCompareWindowClick(Sender: TObject);
const
  CExcluedSectionName = 'RAM';
var
  frmMemStatCompare: TfrmMemStatCompare;
  TempAllSections: TSectionArr;
  i: Integer;
  DevPrefix: TDevicePrefix;
  MemoryTranslationInfoArr: TMemoryTranslationInfoArr;
begin
  Application.CreateForm(TfrmMemStatCompare, frmMemStatCompare);

//  FMikroComp.GetDeviceSections(TempAllSections, CExcluedSectionName);  //////////////////////////////////////////////// when excluding, the cmp window does not properly index the array 
//  FMikroComp.GetMemoryTranslationInfo(MemoryTranslationInfoArr, CExcluedSectionName);
  FMikroComp.GetDeviceSections(TempAllSections, '');
  FMikroComp.GetMemoryTranslationInfo(MemoryTranslationInfoArr, '');

  try
    for i := 0 to Length(TempAllSections) - 1 do
    begin
      frmMemStatCompare.DeviceInfo.AddDeviceSection(TempAllSections[i]);
      frmMemStatCompare.DeviceInfo.AddMemoryTranslationInfo(MemoryTranslationInfoArr[i]);
    end;
  finally
    for i := 0 to Length(TempAllSections) - 1 do
      SetLength(TempAllSections[i].AddrRanges, 0);

    SetLength(TempAllSections, 0);
    SetLength(MemoryTranslationInfoArr, 0);
  end;

  frmMemStatCompare.MemStatColorOptions := FMemStatOptions.Colors;
  frmMemStatCompare.MemStatMiscOptions := FMemStatOptions.Misc;

  frmMemStatCompare.CmdlineLstFile := FCmdlineLstFile;

  frmMemStatCompare.DeviceInfo.DefaultChipName := FMikroComp.MemTable.DeviceInfo.DefaultChipName;

  DevPrefix.DefFile := FMemStatOptions.Misc.DefFilePrefix;
  DevPrefix.Expected := FMemStatOptions.Misc.ExpectedPrefix;
  frmMemStatCompare.DeviceInfo.AddDevicePrefix(DevPrefix);
  frmMemStatCompare.DeviceInfo.DeviceBitness := FMikroComp.MemTable.DeviceInfo.DeviceBitness;

  if Pos('PIC', lblChipName.Caption) > 0 then
    frmMemStatCompare.ChipName := Copy(lblChipName.Caption, Pos('PIC', lblChipName.Caption), MaxInt)
  else
    frmMemStatCompare.ChipName := '';

  frmMemStatCompare.DefsFolder := FMikroComp.DefsFolder;
  frmMemStatCompare.OnChangeDevice := CmpFrmOnChangeDevice;
  frmMemStatCompare.OnCmpWindowDestroy := HandleOnCmpWindowDestroy;
  frmMemStatCompare.OnGetTableMemContent := HandleOnGetTableMemContent;
  frmMemStatCompare.OnGetTableMemContentFromRaw := HandleOnGetTableMemContentFromRaw;
  frmMemStatCompare.Show;

  ListOfFrmMemStatCompare.Add(frmMemStatCompare);
end;


procedure TfrmMemStatisticsMain.MemTableMouseEnter(Sender: TObject);
var
  tp: TPoint;
begin
  if not MenuItem_EnableZoomWindow.Checked then
    Exit;
    
  FMemTable.ShowHint := False;
  GetCursorPos(tp);
  ShowZoom(tp.X + 50, tp.Y + 50);
end;


procedure TfrmMemStatisticsMain.MemTableMouseLeave(Sender: TObject);
begin
  FMemTable.ShowHint := True and MenuItem_ChartHints.Checked;
  Application.ProcessMessages;
  HideZoom;
end;


procedure TfrmMemStatisticsMain.MemTableMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FCurrentMousePosOnPreviewImg.X := X;
  FCurrentMousePosOnPreviewImg.Y := Y;

  tmrDrawZoom.Enabled := True;
end;


procedure TfrmMemStatisticsMain.SetBlinkTimerState;
begin
  tmrBlinkGraphicFocus.Enabled := MenuItem_BlinkFocusedEntry.Checked;
  if not MenuItem_BlinkFocusedEntry.Checked then
  begin
    FMemTable.DisplayFocusedEntry := True;
    FMemTable.PaintGraphicOnly;
  end;
end;


procedure TfrmMemStatisticsMain.MenuItem_BlinkFocusedEntryClick(
  Sender: TObject);
begin
  SetBlinkTimerState;
end;


procedure TfrmMemStatisticsMain.MenuItem_ChartHintsClick(Sender: TObject);
begin
  FMemStatOptions.Misc.DisplayChartHints := MenuItem_ChartHints.Checked;
end;


procedure TfrmMemStatisticsMain.MenuItem_EnableZoomWindowClick(Sender: TObject);
begin
  FMemStatOptions.Misc.DisplayZoomWindow := MenuItem_EnableZoomWindow.Checked;

  if not FMemStatOptions.Misc.DisplayZoomWindow then
    HideZoom;
end;


procedure TfrmMemStatisticsMain.MenuItem_ReloadClick(Sender: TObject);
begin
  LoadMlk(ParamStr(2));
  LoadLST(ParamStr(1));
end;


procedure TfrmMemStatisticsMain.MenuItem_SetDefsFolderClick(Sender: TObject);
var
  res: Integer;
begin
  SetDefsFolder;

  if ListOfFrmMemStatCompare.Count > 1 then
  begin
    res := MessageBox(Handle, 'Do you want to set this same folder to all comparison instances?', PChar(Application.Title), MB_ICONINFORMATION + MB_YESNO);

    if res = IDYES then
      SetDefsFolderToAllCmpInstances;
  end;
end;


procedure TfrmMemStatisticsMain.MenuItem_VSTHintsClick(Sender: TObject);
begin
  FMemStatOptions.Misc.DisplayTableHints := MenuItem_VSTHints.Checked; 
  vstMemTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;
  vstRawTable.ShowHint := FMemStatOptions.Misc.DisplayTableHints;
end;


procedure TfrmMemStatisticsMain.CreateRemainingComponents;
var
  NewColum: TVirtualTreeColumn;
begin
  vstMemTable := TVirtualStringTree.Create(Self);
  vstMemTable.Parent := TabSheetRoutines;

  vstMemTable.Colors.UnfocusedSelectionColor := clGradientInactiveCaption;
  vstMemTable.Font.Size := 8;
  vstMemTable.Font.Height := -11;
  vstMemTable.Font.Name := 'Tahoma';
  vstMemTable.Font.Style := [];
  vstMemTable.Left := 8;
  vstMemTable.Top := 8;
  vstMemTable.Width := TabSheetRoutines.Width - 16;
  vstMemTable.Height := TabSheetRoutines.Height - 16;
  vstMemTable.Anchors := [akLeft, akTop, akRight, akBottom];
  vstMemTable.Header.AutoSizeIndex := 0;
  vstMemTable.Header.DefaultHeight := 17;
  vstMemTable.Header.Font.Charset := DEFAULT_CHARSET;
  vstMemTable.Header.Font.Color := clWindowText;
  vstMemTable.Header.Font.Height := -11;
  vstMemTable.Header.Font.Name := 'Tahoma';
  vstMemTable.Header.Font.Style := [];
  vstMemTable.Header.Options := [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible];
  vstMemTable.Header.SortColumn := 5;
  vstMemTable.Header.Style := hsFlatButtons;
  vstMemTable.Header.Height := 21;
  vstMemTable.Indent := 0;
  vstMemTable.ParentShowHint := False;
  vstMemTable.ScrollBarOptions.AlwaysVisible := True;
  vstMemTable.ShowHint := True;
  vstMemTable.TabOrder := 0;
  vstMemTable.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus];
  vstMemTable.TreeOptions.PaintOptions := [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines];
  vstMemTable.TreeOptions.SelectionOptions := [toFullRowSelect, toRightClickSelect];
  vstMemTable.OnBeforeCellPaint := vstMemTableBeforeCellPaint;
  vstMemTable.OnClick := vstMemTableClick;
  vstMemTable.OnCompareNodes := vstMemTableCompareNodes;
  vstMemTable.OnFreeNode := vstMemTableFreeNode;
  vstMemTable.OnGetText := vstMemTableGetText;
  vstMemTable.OnHeaderClick := vstMemTableHeaderClick;
  vstMemTable.OnKeyDown := vstMemTableKeyDown;
  vstMemTable.OnKeyUp := vstMemTableKeyUp;
  vstMemTable.OnPaintText := vstMemTablePaintText;

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 70;
  NewColum.Position := 0;
  NewColum.Width := 70;
  NewColum.Text := 'Index';

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 35;
  NewColum.Position := 1;
  NewColum.Width := 35;
  NewColum.Text := 'Mem';

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 103;
  NewColum.Position := 2;
  NewColum.Width := 103;
  NewColum.Text := 'Address [Hex]';

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Position := 3;
  NewColum.Width := 100;
  NewColum.Text := 'Address [Dec]';

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 80;
  NewColum.Position := 4;
  NewColum.Width := 80;
  NewColum.Text := 'Size [Bytes]';

  NewColum := vstMemTable.Header.Columns.Add;
  NewColum.MinWidth := 190;
  NewColum.Position := 5;
  NewColum.Width := 190;
  NewColum.Text := 'Name';

  vstRawTable := TVirtualStringTree.Create(Self);
  vstRawTable.Parent := TabSheetRaw;

  vstRawTable.Colors.UnfocusedSelectionColor := clGradientInactiveCaption;
  vstRawTable.Font.Size := 8;
  vstRawTable.Font.Height := -11;
  vstRawTable.Font.Name := 'Tahoma';
  vstRawTable.Font.Style := [];
  vstRawTable.Left := 8;
  vstRawTable.Top := 8;
  vstRawTable.Width := TabSheetRaw.Width - 16;
  vstRawTable.Height := TabSheetRaw.Height - 16;
  vstRawTable.Anchors := [akLeft, akTop, akRight, akBottom];
  vstRawTable.Header.AutoSizeIndex := 0;
  vstRawTable.Header.DefaultHeight := 17;
  vstRawTable.Header.Font.Charset := DEFAULT_CHARSET;
  vstRawTable.Header.Font.Color := clWindowText;
  vstRawTable.Header.Font.Height := -11;
  vstRawTable.Header.Font.Name := 'Tahoma';
  vstRawTable.Header.Font.Style := [];
  vstRawTable.Header.Options := [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible];
  vstRawTable.Header.SortColumn := 4;
  vstRawTable.Header.Style := hsFlatButtons;
  vstRawTable.Header.Height := 21;
  vstRawTable.Indent := 0;
  vstRawTable.ParentShowHint := False;
  vstRawTable.ScrollBarOptions.AlwaysVisible := True;
  vstRawTable.ShowHint := True;
  vstRawTable.TabOrder := 0;
  vstRawTable.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus];
  vstRawTable.TreeOptions.PaintOptions := [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines];
  vstRawTable.TreeOptions.SelectionOptions := [toFullRowSelect, toRightClickSelect];
  vstRawTable.OnBeforeCellPaint := vstRawTableBeforeCellPaint;
  vstRawTable.OnClick := vstRawTableClick;
  vstRawTable.OnCompareNodes := vstRawTableCompareNodes;
  vstRawTable.OnFreeNode := vstRawTableFreeNode;
  vstRawTable.OnGetText := vstRawTableGetText;
  vstRawTable.OnHeaderClick := vstRawTableHeaderClick;
  vstRawTable.OnKeyDown := vstRawTableKeyDown;
  vstRawTable.OnKeyUp := vstRawTableKeyUp;
  vstRawTable.OnPaintText := vstRawTablePaintText;

  NewColum := vstRawTable.Header.Columns.Add;
  NewColum.MinWidth := 70;
  NewColum.Position := 0;
  NewColum.Width := 70;
  NewColum.Text := 'Index';

  NewColum := vstRawTable.Header.Columns.Add;
  NewColum.MinWidth := 35;
  NewColum.Position := 1;
  NewColum.Width := 35;
  NewColum.Text := 'Mem';

  NewColum := vstRawTable.Header.Columns.Add;
  NewColum.MinWidth := 103;
  NewColum.Position := 2;
  NewColum.Width := 103;
  NewColum.Text := 'Address [Hex]';

  NewColum := vstRawTable.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Position := 3;
  NewColum.Width := 100;
  NewColum.Text := 'Address [Dec]';

  NewColum := vstRawTable.Header.Columns.Add;
  NewColum.MinWidth := 250;
  NewColum.Position := 4;
  NewColum.Width := 250;
  NewColum.Text := 'Content';
end;


procedure TfrmMemStatisticsMain.FormCreate(Sender: TObject);
begin
  CreateRemainingComponents;
  
  FMemTable := TMemTable.Create(frmMemStatisticsMain);
  FMemTable.Parent := frmMemStatisticsMain;
  FMemTable.Font.Size := 8;
  FMemTable.Font.Height := -11;
  FMemTable.Font.Name := 'Tahoma';
  FMemTable.Font.Style := [];
  FMemTable.Left := 10;
  FMemTable.Top := 80;
  FMemTable.Width := 450;
  FMemTable.Height := ClientHeight - 6 - FMemTable.Top - StatusBar1.Height;
  FMemTable.Anchors := [akLeft, akTop, akBottom];
  FMemTable.PopupMenu := pmChart;
  FMemTable.OnMouseEnter := MemTableMouseEnter;
  FMemTable.OnMouseLeave := MemTableMouseLeave;
  FMemTable.OnMouseMove := MemTableMouseMove;
  FMemTable.OnGetVisibleColumnCount := HandleOnGetVisibleColumnCount;
  FMemTable.OnGetColumnVisibility := HandleOnGetColumnVisibility;

  FMikroComp := TMikroComp.Create(Self);
  FMikroComp.MemTable := FMemTable;
  FMikroComp.MainFormHandle := Handle;
  FMikroComp.AppTitle := Application.Title;

  FMikroComp.OnBeginLoadingLst := MikroCompOnBeginLoadingLst;
  FMikroComp.OnLoadingLstProgressUpdate := MikroCompOnLoadinLstProgressUpdate;
  FMikroComp.OnEndLoadingLst := MikroCompOnEndLoadingLst;
  FMikroComp.OnAddMemTableEntry := MikroCompOnAddMemTableEntry;
  FMikroComp.OnAddRawTableEntry := MikroCompOnAddRawTableEntry;

  FCmdlineLstFile := '';
  FHold := False;

  ListOfFrmMemStatCompare := TfrmMemStatCompareList.Create;

  if ParamStr(1) <> '' then
  begin
    if FileExists(ParamStr(1)) then
    begin
      lblListName.Caption := 'List Name: ' + ExtractFileName(ParamStr(1));
      FCmdlineLstFile := ParamStr(1);
      tmrStartup.Enabled := True;
      lstFreeMemory.Visible := True;
    end
    else
      lblListName.Caption := 'List Name: File not found.';
  end
  else
    rdgrpChartContent.Visible := False;

  lblListName.Hint := ParamStr(1);

  if ParamStr(2) <> '' then
    lblChipName.Caption := 'Chip Name: ' + ParamStr(2);

  Application.Title := Caption;

  FMikroComp.DefsFolder := '';
  lblDefsFolder.Caption := '"Defs" Folder: not set';
  lblDefsFolder.Hint := FMikroComp.DefsFolder;

  FMikroComp.AllowSearch := True;
  FMikroComp.MemTableVisibleEntries := 0;
  FMikroComp.RawTableVisibleEntries := 0;

  LoadSettingsFromIni;
  PageControlEntries.ActivePageIndex := 0;

  vstMemTable.Hint := 'Press:' + #13#10 + #13#10 +
                      'Ctrl+C to copy the selected line.' + #13#10 +
                      'Ctrl+Shift+C to copy the entire table.' + #13#10 +
                      'Ctrl+Alt+C to copy the selected line with header.' + #13#10 +
                      'Ctrl+Alt+Shift+C to copy the entire table with header.' + #13#10 + #13#10 +
                      'Ctrl+S to save the selected line.' + #13#10 +
                      'Ctrl+Shift+S to save the entire table.' + #13#10 +
                      'Ctrl+Alt+S to save the selected line with header.' + #13#10 +
                      'Ctrl+Alt+Shift+S to save the entire table with header.';

  vstRawTable.Hint := vstMemTable.Hint;

  vstMemTable.PopupMenu := pmEntries;
  vstRawTable.PopupMenu := pmEntries;

  Application.HintHidePause := 10000;
end;


procedure TfrmMemStatisticsMain.FormPaint(Sender: TObject);
begin
  FMemTable.PaintGraphicOnlyOption := False;
  FMemTable.Paint;
end;


procedure TfrmMemStatisticsMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ParamStr(1) <> '' then
    if FileExists(ParamStr(1)) then
      SaveSettingsToIni;
end;


procedure TfrmMemStatisticsMain.lbeAddrDecKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;


procedure TfrmMemStatisticsMain.lbeAddrHexKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', 'a'..'f', 'A'..'F', #8]) then
    Key := #0;
end;


procedure TfrmMemStatisticsMain.lbeMemChange(Sender: TObject);
begin
  SearchInMemTable(lbeMem.Text, lbeEntryName.Text, lbeAddrHex.Text, lbeAddrDec.Text, lbeSize.Text);
  SearchInRawTable(lbeMem.Text, lbeEntryName.Text, lbeAddrHex.Text, lbeAddrDec.Text);
end;


procedure TfrmMemStatisticsMain.lbeSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;


procedure TfrmMemStatisticsMain.tmrBlinkGraphicFocusTimer(Sender: TObject);
begin
  FMemTable.DisplayFocusedEntry := not FMemTable.DisplayFocusedEntry;
  FMemTable.PaintGraphicOnly;
end;


procedure TfrmMemStatisticsMain.tmrDrawZoomTimer(Sender: TObject);
var
  tp: TPoint;
begin
  tmrDrawZoom.Enabled := False;
  GetCursorPos(tp);
  SetZoomContent(FMemTable.Canvas.Handle, FMemTable.Width, FMemTable.Height, FCurrentMousePosOnPreviewImg.X, FCurrentMousePosOnPreviewImg.Y, tp.X + 50, tp.Y + 50);
end;


procedure TfrmMemStatisticsMain.tmrStartupTimer(Sender: TObject);
begin
  tmrStartup.Enabled := False;
  vstMemTable.NodeDataSize := SizeOf(TRoutinesRec);
  vstRawTable.NodeDataSize := SizeOf(TRoutinesRec);
  SetMemTableHeightFromDefsFolder;

  LoadMlk(ParamStr(2));
  LoadLST(ParamStr(1));
end;


//adds one entry to VST
procedure TfrmMemStatisticsMain.AddMemTableEntry(DataToBeAdded: PRoutinesRec);
var
  Data: PRoutinesRec; //pointer to array of string
  CurrentNode: PVirtualNode;
begin
  if not Assigned(DataToBeAdded) then
    Exit; 

  CurrentNode := vstMemTable.RootNode;
  CurrentNode := vstMemTable.InsertNode(CurrentNode.LastChild, amInsertAfter);
  Data := vstMemTable.GetNodeData(CurrentNode);

  Data^ := DataToBeAdded^;
end;


//adds one entry to VST
procedure TfrmMemStatisticsMain.AddRawTableEntry(DataToBeAdded: PRoutinesRec);
var
  Data: PRoutinesRec; //pointer to array of string
  CurrentNode: PVirtualNode;
begin
  if not Assigned(DataToBeAdded) then
    Exit; 

  CurrentNode := vstRawTable.RootNode;
  CurrentNode := vstRawTable.InsertNode(CurrentNode.LastChild, amInsertAfter);
  Data := vstRawTable.GetNodeData(CurrentNode);

  Data^ := DataToBeAdded^;
end;


function TfrmMemStatisticsMain.GetIndexOfSectionFromDataAddress(ADataAddress: DWord): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
    if FMemTable.AddressIn_MemRange(i, ADataAddress, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S1) or
       FMemTable.AddressIn_MemRange(i, ADataAddress, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S2) then
      begin
        Result := i;
        Break;
      end;
end;


function TfrmMemStatisticsMain.GetIndexOfSectionFromRawIndex(ARawIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
    if FMemTable.RawIndexIn_MemRange(i, ARawIndex, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S1) or
       FMemTable.RawIndexIn_MemRange(i, ARawIndex, FMemStatOptions.DevInfoEditArr[i].AddressOffsets.S2) then
      begin
        Result := i;
        Break;
      end;
end;


procedure TfrmMemStatisticsMain.vstMemTableBeforeCellPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  n: Integer;
  Data: PRoutinesRec;
  SectionIndex: Integer;
begin
  if CellPaintMode <> cpmPaint then
    Exit;
  if not Assigned(Node) then
    Exit;

  n := (Sender as TVirtualStringTree).RootNodeCount;

  if Node.Index >= Cardinal(n) then
    Exit;

  Data := vstMemTable.GetNodeData(Node);  

  try
    TargetCanvas.Brush.Color := clWindow;

    SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);
    if SectionIndex <> -1 then
      TargetCanvas.Brush.Color := FMemStatOptions.Colors.EntryColorTableArr[SectionIndex];

    TargetCanvas.Pen.Color := clWindow;
    TargetCanvas.Rectangle(CellRect);
  except
  end;
end;


procedure TfrmMemStatisticsMain.SetFocusedEntryBySelectedNode;
var
  Node: PVirtualNode;
  Data: PRoutinesRec;
begin
  Node := vstMemTable.GetFirstSelected;
  if not Assigned(Node) then
    Exit;

  Data := vstMemTable.GetNodeData(Node);
  FMemTable.EntryToFocusOn := Data.EntryNumber;
end;


procedure TfrmMemStatisticsMain.SetFocusedEntryFromRawBySelectedNode;
var
  Node: PVirtualNode;
  i, n: Integer;
  Addr: Cardinal;
  Data: PRoutinesRec;
  TempMemEntry: TMemEntry;
begin
  Node := vstRawTable.GetFirstSelected;
  if not Assigned(Node) then
    Exit;

  Data := vstRawTable.GetNodeData(Node); 

  Addr := FMemTable.GetRawMemContent(Data.EntryNumber);
  n := FMemTable.GetNumberOfProcessedRawEntries;

  for i := 0 to n - 1 do
  begin
    TempMemEntry := FMemTable.GetMemContentFromRaw(i);
    
    if (Addr >= TempMemEntry.Address) and (Addr <= TempMemEntry.Address + TempMemEntry.Size) then
    begin
      FMemTable.EntryToFocusOnRaw := i;     //Data.EntryNumber
      Break; //added later
    end;
  end;
end;


procedure TfrmMemStatisticsMain.vstMemTableClick(Sender: TObject);
begin
  SetFocusedEntryBySelectedNode;
end;


function ZeroToMinusOne(Value: Integer): Integer;
begin
  Result := Value;
  if Value = 0 then
    Result := -1;
end;


procedure TfrmMemStatisticsMain.vstMemTableCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  AnIndex1, AnIndex2: Integer;
  Data1, Data2: PRoutinesRec;
begin
  if (Sender as TVirtualStringTree).RootNodeCount = 0 then
  begin
    Result := 0;
    Exit;
  end;

  Data1 := vstMemTable.GetNodeData(Node1);
  Data2 := vstMemTable.GetNodeData(Node2);
  
  case Column of
    0: Result := CompareValue(Data1.EntryNumber, Data2.EntryNumber);
    1:
    begin
      AnIndex1 := GetIndexOfSectionFromDataAddress(Data1.Address);
      AnIndex2 := GetIndexOfSectionFromDataAddress(Data2.Address);
      Result := CompareStr(IntToStr(AnIndex1), IntToStr(AnIndex2));
    end;

    2, 3: Result := CompareValue(Data1.Address, Data2.Address);
    4: Result := CompareValue(Data1.Size, Data2.Size);
    5: Result := CompareStr(Data1.Name, Data2.Name);
  end; //case
end;


procedure TfrmMemStatisticsMain.vstMemTableFreeNode(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  FreeData: PRoutinesRec;
begin
  try
    FreeData := vstMemTable.GetNodeData(Node);
    FreeData.Name := '';
  except

  end;
end;


procedure TfrmMemStatisticsMain.vstMemTableGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
var
  Data: PRoutinesRec;
  SectionIndex: Integer;
begin
  if (Sender as TVirtualStringTree).RootNodeCount = 0 then
    Exit;

  CellText := '?';

  try
    Data := Sender.GetNodeData(Node);
    case Column of
      0: CellText := IntToStr(Data.EntryNumber);

      1:
      begin
        SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);
        if SectionIndex <> -1 then
          CellText := FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;
      end;

      2: CellText := '0x' + IntToHex(Data.Address, 8);

      3: CellText := IntToStr(Data.Address);

      4: CellText := IntToStr(Data.Size);
      
      5: CellText := Data.Name;
    end;
  except
    CellText := 'exception';
  end;
end;


procedure TfrmMemStatisticsMain.vstMemTableHeaderClick(Sender: TVTHeader;
  {$IFDEF FPC} HitInfo: TVTHeaderHitInfo{$ELSE} Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer{$ENDIF});
begin
  try
    if ((vstMemTable.Owner) as TForm).Visible then
      if vstMemTable.Visible then
        vstMemTable.SetFocus;

    if {$IFDEF FPC} HitInfo.{$ENDIF}Button = mbLeft then
    with Sender do
    begin
      if SortColumn <> {$IFDEF FPC} HitInfo.{$ENDIF}Column then
        SortColumn := {$IFDEF FPC} HitInfo.{$ENDIF}Column
      else
      begin
        if SortDirection = VirtualTrees.sdAscending then
          SortDirection := VirtualTrees.sdDescending
        else
          SortDirection := VirtualTrees.sdAscending
      end;

      vstMemTable.SortTree({$IFDEF FPC} HitInfo.{$ENDIF}Column, Sender.SortDirection{, False});
    end;
  except
    MessageBox(Handle, 'Bug on vstMemTableHeaderClick', PChar(Application.Title), MB_ICONERROR);
  end;
end;


function TfrmMemStatisticsMain.GetVstMemTableLine(Node: PVirtualNode): string;
var
  Data: PRoutinesRec;
  KSegFound: Boolean;
  SectionIndex: Integer;
begin
  Data := VstMemTable.GetNodeData(Node);
  Result := IntToStr(Data.EntryNumber) + #9;
  KSegFound := False;

  SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);
  if SectionIndex <> -1 then
  begin
    Result := Result + FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;
    KSegFound := True;
  end;

  if KSegFound then
    Result := Result + #9
  else
    Result := 'mem?' + #9;

  Result := Result + '0x' + IntToHex(Data.Address, 8) + #9;
  Result := Result + IntToStr(Data.Address) + #9;
  Result := Result + IntToStr(Data.Size) + #9;
  Result := Result + Data.Name;
end;


//columns separated by #9, rows separated by #13#10
function TfrmMemStatisticsMain.VstMemTable_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;
var
  CurrentNode: PVirtualNode;
  s: string;
begin
  CurrentNode := vstMemTable.GetFirst;
  if CurrentNode = nil then
  begin
    Result := '';
    Exit;
  end;

  if CopyWithHeader then
    s := VstMemTable.Header.Columns.Items[0].Text + #9 +
         VstMemTable.Header.Columns.Items[1].Text + #9 +
         VstMemTable.Header.Columns.Items[2].Text + #9 +
         VstMemTable.Header.Columns.Items[3].Text + #9 +
         VstMemTable.Header.Columns.Items[4].Text + #9 +
         VstMemTable.Header.Columns.Items[5].Text +
         #13#10
  else
    s := '';

  repeat
    if not CopyOnlySelectedLine then
      s := s + GetVstMemTableLine(CurrentNode) + #13#10
    else  
      if vstMemTable.Selected[CurrentNode] then
      begin
        s := s + GetVstMemTableLine(CurrentNode);
        Result := s;
        Exit;
      end;

    CurrentNode := CurrentNode.NextSibling;
  until CurrentNode = nil;
  
  Result := s;
end;


procedure TfrmMemStatisticsMain.vstMemTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_HOME) or (Key = VK_END) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
    SetFocusedEntryBySelectedNode;

  if ssCtrl in Shift then
    if Key = Ord('C') then
      Clipboard.AsText := VstMemTable_ToTextTable(not (ssShift in Shift), ssAlt in Shift);

  if ssCtrl in Shift then
    if Key = Ord('S') then
      SaveTableToFile(Handle, VstMemTable_ToTextTable(not (ssShift in Shift), ssAlt in Shift), SaveDialog1);
end;


procedure TfrmMemStatisticsMain.vstMemTableKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_HOME) or (Key = VK_END) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
  begin
    SetFocusedEntryBySelectedNode;
    Node := vstMemTable.GetFirstSelected;
    if Node <> nil then
      vstMemTable.ScrollIntoView(Node, False);
  end;
end;


procedure TfrmMemStatisticsMain.vstRawTableBeforeCellPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  n, SectionIndex: Integer;
  Data: PRoutinesRec;
begin
  if CellPaintMode <> cpmPaint then
    Exit;
  if not Assigned(Node) then
    Exit;

  n := (Sender as TVirtualStringTree).RootNodeCount;

  if Node.Index >= Cardinal(n) then
    Exit;

  Data := vstRawTable.GetNodeData(Node);  

  try
    TargetCanvas.Brush.Color := clWindow;

    SectionIndex := GetIndexOfSectionFromRawIndex(Data.EntryNumber);
    if SectionIndex <> -1 then
      TargetCanvas.Brush.Color := FMemStatOptions.Colors.EntryColorTableArr[SectionIndex];

    TargetCanvas.Pen.Color := clWindow;
    TargetCanvas.Rectangle(CellRect);
  except
  end;
end;


procedure TfrmMemStatisticsMain.vstRawTableClick(Sender: TObject);
begin
  SetFocusedEntryFromRawBySelectedNode;
end;


procedure TfrmMemStatisticsMain.vstRawTableCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  AnIndex1, AnIndex2: Integer;
  Data1, Data2: PRoutinesRec;
begin
  if (Sender as TVirtualStringTree).RootNodeCount = 0 then
  begin
    Result := 0;
    Exit;
  end;

  Data1 := vstRawTable.GetNodeData(Node1);
  Data2 := vstRawTable.GetNodeData(Node2);

  case Column of
    0: Result := CompareValue(Data1.EntryNumber, Data2.EntryNumber);
    1:
    begin
      AnIndex1 := GetIndexOfSectionFromRawIndex(Data1.EntryNumber);
      AnIndex2 := GetIndexOfSectionFromRawIndex(Data2.EntryNumber);
      Result := CompareStr(IntToStr(AnIndex1), IntToStr(AnIndex2));
    end;

    2, 3: Result := CompareValue(Data1.Address, Data2.Address);
    4: Result := CompareStr(Data1.Name, Data2.Name);
  end; //case
end;


procedure TfrmMemStatisticsMain.vstRawTableFreeNode(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  FreeData: PRoutinesRec;
begin
  try
    FreeData := vstRawTable.GetNodeData(Node);
    FreeData.Name := '';
  except

  end;
end;


function TfrmMemStatisticsMain.FastTabReplace(s: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    if s[i] = #9 then
      s[i] := #32;
      
  Result := s;    
end;


procedure TfrmMemStatisticsMain.vstRawTableGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
var
  Data: PRoutinesRec;
  SectionIndex: Integer;
begin
  if FMemTable.GetRawMemContentLength = 0 then
    Exit;

  CellText := '?';
  Data := Sender.GetNodeData(Node);

  try
    case Column of
      0: CellText := IntToStr(Data.EntryNumber);

      1:
      begin
        SectionIndex := GetIndexOfSectionFromRawIndex(Data.EntryNumber);
        if SectionIndex <> -1 then
          CellText := FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;
      end;

      2: CellText := '0x' + IntToHex(Data.Address, 8);

      3: CellText := IntToStr(Data.Address);
      
      4: CellText := FastTabReplace(Data.Name);
    end;
  except
    CellText := 'exception';
  end;
end;


procedure TfrmMemStatisticsMain.vstRawTableHeaderClick(Sender: TVTHeader;
  {$IFDEF FPC} HitInfo: TVTHeaderHitInfo{$ELSE} Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer{$ENDIF});
begin
  try
    if ((vstRawTable.Owner) as TForm).Visible then
      if vstRawTable.Visible then
        vstRawTable.SetFocus;

    if {$IFDEF FPC} HitInfo.{$ENDIF}Button = mbLeft then
      with Sender do
      begin
        if SortColumn <> {$IFDEF FPC} HitInfo.{$ENDIF}Column then
          SortColumn := {$IFDEF FPC} HitInfo.{$ENDIF}Column
        else
        begin
          if SortDirection = VirtualTrees.sdAscending then
            SortDirection := VirtualTrees.sdDescending
          else
            SortDirection := VirtualTrees.sdAscending
        end;

        vstRawTable.SortTree({$IFDEF FPC} HitInfo.{$ENDIF}Column, Sender.SortDirection{, False});
      end;
  except
    MessageBox(Handle, 'Bug on vstRawTableHeaderClick', PChar(Application.Title), MB_ICONERROR);
  end;
end;


function TfrmMemStatisticsMain.GetVstRawTableLine(Node: PVirtualNode): string;
var
  Data: PRoutinesRec;
  KSegFound: Boolean;
  SectionIndex: Integer;
begin
  Data := vstRawTable.GetNodeData(Node);
  Result := IntToStr(Data.EntryNumber) + #9;
  KSegFound := False;

  SectionIndex := GetIndexOfSectionFromRawIndex(Data.EntryNumber);
  if SectionIndex <> -1 then
  begin
    Result := Result + FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;
    KSegFound := True;
  end;

  if KSegFound then
    Result := Result + #9
  else
    Result := 'mem?' + #9;

  Result := Result + '0x' + IntToHex(Data.Address, 8) + #9;
  Result := Result + IntToStr(Data.Address) + #9;
  Result := Result + FastTabReplace(Data.Name);
end;


//columns separated by #9, rows separated by #13#10
function TfrmMemStatisticsMain.VstRawTable_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;
var
  CurrentNode: PVirtualNode;
  s: string;
begin
  CurrentNode := vstRawTable.GetFirst;
  if CurrentNode = nil then
  begin
    Result := '';
    Exit;
  end;

  if CopyWithHeader then
    s := vstRawTable.Header.Columns.Items[0].Text + #9 +
         vstRawTable.Header.Columns.Items[1].Text + #9 +
         vstRawTable.Header.Columns.Items[2].Text + #9 +
         vstRawTable.Header.Columns.Items[3].Text + #9 +
         vstRawTable.Header.Columns.Items[4].Text +
         #13#10
  else
    s := '';

  repeat
    if not CopyOnlySelectedLine then
      s := s + GetVstRawTableLine(CurrentNode) + #13#10
    else  
      if vstRawTable.Selected[CurrentNode] then
      begin
        s := s + GetVstRawTableLine(CurrentNode);
        Result := s;
        Exit;
      end;

    CurrentNode := CurrentNode.NextSibling;
  until CurrentNode = nil;
  Result := s;
end;


procedure TfrmMemStatisticsMain.vstRawTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_HOME) or (Key = VK_END) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
    SetFocusedEntryFromRawBySelectedNode;

  if ssCtrl in Shift then
    if Key = Ord('C') then
      Clipboard.AsText := VstRawTable_ToTextTable(not (ssShift in Shift), ssAlt in Shift);

  if ssCtrl in Shift then
    if Key = Ord('S') then
      SaveTableToFile(Handle, VstRawTable_ToTextTable(not (ssShift in Shift), ssAlt in Shift), SaveDialog1);
end;


procedure TfrmMemStatisticsMain.vstRawTableKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_HOME) or (Key = VK_END) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
  begin
    SetFocusedEntryFromRawBySelectedNode;
    Node := vstRawTable.GetFirstSelected;
    if Node <> nil then
      vstRawTable.ScrollIntoView(Node, False);
  end;
end;


procedure TfrmMemStatisticsMain.SearchInMemTable(Mem, EntryName, AddressHex, AddressDec, Size: string);  //AddressHex has no '$' or '0x'
var
  Node: PVirtualNode;
  VisibleOnVSTResult: Boolean;   
  VisibleFrom_Mem, VisibleFrom_EntryName, VisibleFrom_AddressHex, VisibleFrom_AddressDec, VisibleFrom_Size: Boolean;
  LastNode: PVirtualNode;

  Mem_Empty, EntryName_Empty, AddressHex_Empty, AddressDec_Empty, Size_Empty: Boolean;
  n, SectionIndex: Integer;
  Data: PRoutinesRec;
  CellText: string;
begin
  if not FMikroComp.AllowSearch then
    Exit;
    
  Node := vstMemTable.GetFirst;
  if not Assigned(Node) then
    Exit;

  vstMemTable.BeginUpdate;
  try
    n := 0;
    FMikroComp.MemTableVisibleEntries := 0;

    LastNode := vstMemTable.GetLast;
    prbUpdateSignalsListRun1.Max := LastNode.Index;
    repeat
      Inc(n);

      if n mod 1000 = 0 then
      begin
        {$IFNDEF FPC}
          if GetAsyncKeyState(VK_ESCAPE) < 0 then
            Break;
        {$ENDIF}
        prbUpdateSignalsListRun1.Position := n;
        prbUpdateSignalsListRun1.Repaint;  ////////////// no multithreading
      end;

      try
        Data := vstMemTable.GetNodeData(Node);

        Mem_Empty := Mem = '';
        EntryName_Empty := EntryName = '';
        AddressHex_Empty := AddressHex = '';
        AddressDec_Empty := AddressDec = '';
        Size_Empty := Size = '';


        if Mem_Empty and EntryName_Empty and AddressHex_Empty and AddressDec_Empty and Size_Empty then
          VisibleOnVSTResult := True
        else
        begin
          if Mem_Empty then
            VisibleFrom_Mem := True
          else
          begin
            CellText := '';

            SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);
            if SectionIndex <> -1 then
              CellText := FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;

            VisibleFrom_Mem := Pos(UpperCase(Mem), CellText) > 0;
          end;

          if EntryName_Empty then
            VisibleFrom_EntryName := True
          else
            VisibleFrom_EntryName := Pos(UpperCase(EntryName), UpperCase(Data.Name)) > 0;

          if AddressHex_Empty then
            VisibleFrom_AddressHex := True
          else
            VisibleFrom_AddressHex := Pos(UpperCase(AddressHex), IntToHex(Data.Address, 8)) > 0;

          if AddressDec_Empty then
            VisibleFrom_AddressDec := True
          else
            VisibleFrom_AddressDec := Pos(AddressDec, IntToStr(Data.Address)) > 0;

          if Size_Empty then
            VisibleFrom_Size := True
          else
            VisibleFrom_Size := Pos(Size, IntToStr(Data.Size)) > 0;

          VisibleOnVSTResult := VisibleFrom_Mem and VisibleFrom_EntryName and VisibleFrom_AddressHex and VisibleFrom_AddressDec and VisibleFrom_Size;
        end;

        vstMemTable.IsVisible[Node] := VisibleOnVSTResult;
        if VisibleOnVSTResult then
          FMikroComp.MemTableVisibleEntries := FMikroComp.MemTableVisibleEntries + 1;

        Node := Node.NextSibling; //faster than GetNext
      except

      end;
    until Node = nil;
  finally
    vstMemTable.EndUpdate;
    vstMemTable.UpdateScrollBars(True);

    prbUpdateSignalsListRun1.Position := 0;

    if PageControlEntries.ActivePageIndex = 0 then
    begin
      if FMikroComp.MemTableVisibleEntries = 1 then
        pnlVisibleEntries.Caption := '1 visible entry'
      else
        pnlVisibleEntries.Caption := IntToStr(FMikroComp.MemTableVisibleEntries) + ' visible entries';
    end
    else
    begin
      if FMikroComp.RawTableVisibleEntries = 1 then
        pnlVisibleEntries.Caption := '1 visible entry'
      else
        pnlVisibleEntries.Caption := IntToStr(FMikroComp.RawTableVisibleEntries) + ' visible entries';
    end;
  end;
end;


procedure TfrmMemStatisticsMain.SearchInRawTable(Mem, EntryName, AddressHex, AddressDec: string);  //AddressHex has no '$' or '0x'
var
  Node: PVirtualNode;
  VisibleOnVSTResult: Boolean;   
  VisibleFrom_Mem, VisibleFrom_EntryName, VisibleFrom_AddressHex, VisibleFrom_AddressDec: Boolean;
  LastNode: PVirtualNode;

  Mem_Empty, EntryName_Empty, AddressHex_Empty, AddressDec_Empty: Boolean;
  n, SectionIndex: Integer;
  Data: PRoutinesRec;
  CellText: string;
begin
  if not FMikroComp.AllowSearch then
    Exit;
    
  Node := vstRawTable.GetFirst;
  if not Assigned(Node) then
    Exit;

  vstRawTable.BeginUpdate;
  try
    n := 0;
    FMikroComp.RawTableVisibleEntries := 0;

    LastNode := vstRawTable.GetLast;   //apeleaza GetLast o singura data, nu la fiecare iteratie (e mai rapid asa)
    prbUpdateSignalsListRun1.Max := LastNode.Index;
    repeat
      Inc(n);
      if n mod 1000 = 0 then
      begin
        {$IFNDEF FPC}
          if GetAsyncKeyState(VK_ESCAPE) < 0 then
            Break;
        {$ENDIF}
        prbUpdateSignalsListRun1.Position := n;
        prbUpdateSignalsListRun1.Repaint;  ////////////// no multithreading
      end;
      try
        Data := vstRawTable.GetNodeData(Node);

        Mem_Empty := Mem = '';
        EntryName_Empty := EntryName = '';
        AddressHex_Empty := AddressHex = '';
        AddressDec_Empty := AddressDec = '';

        if Mem_Empty and EntryName_Empty and AddressHex_Empty and AddressDec_Empty then
          VisibleOnVSTResult := True
        else
        begin
          if Mem_Empty then
            VisibleFrom_Mem := True
          else
          begin
            CellText := '';

//            SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);                       ///////////////////////// this is how PIC32MemStat gets the range (from AddressIn_MemRange). Maybe, it's the same.
//            if SectionIndex <> -1 then
//              CellText := FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;

            SectionIndex := GetIndexOfSectionFromRawIndex(Data.EntryNumber);                     /////////////////////// this one seems better
            if SectionIndex <> -1 then
              CellText := FMemStatOptions.DevInfoEditArr[SectionIndex].Section.DisplayName;

            VisibleFrom_Mem := Pos(UpperCase(Mem), CellText) > 0;
          end;

          if EntryName_Empty then
            VisibleFrom_EntryName := True
          else
            VisibleFrom_EntryName := Pos(UpperCase(FastTabReplace(EntryName)), UpperCase(FastTabReplace(Data.Name))) > 0;

          if AddressHex_Empty then
            VisibleFrom_AddressHex := True
          else
            VisibleFrom_AddressHex := Pos(UpperCase(AddressHex), IntToHex(Data.Address, 8)) > 0;

          if AddressDec_Empty then
            VisibleFrom_AddressDec := True
          else
            VisibleFrom_AddressDec := Pos(AddressDec, IntToStr(Data.Address)) > 0;

          VisibleOnVSTResult := VisibleFrom_Mem and VisibleFrom_EntryName and VisibleFrom_AddressHex and VisibleFrom_AddressDec;
        end;

        vstRawTable.IsVisible[Node] := VisibleOnVSTResult;
        if VisibleOnVSTResult then
          FMikroComp.RawTableVisibleEntries := FMikroComp.RawTableVisibleEntries;

        Node := Node.NextSibling; //faster than GetNext
      except

      end;
    until Node = nil;
  finally
    vstRawTable.EndUpdate;
    vstRawTable.UpdateScrollBars(True);

    prbUpdateSignalsListRun1.Position := 0;

    if PageControlEntries.ActivePageIndex = 0 then
    begin
      if FMikroComp.MemTableVisibleEntries = 1 then
        pnlVisibleEntries.Caption := '1 visible entry'
      else
        pnlVisibleEntries.Caption := IntToStr(FMikroComp.MemTableVisibleEntries) + ' visible entries';
    end
    else
    begin
      if FMikroComp.RawTableVisibleEntries = 1 then
        pnlVisibleEntries.Caption := '1 visible entry'
      else
        pnlVisibleEntries.Caption := IntToStr(FMikroComp.RawTableVisibleEntries) + ' visible entries';
    end;
  end;
end;


procedure TfrmMemStatisticsMain.vstMemTablePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PRoutinesRec;
  SectionIndex: Integer;
begin
  if Sender.Selected[Node] then
  begin
    if Sender.Focused then
      TargetCanvas.Font.Color := clWindow
    else
      TargetCanvas.Font.Color := clWindowText;

    Exit;
  end;
  
  Data := vstMemTable.GetNodeData(Node);

  SectionIndex := GetIndexOfSectionFromDataAddress(Data.Address);
  if SectionIndex <> -1 then
    TargetCanvas.Font.Color := FMemStatOptions.Colors.TextColorTableArr[SectionIndex];
end;


procedure TfrmMemStatisticsMain.vstRawTablePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PRoutinesRec;
  SectionIndex: Integer;
begin
  if Sender.Selected[Node] then
  begin
    if Sender.Focused then
      TargetCanvas.Font.Color := clWindow
    else
      TargetCanvas.Font.Color := clWindowText;

    Exit;
  end;

  Data := vstRawTable.GetNodeData(Node);

  SectionIndex := GetIndexOfSectionFromRawIndex(Data.EntryNumber);
  if SectionIndex <> -1 then
    TargetCanvas.Font.Color := FMemStatOptions.Colors.TextColorTableArr[SectionIndex];
end;


procedure TfrmMemStatisticsMain.spdClearFiltersClick(Sender: TObject);
begin
  FMikroComp.AllowSearch := False;
  lbeMem.Text := '';
  lbeAddrHex.Text := '';
  lbeAddrDec.Text := '';
  lbeSize.Text := '';
  lbeEntryName.Text := ''; //call the search proc

  FMikroComp.AllowSearch := True;
  SearchInMemTable(lbeMem.Text, lbeEntryName.Text, lbeAddrHex.Text, lbeAddrDec.Text, lbeSize.Text);
  SearchInRawTable(lbeMem.Text, lbeEntryName.Text, lbeAddrHex.Text, lbeAddrDec.Text);
end;


procedure TfrmMemStatisticsMain.GenerateTextStatistics;
var
  i: Integer;
  PFM_MinEntryAddr_KSEG0: Cardinal;
  PFM_MaxEntryAddr_KSEG0: Cardinal;
  PFM_MinEntryAddr_KSEG1: Cardinal;
  PFM_MaxEntryAddr_KSEG1: Cardinal;

  PFM_MinEntryAddrFound_KSEG0: Boolean;
  PFM_MaxEntryAddrFound_KSEG0: Boolean;
  PFM_MinEntryAddrFound_KSEG1: Boolean;
  PFM_MaxEntryAddrFound_KSEG1: Boolean;

  RAM_MinEntryAddr_KSEG0: Cardinal;
  RAM_MaxEntryAddr_KSEG0: Cardinal;
  RAM_MinEntryAddr_KSEG1: Cardinal;
  RAM_MaxEntryAddr_KSEG1: Cardinal;

  RAM_MinEntryAddrFound_KSEG0: Boolean;
  RAM_MaxEntryAddrFound_KSEG0: Boolean;
  RAM_MinEntryAddrFound_KSEG1: Boolean;
  RAM_MaxEntryAddrFound_KSEG1: Boolean;

  BFM_MinEntryAddr_KSEG0: Cardinal;
  BFM_MaxEntryAddr_KSEG0: Cardinal;
  BFM_MinEntryAddr_KSEG1: Cardinal;
  BFM_MaxEntryAddr_KSEG1: Cardinal;

  BFM_MinEntryAddrFound_KSEG0: Boolean;
  BFM_MaxEntryAddrFound_KSEG0: Boolean;
  BFM_MinEntryAddrFound_KSEG1: Boolean;
  BFM_MaxEntryAddrFound_KSEG1: Boolean;

  EBI_MinEntryAddr_KSEG2: Cardinal;
  EBI_MaxEntryAddr_KSEG2: Cardinal;
  EBI_MinEntryAddr_KSEG3: Cardinal;
  EBI_MaxEntryAddr_KSEG3: Cardinal;

  EBI_MinEntryAddrFound_KSEG2: Boolean;
  EBI_MaxEntryAddrFound_KSEG2: Boolean;
  EBI_MinEntryAddrFound_KSEG3: Boolean;
  EBI_MaxEntryAddrFound_KSEG3: Boolean;

  SQI_MinEntryAddr_KSEG2: Cardinal;
  SQI_MaxEntryAddr_KSEG2: Cardinal;
  SQI_MinEntryAddr_KSEG3: Cardinal;
  SQI_MaxEntryAddr_KSEG3: Cardinal;

  SQI_MinEntryAddrFound_KSEG2: Boolean;
  SQI_MaxEntryAddrFound_KSEG2: Boolean;
  SQI_MinEntryAddrFound_KSEG3: Boolean;
  SQI_MaxEntryAddrFound_KSEG3: Boolean;

  Entry: Cardinal;
  EntryEndAddress: Cardinal;
begin
  lstFreeMemory.Clear;
  //'x free words from 9D01FFFF to first used word'

  PFM_MinEntryAddr_KSEG0 := $FFFFFFFF;
  PFM_MinEntryAddr_KSEG1 := $FFFFFFFF;
  PFM_MaxEntryAddr_KSEG0 := 0;
  PFM_MaxEntryAddr_KSEG1 := 0;

  PFM_MinEntryAddrFound_KSEG0 := False;
  PFM_MaxEntryAddrFound_KSEG0 := False;
  PFM_MinEntryAddrFound_KSEG1 := False;
  PFM_MaxEntryAddrFound_KSEG1 := False;

  RAM_MinEntryAddr_KSEG0 := $FFFFFFFF;
  RAM_MinEntryAddr_KSEG1 := $FFFFFFFF;
  RAM_MaxEntryAddr_KSEG0 := 0;
  RAM_MaxEntryAddr_KSEG1 := 0;

  RAM_MinEntryAddrFound_KSEG0 := False;
  RAM_MaxEntryAddrFound_KSEG0 := False;
  RAM_MinEntryAddrFound_KSEG1 := False;
  RAM_MaxEntryAddrFound_KSEG1 := False;

  BFM_MinEntryAddr_KSEG0 := $FFFFFFFF;
  BFM_MinEntryAddr_KSEG1 := $FFFFFFFF;
  BFM_MaxEntryAddr_KSEG0 := 0;
  BFM_MaxEntryAddr_KSEG1 := 0;

  BFM_MinEntryAddrFound_KSEG0 := False;
  BFM_MaxEntryAddrFound_KSEG0 := False;
  BFM_MinEntryAddrFound_KSEG1 := False;
  BFM_MaxEntryAddrFound_KSEG1 := False;

  EBI_MinEntryAddr_KSEG2 := $FFFFFFFF;
  EBI_MinEntryAddr_KSEG3 := $FFFFFFFF;
  EBI_MaxEntryAddr_KSEG2 := 0;
  EBI_MaxEntryAddr_KSEG3 := 0;

  EBI_MinEntryAddrFound_KSEG2 := False;
  EBI_MaxEntryAddrFound_KSEG2 := False;
  EBI_MinEntryAddrFound_KSEG3 := False;
  EBI_MaxEntryAddrFound_KSEG3 := False;

  SQI_MinEntryAddr_KSEG2 := $FFFFFFFF;
  SQI_MinEntryAddr_KSEG3 := $FFFFFFFF;
  SQI_MaxEntryAddr_KSEG2 := 0;
  SQI_MaxEntryAddr_KSEG3 := 0;

  SQI_MinEntryAddrFound_KSEG2 := False;
  SQI_MaxEntryAddrFound_KSEG2 := False;
  SQI_MinEntryAddrFound_KSEG3 := False;
  SQI_MaxEntryAddrFound_KSEG3 := False;
  
  for i := 0 to FMemTable.GetRawMemContentLength - 1 do
  begin
    Entry := FMemTable.GetRawMemContent(i);

    if FMemTable.AddressIn_MemRange(0, Entry, 0) then //if FMemTable.AddressIn_ProgramFlashKSEG0(Entry) then
    begin
      if PFM_MinEntryAddr_KSEG0 > Entry then
      begin
        PFM_MinEntryAddr_KSEG0 := Entry;
        PFM_MinEntryAddrFound_KSEG0 := True;
      end;

      if PFM_MaxEntryAddr_KSEG0 < Entry then
      begin
        PFM_MaxEntryAddr_KSEG0 := Entry;
        PFM_MaxEntryAddrFound_KSEG0 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(0, Entry, $20000000) then //if FMemTable.AddressIn_ProgramFlashKSEG1(Entry) then
    begin
      if PFM_MinEntryAddr_KSEG1 > Entry then
      begin
        PFM_MinEntryAddr_KSEG1 := Entry;
        PFM_MinEntryAddrFound_KSEG1 := True;
      end;

      if PFM_MaxEntryAddr_KSEG1 < Entry then
      begin
        PFM_MaxEntryAddr_KSEG1 := Entry;
        PFM_MaxEntryAddrFound_KSEG1 := True;
      end;
    end;


    if FMemTable.AddressIn_MemRange(2, Entry, -$20000000) then //if FMemTable.AddressIn_BootFlashKSEG0(Entry) then
    begin
      if BFM_MinEntryAddr_KSEG0 > Entry then
      begin
        BFM_MinEntryAddr_KSEG0 := Entry;
        BFM_MinEntryAddrFound_KSEG0 := True;
      end;

      if BFM_MaxEntryAddr_KSEG0 < Entry then
      begin
        BFM_MaxEntryAddr_KSEG0 := Entry;
        BFM_MaxEntryAddrFound_KSEG0 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(2, Entry, 0) then //if FMemTable.AddressIn_BootFlashKSEG1(Entry) then
    begin
      if BFM_MinEntryAddr_KSEG1 > Entry then
      begin
        BFM_MinEntryAddr_KSEG1 := Entry;
        BFM_MinEntryAddrFound_KSEG1 := True;
      end;

      if BFM_MaxEntryAddr_KSEG1 < Entry then
      begin
        BFM_MaxEntryAddr_KSEG1 := Entry;
        BFM_MaxEntryAddrFound_KSEG1 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(4, Entry, 0) then //if FMemTable.AddressIn_EBIKSEG2(Entry) then
    begin
      if EBI_MinEntryAddr_KSEG2 > Entry then
      begin
        EBI_MinEntryAddr_KSEG2 := Entry;
        EBI_MinEntryAddrFound_KSEG2 := True;
      end;

      if EBI_MaxEntryAddr_KSEG2 < Entry then
      begin
        EBI_MaxEntryAddr_KSEG2 := Entry;
        EBI_MaxEntryAddrFound_KSEG2 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(4, Entry, $20000000) then //if FMemTable.AddressIn_EBIKSEG3(Entry) then
    begin
      if EBI_MinEntryAddr_KSEG3 > Entry then
      begin
        EBI_MinEntryAddr_KSEG3 := Entry;
        EBI_MinEntryAddrFound_KSEG3 := True;
      end;

      if EBI_MaxEntryAddr_KSEG3 < Entry then
      begin
        EBI_MaxEntryAddr_KSEG3 := Entry;
        EBI_MaxEntryAddrFound_KSEG3 := True;
      end;
    end;


    if FMemTable.AddressIn_MemRange(5, Entry, 0) then //if FMemTable.AddressIn_SQIKSEG2(Entry) then
    begin
      if SQI_MinEntryAddr_KSEG2 > Entry then
      begin
        SQI_MinEntryAddr_KSEG2 := Entry;
        SQI_MinEntryAddrFound_KSEG2 := True;
      end;

      if SQI_MaxEntryAddr_KSEG2 < Entry then
      begin
        SQI_MaxEntryAddr_KSEG2 := Entry;
        SQI_MaxEntryAddrFound_KSEG2 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(5, Entry, $20000000) then //if FMemTable.AddressIn_SQIKSEG3(Entry) then
    begin
      if SQI_MinEntryAddr_KSEG3 > Entry then
      begin
        SQI_MinEntryAddr_KSEG3 := Entry;
        SQI_MinEntryAddrFound_KSEG3 := True;
      end;

      if SQI_MaxEntryAddr_KSEG3 < Entry then
      begin
        SQI_MaxEntryAddr_KSEG3 := Entry;
        SQI_MaxEntryAddrFound_KSEG3 := True;
      end;
    end;
  end; //for


  for i := 0 to FMemTable.GetMemContentLength - 1 do
  begin
    Entry := FMemTable.GetMemContent(i).Address;
    EntryEndAddress := Int64(FMemTable.GetMemContent(i).Address) + Int64(FMemTable.GetMemContent(i).Size) - 1;

    if FMemTable.AddressIn_MemRange(1, Entry, -$20000000) then //if FMemTable.AddressIn_RAMKSEG0(Entry) then
    begin
      if RAM_MinEntryAddr_KSEG0 > Entry then
      begin
        RAM_MinEntryAddr_KSEG0 := Entry;
        RAM_MinEntryAddrFound_KSEG0 := True;
      end;

      if RAM_MaxEntryAddr_KSEG0 < EntryEndAddress then
      begin
        RAM_MaxEntryAddr_KSEG0 := EntryEndAddress;
        RAM_MaxEntryAddrFound_KSEG0 := True;
      end;
    end;

    if FMemTable.AddressIn_MemRange(1, Entry, 0) then //if FMemTable.AddressIn_RAMKSEG1(Entry) then
    begin
      if RAM_MinEntryAddr_KSEG1 > Entry then
      begin
        RAM_MinEntryAddr_KSEG1 := Entry;
        RAM_MinEntryAddrFound_KSEG1 := True;
      end;

      if RAM_MaxEntryAddr_KSEG1 < EntryEndAddress then
      begin
        RAM_MaxEntryAddr_KSEG1 := EntryEndAddress;
        RAM_MaxEntryAddrFound_KSEG1 := True;
      end;
    end;
  end; //for

    

  if PFM_MinEntryAddrFound_KSEG0 then
    lstFreeMemory.Items.Add('PFM: First KSEG0 entry: 0x' + IntToHex(PFM_MinEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('PFM: First KSEG0 entry: not found');

  if PFM_MaxEntryAddrFound_KSEG0 then  
    lstFreeMemory.Items.Add('PFM: Last KSEG0 entry: 0x' + IntToHex(PFM_MaxEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('PFM: Last KSEG0 entry: not found');

  if PFM_MinEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('PFM: First KSEG1 entry: 0x' + IntToHex(PFM_MinEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('PFM: First KSEG1 entry: not found');

  if PFM_MaxEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('PFM: Last KSEG1 entry: 0x' + IntToHex(PFM_MaxEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('PFM: Last KSEG1 entry: not found');

  lstFreeMemory.Items.Add('');
  

  if RAM_MinEntryAddrFound_KSEG0 then
    lstFreeMemory.Items.Add('RAM: First KSEG0 entry: 0x' + IntToHex(RAM_MinEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('RAM: First KSEG0 entry: not found');

  if RAM_MaxEntryAddrFound_KSEG0 then  
    lstFreeMemory.Items.Add('RAM: Last KSEG0 entry: 0x' + IntToHex(RAM_MaxEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('RAM: Last KSEG0 entry: not found');

  if RAM_MinEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('RAM: First KSEG1 entry: 0x' + IntToHex(RAM_MinEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('RAM: First KSEG1 entry: not found');

  if RAM_MaxEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('RAM: Last KSEG1 entry: 0x' + IntToHex(RAM_MaxEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('RAM: Last KSEG1 entry: not found');

  lstFreeMemory.Items.Add('');


  if BFM_MinEntryAddrFound_KSEG0 then
    lstFreeMemory.Items.Add('BFM: First KSEG0 entry: 0x' + IntToHex(BFM_MinEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('BFM: First KSEG0 entry: not found');

  if BFM_MaxEntryAddrFound_KSEG0 then  
    lstFreeMemory.Items.Add('BFM: Last KSEG0 entry: 0x' + IntToHex(BFM_MaxEntryAddr_KSEG0, 8))
  else
    lstFreeMemory.Items.Add('BFM: Last KSEG0 entry: not found');

  if BFM_MinEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('BFM: First KSEG1 entry: 0x' + IntToHex(BFM_MinEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('BFM: First KSEG1 entry: not found');

  if BFM_MaxEntryAddrFound_KSEG1 then
    lstFreeMemory.Items.Add('BFM: Last KSEG1 entry: 0x' + IntToHex(BFM_MaxEntryAddr_KSEG1, 8))
  else
    lstFreeMemory.Items.Add('BFM: Last KSEG1 entry: not found');

  lstFreeMemory.Items.Add('');


  if EBI_MinEntryAddrFound_KSEG2 then
    lstFreeMemory.Items.Add('EBI: First KSEG2 entry: 0x' + IntToHex(EBI_MinEntryAddr_KSEG2, 8))
  else
    lstFreeMemory.Items.Add('EBI: First KSEG2 entry: not found');

  if EBI_MaxEntryAddrFound_KSEG2 then
    lstFreeMemory.Items.Add('EBI: Last KSEG2 entry: 0x' + IntToHex(EBI_MaxEntryAddr_KSEG2, 8))
  else
    lstFreeMemory.Items.Add('EBI: Last KSEG2 entry: not found');

  if EBI_MinEntryAddrFound_KSEG3 then
    lstFreeMemory.Items.Add('EBI: First KSEG3 entry: 0x' + IntToHex(EBI_MinEntryAddr_KSEG3, 8))
  else
    lstFreeMemory.Items.Add('EBI: First KSEG3 entry: not found');

  if EBI_MaxEntryAddrFound_KSEG3 then
    lstFreeMemory.Items.Add('EBI: Last KSEG3 entry: 0x' + IntToHex(EBI_MaxEntryAddr_KSEG3, 8))
  else
    lstFreeMemory.Items.Add('EBI: Last KSEG3 entry: not found');  

  lstFreeMemory.Items.Add('');


  if SQI_MinEntryAddrFound_KSEG2 then
    lstFreeMemory.Items.Add('SQI: First KSEG2 entry: 0x' + IntToHex(SQI_MinEntryAddr_KSEG2, 8))
  else
    lstFreeMemory.Items.Add('SQI: First KSEG2 entry: not found');

  if SQI_MaxEntryAddrFound_KSEG2 then
    lstFreeMemory.Items.Add('SQI: Last KSEG2 entry: 0x' + IntToHex(SQI_MaxEntryAddr_KSEG2, 8))
  else
    lstFreeMemory.Items.Add('SQI: Last KSEG2 entry: not found');

  if SQI_MinEntryAddrFound_KSEG3 then
    lstFreeMemory.Items.Add('SQI: First KSEG3 entry: 0x' + IntToHex(SQI_MinEntryAddr_KSEG3, 8))
  else
    lstFreeMemory.Items.Add('SQI: First KSEG3 entry: not found');

  if SQI_MaxEntryAddrFound_KSEG3 then
    lstFreeMemory.Items.Add('SQI: Last KSEG3 entry: 0x' + IntToHex(SQI_MaxEntryAddr_KSEG3, 8))
  else
    lstFreeMemory.Items.Add('SQI: Last KSEG3 entry: not found');    

  lstFreeMemory.Items.Add('');
  lstFreeMemory.Items.Add('');
  lstFreeMemory.Items.Add('Free words from beginning of memory to first used word or');
  lstFreeMemory.Items.Add('free words from last used word to the end of memory:');
  lstFreeMemory.Items.Add('');

//  if PFM_MinEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('PFM KSEG0: ' + IntToStr((PFM_MinEntryAddr_KSEG0 - FMemTable.ProgramFlashAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.ProgramFlashAddrMin, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('PFM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//  if PFM_MaxEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('PFM KSEG0: ' + IntToStr((FMemTable.ProgramFlashAddrMax + 1 - PFM_MaxEntryAddr_KSEG0) shr 2) + ' free words from 0x' + IntToHex(PFM_MaxEntryAddr_KSEG0 + 4, 8) + ' to end of PFM KSEG0.')
//  else
//    lstFreeMemory.Items.Add('PFM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//
//  if PFM_MinEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('PFM KSEG1: ' + IntToStr((PFM_MinEntryAddr_KSEG1 - $20000000 - FMemTable.ProgramFlashAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.ProgramFlashAddrMin + $20000000, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('PFM KSEG1: No KSEG1 entry found. Can''t compute free words.');                    
//
//  if PFM_MaxEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('PFM KSEG1: ' + IntToStr((FMemTable.ProgramFlashAddrMax + $20000000 + 1 - PFM_MaxEntryAddr_KSEG1) shr 2) + ' free words from 0x' + IntToHex(PFM_MaxEntryAddr_KSEG1 + 4, 8) + ' to end of PFM KSEG1.')
//  else
//    lstFreeMemory.Items.Add('PFM KSEG1: No KSEG1 entry found. Can''t compute free words.');
//
//
//    
//  lstFreeMemory.Items.Add('');
//
//  if RAM_MinEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('RAM KSEG0: ' + IntToStr((RAM_MinEntryAddr_KSEG0 + $20000000 - FMemTable.RAMAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.RAMAddrMin - $20000000, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('RAM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//  if RAM_MaxEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('RAM KSEG0: ' + IntToStr((FMemTable.RAMAddrMax - $20000000 + 1 - RAM_MaxEntryAddr_KSEG0) shr 2) + ' free words from 0x' + IntToHex(RAM_MaxEntryAddr_KSEG0 + 4, 8) + ' to end of RAM KSEG0.')
//  else
//    lstFreeMemory.Items.Add('RAM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//
//  if RAM_MinEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('RAM KSEG1: ' + IntToStr((RAM_MinEntryAddr_KSEG1 - FMemTable.RAMAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.RAMAddrMin, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('RAM KSEG1: No KSEG1 entry found. Can''t compute free words.');                    
//
//  if RAM_MaxEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('RAM KSEG1: ' + IntToStr((FMemTable.RAMAddrMax + 1 - RAM_MaxEntryAddr_KSEG1) shr 2) + ' free words from 0x' + IntToHex(RAM_MaxEntryAddr_KSEG1 + 4, 8) + ' to end of RAM KSEG1.')
//  else
//    lstFreeMemory.Items.Add('RAM KSEG1: No KSEG1 entry found. Can''t compute free words.');
//
//  
//    
//  lstFreeMemory.Items.Add('');
//
//  if BFM_MinEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('BFM KSEG0: ' + IntToStr((BFM_MinEntryAddr_KSEG0 + $20000000 - FMemTable.BootFlashAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.BootFlashAddrMin - $20000000, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('BFM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//  if BFM_MaxEntryAddrFound_KSEG0 then
//    lstFreeMemory.Items.Add('BFM KSEG0: ' + IntToStr((FMemTable.BootFlashAddrMax - $20000000 + 1 - BFM_MaxEntryAddr_KSEG0) shr 2) + ' free words from 0x' + IntToHex(BFM_MaxEntryAddr_KSEG0 + 4, 8) + ' to end of BFM KSEG0.')
//  else
//    lstFreeMemory.Items.Add('BFM KSEG0: No KSEG0 entry found. Can''t compute free words.');
//
//
//  if BFM_MinEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('BFM KSEG1: ' + IntToStr((BFM_MinEntryAddr_KSEG1 - FMemTable.BootFlashAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.BootFlashAddrMin, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('BFM KSEG1: No KSEG1 entry found. Can''t compute free words.');
//
//  if BFM_MaxEntryAddrFound_KSEG1 then
//    lstFreeMemory.Items.Add('BFM KSEG1: ' + IntToStr((FMemTable.BootFlashAddrMax + 1 - BFM_MaxEntryAddr_KSEG1) shr 2) + ' free words from 0x' + IntToHex(BFM_MaxEntryAddr_KSEG1 + 4, 8) + ' to end of BFM KSEG1.')
//  else
//    lstFreeMemory.Items.Add('BFM KSEG1: No KSEG1 entry found. Can''t compute free words.');
//
//
//  lstFreeMemory.Items.Add('');
//
//  if EBI_MinEntryAddrFound_KSEG2 then
//    lstFreeMemory.Items.Add('EBI KSEG2: ' + IntToStr((EBI_MinEntryAddr_KSEG2 - FMemTable.EBIAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.EBIAddrMin, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('EBI KSEG2: No KSEG2 entry found. Can''t compute free words.');
//
//  if EBI_MaxEntryAddrFound_KSEG2 then
//    lstFreeMemory.Items.Add('EBI KSEG2: ' + IntToStr((FMemTable.EBIAddrMax + 1 - EBI_MaxEntryAddr_KSEG2) shr 2) + ' free words from 0x' + IntToHex(EBI_MaxEntryAddr_KSEG2 + 4, 8) + ' to end of EBI KSEG2.')
//  else
//    lstFreeMemory.Items.Add('EBI KSEG2: No KSEG2 entry found. Can''t compute free words.');
//
//
//  if EBI_MinEntryAddrFound_KSEG3 then
//    lstFreeMemory.Items.Add('EBI KSEG3: ' + IntToStr((EBI_MinEntryAddr_KSEG3 - $20000000 - FMemTable.EBIAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.EBIAddrMin + $20000000, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('EBI KSEG3: No KSEG3 entry found. Can''t compute free words.');
//
//  if EBI_MaxEntryAddrFound_KSEG3 then
//    lstFreeMemory.Items.Add('EBI KSEG3: ' + IntToStr((FMemTable.EBIAddrMax + $20000000 + 1 - EBI_MaxEntryAddr_KSEG2) shr 2) + ' free words from 0x' + IntToHex(EBI_MaxEntryAddr_KSEG3 + 4, 8) + ' to end of EBI KSEG3.')
//  else
//    lstFreeMemory.Items.Add('EBI KSEG3: No KSEG3 entry found. Can''t compute free words.');
//
//
//
//  lstFreeMemory.Items.Add('');
//
//  if SQI_MinEntryAddrFound_KSEG2 then
//    lstFreeMemory.Items.Add('SQI KSEG2: ' + IntToStr((SQI_MinEntryAddr_KSEG2 - FMemTable.SQIAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.SQIAddrMin, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('SQI KSEG2: No KSEG2 entry found. Can''t compute free words.');
//
//  if SQI_MaxEntryAddrFound_KSEG2 then
//    lstFreeMemory.Items.Add('SQI KSEG2: ' + IntToStr((FMemTable.SQIAddrMax + 1 - SQI_MaxEntryAddr_KSEG2) shr 2) + ' free words from 0x' + IntToHex(SQI_MaxEntryAddr_KSEG2 + 4, 8) + ' to end of SQI KSEG2.')
//  else
//    lstFreeMemory.Items.Add('SQI KSEG2: No KSEG2 entry found. Can''t compute free words.');
//
//
//  if SQI_MinEntryAddrFound_KSEG3 then
//    lstFreeMemory.Items.Add('SQI KSEG3: ' + IntToStr((SQI_MinEntryAddr_KSEG3 - $20000000 - FMemTable.SQIAddrMin) shr 2) + ' free words from 0x' + IntToHex(FMemTable.SQIAddrMin + $20000000, 8) + ' to first used entry.')
//  else
//    lstFreeMemory.Items.Add('SQI KSEG3: No KSEG3 entry found. Can''t compute free words.');
//
//  if SQI_MaxEntryAddrFound_KSEG3 then
//    lstFreeMemory.Items.Add('SQI KSEG3: ' + IntToStr((FMemTable.SQIAddrMax + $20000000 + 1 - SQI_MaxEntryAddr_KSEG2) shr 2) + ' free words from 0x' + IntToHex(SQI_MaxEntryAddr_KSEG3 + 4, 8) + ' to end of SQI KSEG3.')
//  else
//    lstFreeMemory.Items.Add('SQI KSEG3: No KSEG3 entry found. Can''t compute free words.');
//
//  lstFreeMemory.Items.Add('');
//  lstFreeMemory.Items.Add('');
//  lstFreeMemory.Items.Add('Note 1: Free words from KSEG0 can''t be added up to free words from KSEG1.');
//  lstFreeMemory.Items.Add('             They belong to the same memoy, there are just different address schemes !');
//
//  lstFreeMemory.Items.Add('');
//  lstFreeMemory.Items.Add('Note 2: The mentioned intervals of free words include their endpoints.');
//
//  lstFreeMemory.Items.Add('');
//  lstFreeMemory.Items.Add('Note 3: PFM, BFM, EBI and SQI entries are read from "raw" table. RAM entries are read from "routines" table.');
end;


procedure TfrmMemStatisticsMain.LoadMlk(DeviceName: string);
begin
  ApplyDeviceSettings;  
  FMikroComp.LoadMlk(DeviceName);
end;


procedure TfrmMemStatisticsMain.LoadLST(LstFileFnm: string);
begin
  if LstFileFnm = ExtractFileName(LstFileFnm) then //this may not work if LstFileFnm starts with './' or '.\'
    LstFileFnm := ExtractFilePath(ParamStr(0)) + LstFileFnm;

  vstMemTable.Clear;
  vstRawTable.Clear;
  vstMemTable.RootNodeCount := 0;
  vstRawTable.RootNodeCount := 0;

  vstMemTable.BeginUpdate;
  vstRawTable.BeginUpdate;
  try
    FMikroComp.LoadLst(LstFileFnm);
  finally
    vstMemTable.EndUpdate;
    vstRawTable.EndUpdate;
  end;

  prbLoading.Position := 0;
  StatusBar1.Panels.Items[0].Text := 'Loaded';

  FMemTable.Repaint;
  GenerateTextStatistics;
end;


procedure TfrmMemStatisticsMain.SetDefsFolderToAllCmpInstances;
var
  i: Integer;
  ACmpFrm: TfrmMemStatCompare;
begin
  for i := 0 to ListOfFrmMemStatCompare.Count - 1 do
  begin
    ACmpFrm := ListOfFrmMemStatCompare.Items[i];
    ACmpFrm.DefsFolder := FMikroComp.DefsFolder;
  end;
end;


procedure TfrmMemStatisticsMain.CmpFrmOnChangeDevice(Sender: TfrmMemStatCompare);
var
  res: Integer;
begin
  if (FMemStatOptions.Misc.DefsFolderPriority = dfpLocal) and FileExists(GetLocalDefinitionFileName) then
    Exit; //nothing to change

  SetDefsFolder;
  Sender.DefsFolder := FMikroComp.DefsFolder;

  if ListOfFrmMemStatCompare.Count > 1 then
  begin
    res := MessageBox(Handle, 'Do you want to set this defs folder to all comparison instances?', PChar(Application.Title), MB_ICONINFORMATION + MB_YESNO);

    if res = IDYES then
      SetDefsFolderToAllCmpInstances;
  end;
end;


function TfrmMemStatisticsMain.TableColumnIsVisible(AColIdx: Integer): Boolean;
begin
  if FMemTable.DeviceInfo.GetDeviceSectionCount = 0 then
  begin
    Result := False;
    Exit;
  end;
    
  Result := FMemStatOptions.DevInfoEditArr[AColIdx].VisibleOnTable and
            (FMemTable.DeviceInfo.SectionFoundInDefFile[AColIdx] or FMemStatOptions.DevInfoEditArr[AColIdx].DisplayEvenIfMissingFromDefinition);
end;


function TfrmMemStatisticsMain.HandleOnGetVisibleColumnCount: Integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 0 to Length(FMemStatOptions.DevInfoEditArr) - 1 do
    Result := Result + Ord(TableColumnIsVisible(i));
end;


function TfrmMemStatisticsMain.HandleOnGetColumnVisibility(AColumnIndex: Integer): Boolean;
begin
  try
    Result := TableColumnIsVisible(AColumnIndex);
  except
    on E: Exception do
      raise Exception.Create('Index out of bounds on gtting mem table column visibility. ' + IntToStr(AColumnIndex) + ' / ' + IntToStr(Length(FMemStatOptions.DevInfoEditArr)));
  end;
end;


procedure TfrmMemStatisticsMain.HandleOnCmpWindowDestroy(ACmpWindowHandle: THandle);
begin
  try
    frmSimulatedMem.UpdateAvailableCmpWindowSelection;
  except
    //the window or its content might not be available
  end;
end;


procedure TfrmMemStatisticsMain.HandleOnGetTableMemContent(var AMemEntries: TMemEntryArr);
begin
  FMikroComp.MemTable.GetEntireMemContent(AMemEntries);
end;


procedure TfrmMemStatisticsMain.HandleOnGetTableMemContentFromRaw(var AMemEntries: TMemEntryArr);
begin
  FMikroComp.MemTable.GetEntireMemContentFromRawNames(AMemEntries);
end;

end.
