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



unit MemStatCompareForm;

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
  Dialogs, Menus, VirtualTrees, ImgList, ExtCtrls, StdCtrls, MemStatUtils,
  ExtDlgs, Buttons, MiniMap, DeviceInfo;

type
  TUserNote = record
    Note: string;
    Address: Cardinal;
  end;

  TUserNoteArr = array of TUserNote;

  TRangesOfAddrForTHexContent = array of THexContent;
  TFullHexContent = record
    Ranges: TRangesOfAddrForTHexContent;     //e.g. FullPFMHEX, FullBFMHEX, FullEBIHEX, FullSQIHEX, FullCFGHEX
  end;
  TFullHexContentArr = array of TFullHexContent;

  TfrmMemStatCompare = class;

  TChangeDeviceNotifyEvent = procedure(Sender: TfrmMemStatCompare) of object;
  TOnCmpWindowDestroy = procedure(ACmpWindowHandle: THandle) of object;

  TfrmMemStatCompare = class(TForm)
    mmCmpMain: TMainMenu;
    File1: TMenuItem;
    LoadHEX1: TMenuItem;
    LoadListing1: TMenuItem;
    FileSlot11: TMenuItem;
    FileSlot31: TMenuItem;
    FileSlot41: TMenuItem;
    LoadHEX2: TMenuItem;
    LoadListing2: TMenuItem;
    LoadHEX3: TMenuItem;
    LoadListing3: TMenuItem;
    LoadHEX4: TMenuItem;
    LoadListing4: TMenuItem;
    Compare1: TMenuItem;
    Loadsettingsfromfile1: TMenuItem;
    Savesettingstofile1: TMenuItem;
    SaveAsSettings1: TMenuItem;
    N1: TMenuItem;
    ReloadHEX1: TMenuItem;
    ReloadListing1: TMenuItem;
    ReloadBoth1: TMenuItem;
    imglstHeaderVSTSlots: TImageList;
    N2: TMenuItem;
    ReloadHEX2: TMenuItem;
    ReloadListing2: TMenuItem;
    ReloadBoth2: TMenuItem;
    N3: TMenuItem;
    ReloadHEX3: TMenuItem;
    ReloadListing3: TMenuItem;
    ReloadBoth3: TMenuItem;
    N4: TMenuItem;
    ReloadHEX4: TMenuItem;
    ReloadListing4: TMenuItem;
    ReloadBoth4: TMenuItem;
    lblMinimap: TLabel;
    pnlMiniMap: TPanel;
    OpenDialogHex: TOpenDialog;
    tmrStartup: TTimer;
    CloseHEX1: TMenuItem;
    CloseListing1: TMenuItem;
    CloseHEX2: TMenuItem;
    CloseListing2: TMenuItem;
    CloseHEX3: TMenuItem;
    CloseListing3: TMenuItem;
    CloseHEX4: TMenuItem;
    CloseListing4: TMenuItem;
    SaveDialog1: TSaveDialog;
    pmimgMinimap: TPopupMenu;
    SaveImageToFile: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    cmbCmpViewOptions: TComboBox;
    lblSettingVisibility: TLabel;
    Copyimagetoclipboard1: TMenuItem;
    Recentsettings1: TMenuItem;
    OpenDialogSettings: TOpenDialog;
    SaveDialogSettings: TSaveDialog;
    btnChangeDevice: TButton;
    lblChipName: TLabel;
    lblChipNameText: TLabel;
    pnlUpdatingTable: TPanel;
    tmrHideUpdatingTable: TTimer;
    spdbtnJumpToPrevSection: TSpeedButton;
    spdbtnJumpToNextSection: TSpeedButton;
    lbeSearchHexAddr: TLabeledEdit;
    lbeSearchData: TLabeledEdit;
    tmrSearch: TTimer;
    LoadHEXFromMainWindow1: TMenuItem;
    LoadHEXFromMainWindow2: TMenuItem;
    LoadHEXFromMainWindow3: TMenuItem;
    LoadHEXFromMainWindow4: TMenuItem;
    tmrEditingUserNotes: TTimer;
    lbeSearchNote: TLabeledEdit;
    tmrRepaintMinimapOnSelect: TTimer;
    N5: TMenuItem;
    MenuItem_ShowSimulatedMemory: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    MenuItem_Erase1: TMenuItem;
    MenuItem_Erase2: TMenuItem;
    MenuItem_Erase3: TMenuItem;
    MenuItem_Erase4: TMenuItem;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LoadHEX1Click(Sender: TObject);
    procedure LoadHEX2Click(Sender: TObject);
    procedure LoadHEX3Click(Sender: TObject);
    procedure LoadHEX4Click(Sender: TObject);
    procedure ReloadHEX1Click(Sender: TObject);
    procedure ReloadHEX2Click(Sender: TObject);
    procedure ReloadHEX3Click(Sender: TObject);
    procedure ReloadHEX4Click(Sender: TObject);
    procedure tmrStartupTimer(Sender: TObject);
    procedure pnlMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlMiniMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinimapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgMinimapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlMiniMapResize(Sender: TObject);
    procedure CloseHEX1Click(Sender: TObject);
    procedure CloseHEX2Click(Sender: TObject);
    procedure CloseHEX3Click(Sender: TObject);
    procedure CloseHEX4Click(Sender: TObject);
    procedure SaveImageToFileClick(Sender: TObject);
    procedure cmbCmpViewOptionsChange(Sender: TObject);
    procedure Copyimagetoclipboard1Click(Sender: TObject);
    procedure Loadsettingsfromfile1Click(Sender: TObject);
    procedure Savesettingstofile1Click(Sender: TObject);
    procedure SaveAsSettings1Click(Sender: TObject);
    procedure Compare1Click(Sender: TObject);
    procedure btnChangeDeviceClick(Sender: TObject);
    procedure tmrHideUpdatingTableTimer(Sender: TObject);
    procedure spdbtnJumpToPrevSectionClick(Sender: TObject);
    procedure spdbtnJumpToNextSectionClick(Sender: TObject);
    procedure lbeSearchHexAddrChange(Sender: TObject);
    procedure lbeSearchDataChange(Sender: TObject);
    procedure tmrSearchTimer(Sender: TObject);
    procedure LoadHEXFromMainWindow1Click(Sender: TObject);
    procedure LoadHEXFromMainWindow2Click(Sender: TObject);
    procedure LoadHEXFromMainWindow3Click(Sender: TObject);
    procedure LoadHEXFromMainWindow4Click(Sender: TObject);
    procedure tmrEditingUserNotesTimer(Sender: TObject);
    procedure lbeSearchNoteChange(Sender: TObject);
    procedure tmrRepaintMinimapOnSelectTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vstSlotCmpBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstSlotCmpAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      {$IFDEF FPC}const{$ENDIF} CellRect: TRect);
    procedure vstSlotCmpBeforePaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure vstSlotCmpClick(Sender: TObject);
    procedure vstSlotCmpDblClick(Sender: TObject);
    procedure vstSlotCmpEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure vstSlotCmpEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vstSlotCmpGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstSlotCmpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstSlotCmpKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstSlotCmpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vstSlotCmpNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; {$IFDEF FPC}const{$ENDIF} NewText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstSlotCmpBeforeItemPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; {$IFDEF FPC}const{$ENDIF} ItemRect: TRect;
      var CustomDraw: Boolean);
    procedure MenuItem_ShowSimulatedMemoryClick(Sender: TObject);
    procedure MenuItem_ClearSelectedUserNotesClick(Sender: TObject);
    procedure MenuItem_ClearSimCmdsFromSelectedUserNotesClick(Sender: TObject);
    procedure MenuItem_Erase1Click(Sender: TObject);
    procedure MenuItem_Erase2Click(Sender: TObject);
    procedure MenuItem_Erase3Click(Sender: TObject);
    procedure MenuItem_Erase4Click(Sender: TObject);
  private
    { Private declarations }
    FMemStatColorOptions: TMemStatColorOptions;
    FMemStatMiscOptions: TMemStatMiscOptions;

    FSlot1: TFileSlot;
    FSlot2: TFileSlot;
    FSlot3: TFileSlot;
    FSlot4: TFileSlot;
    FAllSlots: PFileSlotArr;

    FUserNoteArr: TUserNoteArr;
    FUserNotesModified: Boolean;
    FEditingText: string;
    FHitInfo: THitInfo;

    FFirstSecondCmpColor: TColor;
    FSecondThirdCmpColor: TColor;
    FThirdFourthCmpColor: TColor;
    FFirstSecondCmpSelectedColor: TColor;
    FSecondThirdCmpSelectedColor: TColor;
    FThirdFourthCmpSelectedColor: TColor;

    FirstFileEntryChartSelectedColor: TColor;
    SecondFileEntryChartSelectedColor: TColor;
    ThirdFileEntryChartSelectedColor: TColor;
    FourthFileEntryChartSelectedColor: TColor;

    FCachedSlotEntryColorTableArr: TAllSlotsColorArr;

    FCmdlineLstFile: TFileName;

    FSettingFilename: TFileName;
    FDefsFolder: TFileName;

    FChipName: string;
    
    FOnChangeDevice: TChangeDeviceNotifyEvent;
    FOnCmpWindowDestroy: TOnCmpWindowDestroy;

    FCachedSections: TSectionArr;
    FCachedSectionIndex: Integer;

    FMiniMap: TMiniMap;
    FDeviceInfo: TDeviceInfo;

    vstSlotCmp: TVirtualStringTree;
    pmVST: TPopupMenu;

    procedure DoOnCmpWindowDestroy(ACmpWindowHandle: THandle);

    procedure CreateRemainingComponents;
    function IndexOfAddressInUserNotes(AAddress: Cardinal): Integer;
    function GetUserNoteAtAddress(AAddress: Cardinal): string;
    procedure UpdateUserNote(AAddress: Cardinal; ANote: string);

    procedure SetMemStatColorOptions(Value: TMemStatColorOptions);
    procedure SetMemStatMiscOptions(Value: TMemStatMiscOptions);

    procedure SetChipName(Value: string);

    procedure SearchInSlotDataTable(AAddressHex, AData, ANote: string);

    procedure CopyDataFromFileSlot(var FileSlot: TFileSlot; ADevSectionIndex: Integer; var ARangesOfHexContent: TRangesOfAddrForTHexContent; var DisplayWarning: Boolean; out DisplayAddr, DisplayLength: DWord);
    procedure ConvertDecodedHexToFullMemory(var FileSlot: TFileSlot);
    procedure DrawMiniMap;
    procedure UpdateMiniMapColorOptions;
    procedure SetVisibleEntries;

    function GetVstSlotDataLine(Node: PVirtualNode; var ASections: TSectionArr): string;
    function VstSlotData_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;

    function GetLstFileNameFromCmdLine: string;
    procedure LoadHexFromMainWindow(var AFileSlot: TFileSlot; ASlotIndex: Integer);
    procedure CloseHex(var AFileSlot: TFileSlot; ASlotIndex: Integer);
    procedure CloseAllHexFiles;
    procedure LoadHex(Sender: TObject; var AFileSlot: TFileSlot; ASlotIndex: Integer);
    procedure ReloadHex(Sender: TObject; AFileSlot: TFileSlot; ASlotIndex: Integer);
    procedure EraseSlot(var AFileSlot: TFileSlot; ASlotIndex: Integer);

    procedure MinimapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MinimapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    function AllSlotsAreEmpty: Boolean;

    function GetCmpFocusedSelectionColor: TColor;
    function GetCmpUnfocusedSelectionColor: TColor;
    function GetCmpSelectionColor: TColor;
    procedure ComputeCmpColors;

    procedure LoadComparisonSettings;
    procedure SaveComparisonSettings;

    function BuildChipNameMenu(var SelectedItem: Integer): string;
    function GetIndexOfDeviceSectionByDefName(SectionName: string): Integer;
    procedure GetDeviceSectionAddrRanges(var AAllSections: TSectionArr);
    procedure SetDeviceSectionAddrRanges(ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
    procedure LoadMlk(DeviceName: string);
    procedure CreateMinimap;
    procedure SetMinimapColorOptions;
  public
    { Public declarations }

    function GetSlotCount: Integer;
    procedure LoadExternalHex(ASlotIdex: Integer; AFromMainWindow: Boolean = False);

    procedure EraseMemoryChunk(ASlotIdex: Integer; AStartAddress, ASize: Cardinal; AUserNote: string = '');  //A chunk is usually the same size as an erase page size. However, this class doesn't have to know such details.
    procedure WriteMemory(ASlotIdex: Integer; AStartAddress: Cardinal; var AData: array of Byte; AUserNote: string = '');
    procedure HighlightMemoryChunk(ASlotIdex: Integer; AStartAddress, ASize: Cardinal);   //A chunk can be the same size as an erase page size or a write row size.
    procedure HighlightSlotAsConnected(ASlotIdex: Integer);

    property MemStatColorOptions: TMemStatColorOptions read FMemStatColorOptions write SetMemStatColorOptions;
    property MemStatMiscOptions: TMemStatMiscOptions read FMemStatMiscOptions write SetMemStatMiscOptions;

    property CmdlineLstFile: TFileName read FCmdlineLstFile write FCmdlineLstFile;
    property DefsFolder: TFileName read FDefsFolder write FDefsFolder;

    property ChipName: string read FChipName write SetChipName;
    property DeviceInfo: TDeviceInfo read FDeviceInfo;

    property OnChangeDevice: TChangeDeviceNotifyEvent read FOnChangeDevice write FOnChangeDevice;
    property OnCmpWindowDestroy: TOnCmpWindowDestroy write FOnCmpWindowDestroy;
  end;

  TfrmMemStatCompareList = class(TList)
  protected
    function Get(Index: Integer): TfrmMemStatCompare;
    procedure Put(Index: Integer; Item: TfrmMemStatCompare);
  public
    function Add(Item: TfrmMemStatCompare): Integer;
    property Items[Index: Integer]: TfrmMemStatCompare read Get write Put; default;
  end;

const
  CExt = '.memcmp';
  CWriteWord_UserNote = 'WrWord';
  CWriteRow_UserNote = 'WrRow';
  CErase_UserNote = 'Erase';


var
  ListOfFrmMemStatCompare: TfrmMemStatCompareList;

implementation

{$IFDEF FPC}
  {$R *.frm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}

uses
  MikroStuff, ClipBrd, IniFiles, DevicesForm, Math, DefParser, SimulatedMemForm;

const
  CColumnIdx_Index = 0;
  CColumnIdx_Mem = 1;
  CColumnIdx_Address_Hex = 2;
  CColumnIdx_Address_Dec = 3;
  CColumnIdx_Size = 4;
  CColumnIdx_Slot1_Data = 5;
  CColumnIdx_Slot2_Data = 6;
  CColumnIdx_Slot3_Data = 7;
  CColumnIdx_Slot4_Data = 8;
  CColumnIdx_User_Notes = 9;
  

function TfrmMemStatCompareList.Get(Index: Integer): TfrmMemStatCompare;
begin
  Result := TfrmMemStatCompare(inherited Get(Index));
end;


procedure TfrmMemStatCompareList.Put(Index: Integer; Item: TfrmMemStatCompare);
begin
  inherited Put(Index, Pointer(Item));
end;


function TfrmMemStatCompareList.Add(Item: TfrmMemStatCompare): Integer;
begin
  Result := inherited Add(Pointer(Item));
end;

  
procedure TfrmMemStatCompare.SaveImageToFileClick(Sender: TObject);
var
  s: string;
begin
  if SavePictureDialog1.Execute then
  begin
    s := SavePictureDialog1.FileName;
    s := Copy(s, Length(s) - 3, 4);
    
    if UpperCase(s) <> '.BMP' then
      FMiniMap.SaveToFile(SavePictureDialog1.FileName + '.bmp')
    else
      FMiniMap.SaveToFile(SavePictureDialog1.FileName );
  end;
end;


procedure TfrmMemStatCompare.UpdateMiniMapColorOptions;
var
  i: Integer;
begin
  if FMiniMap = nil then
    Exit;

  //background colors
  FMiniMap.BkColor1 := FMemStatColorOptions.FirstFileEntryChart;
  FMiniMap.BkColor2 := FMemStatColorOptions.SecondFileEntryChart;
  FMiniMap.BkColor3 := FMemStatColorOptions.ThirdFileEntryChart;
  FMiniMap.BkColor4 := FMemStatColorOptions.FourthFileEntryChart;

  FMiniMap.OverlapColor := FMemStatColorOptions.Overlap;
  FMiniMap.UseOverlapColor := FMemStatColorOptions.UseOverlapColor;

  FMiniMap.SetSetEntryColorTable(Length(FMemStatColorOptions.EntryColorTableArr));
  for i := 0 to Length(FMemStatColorOptions.EntryColorTableArr) - 1 do
    FMiniMap.SetEntryColorTable(i, FMemStatColorOptions.EntryColorTableArr[i]);
end;


procedure TfrmMemStatCompare.SetMemStatColorOptions(Value: TMemStatColorOptions);
begin
  if FMiniMap = nil then
    CreateMinimap;

  if not CompareTwoMemStatColorOptions(FMemStatColorOptions, Value) then
  begin
    FMemStatColorOptions := Value;
    SetMinimapColorOptions;
    ComputeCmpColors;

    UpdateMiniMapColorOptions;

    if Visible then
    begin
      vstSlotCmp.Repaint;
      DrawMiniMap;
    end;
  end;
end;


procedure TfrmMemStatCompare.SetMemStatMiscOptions(Value: TMemStatMiscOptions);
begin
  FMemStatMiscOptions := Value;

  if Visible then
  begin
    vstSlotCmp.Repaint;
    DrawMiniMap;
  end;

  vstSlotCmp.ShowHint := FMemStatMiscOptions.DisplayTableHints;
end;


function TfrmMemStatCompare.GetIndexOfDeviceSectionByDefName(SectionName: string): Integer;
begin
  Result := FDeviceInfo.GetIndexOfDeviceSectionByDefName(SectionName);
end;


procedure TfrmMemStatCompare.GetDeviceSectionAddrRanges(var AAllSections: TSectionArr);
begin
  FDeviceInfo.GetDeviceSectionAddrRanges(AAllSections);
end;



procedure TfrmMemStatCompare.SetDeviceSectionAddrRanges(ASectionIndex: Integer; var AAddrRanges: TDefSectionAddrRangeArr; TranslationValue: DWord; ATranslationOperation: TAddressTranslationOperation);
begin
  FDeviceInfo.SetDeviceSectionAddrRanges(ASectionIndex, AAddrRanges, TranslationValue, ATranslationOperation);
end;


procedure TfrmMemStatCompare.LoadMlk(DeviceName: string);
var
  AStringList: TStringList;
  MlkFileName: string;
  i: Integer;
  s: string;

  AddrRange: TDefSectionAddrRangeArr;
  AddressRanges: TDefSectionAddrRangeArrArr;
  DefType: TMCUDef;
  SectionIndex: Integer;
  MemTranslationInfo: TMemoryTranslationInfo;
begin
  if DeviceName = '' then
  begin
    MessageBox(Handle, PChar('Device name is not set. The program will use ' + FDeviceInfo.DefaultChipName + '.'), PChar(Application.Title), MB_ICONWARNING);
    Exit;
  end;

  MlkFileName := GetDefinitionFileName(FDefsFolder, DeviceName, FMemStatMiscOptions.DefsFolderPriority);

  if not FileExists(MlkFileName) then
  begin
    MessageBox(Handle, PChar('Please set the "Defs" folder. The program will use ' + FDeviceInfo.DefaultChipName + ' settings.'), PChar(Application.Title), MB_ICONWARNING);

    if FDeviceInfo.GetDeviceSectionCount = 0 then
      raise Exception.Create('Default address ranges have to be externally set.');

    Exit;
  end;

  if UpperCase(MlkFileName) = UpperCase(GetLocalDefinitionFileName) then
  begin
    //similar code in LoadMlk from MikroStuff.pas
    AStringList := TStringList.Create;
    try
      for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
        AStringList.Add(FDeviceInfo.GetDeviceDefSectionNameByIndex(i));

      GetDeviceMemoryContentFromLocalFile(DeviceName, AStringList, AddressRanges);

      for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do      //this for loop looks like the next one, but it uses all mem ranges
      begin
        SectionIndex := FDeviceInfo.GetIndexOfDeviceSectionByDefName(AStringList.Strings[i]);
        if SectionIndex <> -1 then
        begin
          MemTranslationInfo := FDeviceInfo.MemoryTranslationInfo[i];
          FDeviceInfo.SetDeviceSectionAddrRanges(SectionIndex, AddressRanges[i], MemTranslationInfo.Value, MemTranslationInfo.Operation);
        end;
      end;
    finally
      AStringList.Free;
    end;
  end
  else
  begin
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

      for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
        if GetDefAddresses(DefType, s, FDeviceInfo.GetDeviceDefSectionNameByIndex(i), AddrRange) then
        begin
          SectionIndex := GetIndexOfDeviceSectionByDefName(FDeviceInfo.GetDeviceDefSectionNameByIndex(i));
          if SectionIndex <> -1 then
          begin
            MemTranslationInfo := FDeviceInfo.MemoryTranslationInfo[i];
            SetDeviceSectionAddrRanges(SectionIndex, AddrRange, MemTranslationInfo.Value, MemTranslationInfo.Operation);
          end;
        end;
    finally
      AStringList.Free;
    end;
  end;
end;


function TfrmMemStatCompare.BuildChipNameMenu(var SelectedItem: Integer): string;
var
  AStringList: TStringList;
  ASearchRec: TSearchRec;
  SearchResult: Integer;
  i: Integer;
  s: string;
begin
  if (FMemStatMiscOptions.DefsFolderPriority = dfpLocal) and FileExists(GetLocalDefinitionFileName) then
  begin
    AStringList := TStringList.Create;
    try
      GetListOfDevicesFromLocalFile(AStringList);
      AStringList.Sort;
      Result := AStringList.Text;
      SelectedItem := AStringList.IndexOf(FChipName);
    finally
      AStringList.Free;
    end;
    
    Exit;
  end;

  if FDefsFolder = '' then
  begin
    Result := '';
    SelectedItem := -1;
    Exit;
  end;

  AStringList := TStringList.Create;
  try
    AddTrailingSlash(FDefsFolder);

    SearchResult := FindFirst(FDefsFolder + '*.mlk', faAnyFile, ASearchRec);
    while SearchResult = 0 do
    begin
      if ('.' <> ASearchRec.Name) and ('..' <> ASearchRec.Name) and (UpperCase(ExtractFileExt(ASearchRec.Name)) = '.MLK') then
      begin //dir.Attr=16 - folder
        if not IsDir(ASearchRec.Attr) then
          AStringList.Add(ASearchRec.Name);//folders
      end;
      SearchResult := FindNext(ASearchRec);
    end;

    SearchResult := FindFirst(FDefsFolder + '*.json', faAnyFile, ASearchRec);
    while SearchResult = 0 do
    begin
      if ('.' <> ASearchRec.Name) and ('..' <> ASearchRec.Name) and (UpperCase(ExtractFileExt(ASearchRec.Name)) = '.JSON') then
      begin //dir.Attr=16 - folder
        if not IsDir(ASearchRec.Attr) then
          AStringList.Add(ASearchRec.Name);//folders
      end;
      SearchResult := FindNext(ASearchRec);
    end;

    AStringList.Sort;

    for i := 0 to AStringList.Count - 1 do
    begin
      s := FDeviceInfo.GetReplacedDevPrefix(AStringList.Strings[i]);

      if UpperCase(ExtractFileExt(s)) = '.MLK' then
        Delete(s, Length(s) - 3, 4)
      else
        if UpperCase(ExtractFileExt(s)) = '.JSON' then
          Delete(s, Length(s) - 4, 5);

      AStringList.Strings[i] := s;
    end;

    Result := AStringList.Text;
    SelectedItem := AStringList.IndexOf(FChipName);
  finally
    AStringList.Free;
  end;
end;


procedure TfrmMemStatCompare.btnChangeDeviceClick(Sender: TObject);
var
  AList: string;
  Selected: Integer;
  NewChipName: string;
  OldSections: TSectionArr;
  Res: Integer;
begin
  Selected := -2;
  AList := BuildChipNameMenu(Selected);

  if Selected = -1 then
  begin
    if Assigned(OnChangeDevice) then
      OnChangeDevice(Self);

    AList := BuildChipNameMenu(Selected);
    if Selected = -1 then
    begin
      MessageBox(Handle, PChar('Can''t find "' + FChipName + '" in the list of devices.'), PChar(Application.Title), MB_ICONERROR);
    end;
  end;

  Res := GetNewDevice(AList, Selected, NewChipName);
  if Res <> Selected then
    if NewChipName <> '' then
    begin
      FChipName := NewChipName;
      lblChipName.Caption := FChipName;

      GetDeviceSectionAddrRanges(OldSections);
      LoadMlk(FChipName);

      if not FDeviceInfo.HasSameSectionContent(OldSections) then
      begin
        SetLength(FUserNoteArr, 0);
        CloseAllHexFiles;
      end;
    end;
end;


function TfrmMemStatCompare.AllSlotsAreEmpty: Boolean;
begin
  Result := (Length(FSlot1.FullHEX) = 0) and (Length(FSlot2.FullHEX) = 0) and (Length(FSlot3.FullHEX) = 0) and (Length(FSlot4.FullHEX) = 0);
end;


procedure TfrmMemStatCompare.CloseHex(var AFileSlot: TFileSlot; ASlotIndex: Integer);
begin
  AFileSlot.HasHex := False;
  AFileSlot.FileNameHex := '';
  SetLength(AFileSlot.DecodedHEX, 0);
  SetLength(AFileSlot.FullHEX, 0);
  SetLength(AFileSlot.Sections, 0);

  InitSlotSectionLengths(AFileSlot);

  case ASlotIndex of
    1: vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot1_Data].Text := 'Slot1 Data';
    2: vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot2_Data].Text := 'Slot2 Data';
    3: vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot3_Data].Text := 'Slot3 Data';
    4: vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot4_Data].Text := 'Slot4 Data';
    else
      raise Exception.Create('Slot not implemented at index: ' + IntToStr(ASlotIndex));
  end;

  if AllSlotsAreEmpty then
  begin
    vstSlotCmp.RootNodeCount := 0;
    SetLength(FUserNoteArr, 0);
  end;

  SetVisibleEntries;
  DrawMiniMap;
end;


procedure TfrmMemStatCompare.CloseAllHexFiles;
begin
  CloseHex(FSlot1, 1);
  CloseHex(FSlot2, 2);
  CloseHex(FSlot3, 3);
  CloseHex(FSlot4, 4);
end;


procedure TfrmMemStatCompare.CloseHEX1Click(Sender: TObject);
begin
  CloseHex(FSlot1, 1);
end;


procedure TfrmMemStatCompare.CloseHEX2Click(Sender: TObject);
begin
  CloseHex(FSlot2, 2);
end;


procedure TfrmMemStatCompare.CloseHEX3Click(Sender: TObject);
begin
  CloseHex(FSlot3, 3);
end;


procedure TfrmMemStatCompare.CloseHEX4Click(Sender: TObject);
begin
  CloseHex(FSlot4, 4);
end;


procedure TfrmMemStatCompare.cmbCmpViewOptionsChange(Sender: TObject);
begin
  if vstSlotCmp.Visible then
    SetVisibleEntries;
end;


procedure TfrmMemStatCompare.CopyDataFromFileSlot(var FileSlot: TFileSlot; ADevSectionIndex: Integer; var ARangesOfHexContent: TRangesOfAddrForTHexContent; var DisplayWarning: Boolean; out DisplayAddr, DisplayLength: DWord);
var
  i, j: Integer;
  Addr: DWord;
  DevShiftAmount, DevPointerSize: Byte;
  MemRange: TDefSectionAddrRange;
begin
  DevShiftAmount := FDeviceInfo.DevShiftAmount;
  DevPointerSize := FDeviceInfo.DevPointerSize;

  if Length(ARangesOfHexContent) = 0 then  /////////////////////////////////////////////////////////// this should not be needed if GetAddressRangesCountFromSection returns the proper result
    Exit;
             ///////////////////////////// to verify indexing: ARangesOfHexContent[j][Addr].HData
  for i := 0 to Length(FileSlot.DecodedHEX) - 1 do
    for j := 0 to FDeviceInfo.GetAddressRangesCountFromSection(ADevSectionIndex) - 1 do
    begin
      MemRange := FDeviceInfo.GetAddressRangesByIndex(ADevSectionIndex, j);
    
      if (FileSlot.DecodedHEX[i].HAddr >= MemRange.MinAddr) and (FileSlot.DecodedHEX[i].HAddr <= MemRange.MaxAddr) then
      begin
        Addr := (FileSlot.DecodedHEX[i].HAddr - MemRange.MinAddr) shr DevShiftAmount;
        if Addr < DWord(Length(ARangesOfHexContent[j])) + DevPointerSize then
          ARangesOfHexContent[j][Addr].HData := FileSlot.DecodedHEX[i].HData   /////////////////crash here if Length(ARangesOfHexContent) = 0, although GetAddressRangesCountFromSection returns something else
        else
        begin
          DisplayWarning := True;
          DisplayAddr := Addr shl DevShiftAmount + MemRange.MinAddr;
          DisplayLength := DWord(Length(ARangesOfHexContent[j])) shl DevShiftAmount + MemRange.MinAddr;
        end;
      end;
    end;
end;


procedure GetConcatenatedHexContentRanges(var AllRanges: TRangesOfAddrForTHexContent; var ResultedHexContent: THexContent);
var
  i, j, n: Integer;
begin
  n := 0;
  for i := 0 to Length(AllRanges) - 1 do
    n := n + Length(AllRanges[i]);

  SetLength(ResultedHexContent, n);

  n := 0;
  for i := 0 to Length(AllRanges) - 1 do
    for j := 0 to Length(AllRanges[i]) - 1 do
    begin
      ResultedHexContent[n] := AllRanges[i][j];
      Inc(n);
    end;
end;


procedure TfrmMemStatCompare.ConvertDecodedHexToFullMemory(var FileSlot: TFileSlot);
var
  i, j, k, n: Integer;
  AllFullHexContents: TFullHexContentArr;  //same length as FDeviceSections
  //NewLen: Cardinal;
  DisplayWarning: Boolean;
  DisplayAddr: DWord;
  DisplayLength: DWord;
  Msg: string;
  ConcatenatedHexContent: THexContent;
  RangeLen: DWord;
  DevShiftAmount: Byte;
  MemRange: TDefSectionAddrRange;
begin
  DisplayWarning := False;
  DevShiftAmount := FDeviceInfo.DevShiftAmount;

  SetLength(AllFullHexContents, FDeviceInfo.GetDeviceSectionCount);   //e.g.: PFM, BFM, CFG, EBI, SQI
  for i := 0 to Length(AllFullHexContents) - 1 do
  begin
    SetLength(AllFullHexContents[i].Ranges, FDeviceInfo.GetAddressRangesCountFromSection(i));

    for j := 0 to Length(AllFullHexContents[i].Ranges) - 1 do
    begin
      MemRange := FDeviceInfo.GetAddressRangesByIndex(i, j);
      SetLength(AllFullHexContents[i].Ranges[j], (MemRange.MaxAddr - MemRange.MinAddr + 1) shr DevShiftAmount);
    end;
  end;

  DisplayAddr := 0;
  DisplayLength := 0;

  for i := 0 to Length(AllFullHexContents) - 1 do  // e.g.: PFM, BFM, CFG, EBI, SQI
    for j := 0 to Length(AllFullHexContents[i].Ranges) - 1 do   // BFM0, BFM1, BFM2    - this array is usually one item long, but for PIC32MZ, this can have multiple items for the BFM ranges
    begin
      MemRange := FDeviceInfo.GetAddressRangesByIndex(i, j);

      for k := 0 to Length(AllFullHexContents[i].Ranges[j]) - 1 do  // entries of (address, data)
      begin
        AllFullHexContents[i].Ranges[j][k].HData := $FFFFFFFF;
        AllFullHexContents[i].Ranges[j][k].HAddr := MemRange.MinAddr + DWord(k shl DevShiftAmount);
      end;
    end;

  for i := 0 to Length(AllFullHexContents) - 1 do   //same length as FDeviceSections
  begin
    try
      CopyDataFromFileSlot(FileSlot, i, AllFullHexContents[i].Ranges, DisplayWarning, DisplayAddr, DisplayLength);
    except ////////////////////////////////////////////////////////////////// this should be fixed
    end;
  end;

  SetLength(FileSlot.Sections, FDeviceInfo.GetDeviceSectionCount);
  SetLength(FMemStatColorOptions.EntryColorTableArr, FDeviceInfo.GetDeviceSectionCount);

  for i := 0 to FDeviceInfo.GetDeviceSectionCount - 1 do
  begin
    RangeLen := FDeviceInfo.GetRangesLengthsCountFromSection(i);
    SetLength(FileSlot.Sections[i].AddrRanges, RangeLen);

    for j := 0 to Length(FileSlot.Sections[i].AddrRanges) - 1 do
      FileSlot.Sections[i].AddrRanges[j].Len := Length(AllFullHexContents[i].Ranges[j]);
  end;

  for i := 0 to Length(FileSlot.Sections) - 1 do
  begin
    FileSlot.Sections[i].DisplayName := FDeviceInfo.GetDeviceDisplaySectionNameByIndex(i);
    FileSlot.Sections[i].LongDisplayName := FDeviceInfo.GetDeviceDisplaySectionLongNameByIndex(i);
    FileSlot.Sections[i].DefName := FDeviceInfo.GetDeviceDefSectionNameByIndex(i);
  end;
  

//  NewLen := FDeviceInfo.GetSumOfAllSectionLengths;
//  SetLength(FileSlot.FullHEX, NewLen);

  n := 0;

  for i := 0 to Length(AllFullHexContents) - 1 do           ////////////////////////////////////////////  AV somewhere here
  begin
    GetConcatenatedHexContentRanges(AllFullHexContents[i].Ranges, ConcatenatedHexContent);

    //if Length(ConcatenatedHexContent) - 1 + n > Length(FileSlot.FullHEX) then     /////////// remove this line if the bug is fixed by reading the proper sections from MemTable when creating this form
    if Length(AllFullHexContents[i].Ranges) <> Length(FileSlot.Sections[i].AddrRanges) then    
      raise Exception.Create('Some of the memory ranges may be missing for section "' + FDeviceInfo.GetDeviceDefSectionNameByIndex(i) + '". This may happen when loading a hex file for a different chip than the initial one.');

    SetLength(FileSlot.FullHEX, Length(FileSlot.FullHEX) + Length(ConcatenatedHexContent)); //////////////////////  reallocating FileSlot.FullHEX here, instead of preallocating above
    for k := 0 to Length(ConcatenatedHexContent) - 1 do
      FileSlot.FullHEX[k + n] := ConcatenatedHexContent[k];   ////////////////////////////////////////////  AV here  //FullHEX is not long enough to be indexed with k+n
    n := n + Length(ConcatenatedHexContent);
  end;

  for i := 0 to Length(AllFullHexContents) - 1 do
  begin
    for j := 0 to Length(AllFullHexContents[i].Ranges) - 1 do
      SetLength(AllFullHexContents[i].Ranges[j], 0);

    SetLength(AllFullHexContents[i].Ranges, 0);
  end;

  SetLength(ConcatenatedHexContent, 0);
  SetLength(AllFullHexContents, 0);


  for i := 0 to Length(FileSlot.FullHEX) - 1 do
  begin
    FileSlot.FullHEX[i].HAddrStr := IntToHex(FileSlot.FullHEX[i].HAddr, 8);   //for fast searching
    FileSlot.FullHEX[i].HDataStr := IntToHex(FileSlot.FullHEX[i].HData, 8);   //for fast searching
  end;

  pnlUpdatingTable.Show;
  pnlUpdatingTable.Repaint;

  try
    try
      vstSlotCmp.BeginUpdate;
      try
//        if vstSlotCmp.RootNodeCount <> NewLen then
//          vstSlotCmp.RootNodeCount := NewLen;

        if Integer(vstSlotCmp.RootNodeCount) <> Length(FileSlot.FullHEX) then
          vstSlotCmp.RootNodeCount := Length(FileSlot.FullHEX);
      finally
        vstSlotCmp.EndUpdate;
      end;
    finally
      tmrHideUpdatingTable.Enabled := True;
    end;
  except
    on E: Exception do
      MessageBox(Handle, PChar('Exception on updating tables: '#13#10 + E.Message), PChar(Application.Title), MB_ICONERROR);
  end;

  if DisplayWarning then
  begin
    Msg := 'The device, from file:' +
           #13#10 +
           FCmdlineLstFile +
           '  (command line file)' +
           #13#10 +
           'has a smaller memory than the device from the file:' +
           #13#10 +
           FileSlot.FileNameHex +
           #13#10 +
           'The displayed file will be truncated. Please run this application with correct command line parameters.' +
           #13#10 + #13#10 +
           'Max address from lst file: 0x' + IntToHex(DisplayLength, 8) +
           #13#10 +
           'Out of range address from hex file: 0x' + IntToHex(DisplayAddr, 8)
           ;
    MessageBox(Handle, PChar(Msg), PChar(Application.Title), MB_ICONWARNING);
  end;
end;


procedure TfrmMemStatCompare.Copyimagetoclipboard1Click(Sender: TObject);
begin
  FMiniMap.CopyToClipboard;
end;


procedure TfrmMemStatCompare.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
begin
  Action := caFree;
  for i := 0 to ListOfFrmMemStatCompare.Count - 1 do
    if ListOfFrmMemStatCompare.Items[i] = Self then
    begin
      ListOfFrmMemStatCompare.Delete(i);
      DoOnCmpWindowDestroy(Self.Handle);
      Break;
    end;
end;


procedure TfrmMemStatCompare.CreateRemainingComponents;
var
  NewColum: TVirtualTreeColumn;
  TempMenuItem: TMenuItem;
begin
  vstSlotCmp := TVirtualStringTree.Create(Self);
  vstSlotCmp.Parent := Self;

  vstSlotCmp.Left := 0;
  vstSlotCmp.Top := 2;
  vstSlotCmp.Width := 1033;
  vstSlotCmp.Height := 503;
  vstSlotCmp.Anchors := [akLeft, akTop, akRight, akBottom];
  vstSlotCmp.Header.AutoSizeIndex := 0;
  vstSlotCmp.Header.DefaultHeight := 46;
  vstSlotCmp.Header.Font.Charset := DEFAULT_CHARSET;
  vstSlotCmp.Header.Font.Color := clWindowText;
  vstSlotCmp.Header.Font.Height := -11;
  vstSlotCmp.Header.Font.Name := 'Tahoma';
  vstSlotCmp.Header.Font.Style := [];
  vstSlotCmp.Header.Height := 46;
  vstSlotCmp.Header.Options := [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize];
  vstSlotCmp.Header.SortColumn := 5;
  vstSlotCmp.Header.Style := hsFlatButtons;
  vstSlotCmp.Indent := 0;
  vstSlotCmp.ParentShowHint := False;
  vstSlotCmp.ScrollBarOptions.AlwaysVisible := True;
  vstSlotCmp.ShowHint := True;
  vstSlotCmp.TabOrder := 7;
  vstSlotCmp.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnEdit];
  vstSlotCmp.TreeOptions.MiscOptions := [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning];
  vstSlotCmp.TreeOptions.PaintOptions := [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines];
  vstSlotCmp.TreeOptions.SelectionOptions := [toFullRowSelect, toMultiSelect];
  vstSlotCmp.OnAfterCellPaint := vstSlotCmpAfterCellPaint;
  vstSlotCmp.OnBeforeCellPaint := vstSlotCmpBeforeCellPaint;
  vstSlotCmp.OnBeforeItemPaint := vstSlotCmpBeforeItemPaint;
  vstSlotCmp.OnBeforePaint := vstSlotCmpBeforePaint;
  vstSlotCmp.OnClick := vstSlotCmpClick;
  vstSlotCmp.OnDblClick := vstSlotCmpDblClick;
  vstSlotCmp.OnEdited := vstSlotCmpEdited;
  vstSlotCmp.OnEditing := vstSlotCmpEditing;
  vstSlotCmp.OnGetText := vstSlotCmpGetText;
  vstSlotCmp.OnKeyDown := vstSlotCmpKeyDown;
  vstSlotCmp.OnKeyUp := vstSlotCmpKeyUp;
  vstSlotCmp.OnMouseDown := vstSlotCmpMouseDown;
  vstSlotCmp.OnNewText := vstSlotCmpNewText;

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 60;
  NewColum.Position := 0;
  NewColum.Width := 60;
  NewColum.Text := 'Index';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 45;
  NewColum.Position := 1;
  NewColum.Width := 45;
  NewColum.Text := 'Mem';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 90;
  NewColum.Position := 2;
  NewColum.Width := 90;
  NewColum.Text := 'Address [Hex]';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 90;
  NewColum.Position := 3;
  NewColum.Width := 90;
  NewColum.Text := 'Address [Dec]';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 80;
  NewColum.Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus];
  NewColum.Position := 4;
  NewColum.Width := 80;
  NewColum.Text := 'Size [Bytes]';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
  NewColum.Position := 5;
  NewColum.Width := 100;
  NewColum.Text := 'Slot1 Data';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
  NewColum.Position := 6;
  NewColum.Width := 100;
  NewColum.Text := 'Slot2 Data';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
  NewColum.Position := 7;
  NewColum.Width := 100;
  NewColum.Text := 'Slot3 Data';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 100;
  NewColum.Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
  NewColum.Position := 8;
  NewColum.Width := 100;
  NewColum.Text := 'Slot4 Data';

  NewColum := vstSlotCmp.Header.Columns.Add;
  NewColum.MinWidth := 300;
  NewColum.Position := 9;
  NewColum.Width := 300;
  NewColum.Text := 'User notes';

  pmVST := TPopupMenu.Create(Self);
  vstSlotCmp.PopupMenu := pmVST;

  TempMenuItem := TMenuItem.Create(Self);
  TempMenuItem.Caption := 'Clear selected user notes';
  TempMenuItem.OnClick := MenuItem_ClearSelectedUserNotesClick;
  pmVST.Items.Add(TempMenuItem);

  TempMenuItem := TMenuItem.Create(Self);
  TempMenuItem.Caption := 'Clear SimMem commands from selected user notes';
  TempMenuItem.OnClick := MenuItem_ClearSimCmdsFromSelectedUserNotesClick;
  pmVST.Items.Add(TempMenuItem);
end;


procedure TfrmMemStatCompare.FormCreate(Sender: TObject);
begin
  CreateRemainingComponents;
  Menu := mmCmpMain; //Manually set, because an IDE bug makes the window grow in height, every time the file is modified.

  FDeviceInfo := TDeviceInfo.Create;

  FSlot1.HasHex := False;
  FSlot1.HasLst := False;
  FSlot1.FileNameHex := '';
  FSlot1.FileNameLst := '';

  FSlot2.HasHex := False;
  FSlot2.HasLst := False;
  FSlot2.FileNameHex := '';
  FSlot2.FileNameLst := '';

  FSlot3.HasHex := False;
  FSlot3.HasLst := False;
  FSlot3.FileNameHex := '';
  FSlot3.FileNameLst := '';

  FSlot4.HasHex := False;
  FSlot4.HasLst := False;
  FSlot4.FileNameHex := '';
  FSlot4.FileNameLst := '';

  SetLength(FAllSlots, 4); //hardcoded for now
  FAllSlots[0] := @FSlot1;
  FAllSlots[1] := @FSlot2;
  FAllSlots[2] := @FSlot3;
  FAllSlots[3] := @FSlot4;

  SetLength(FUserNoteArr, 0);
  FUserNotesModified := False;

  FSettingFilename := '';

  tmrStartup.Enabled := True;

  vstSlotCmp.Hint :=  'Press:' + #13#10 + #13#10 +
                      'Ctrl+C to copy the selected line.' + #13#10 +
                      'Ctrl+Shift+C to copy the entire table.' + #13#10 +
                      'Ctrl+Alt+C to copy the selected line with header.' + #13#10 +
                      'Ctrl+Alt+Shift+C to copy the entire table with header.' + #13#10 + #13#10 +
                      'Ctrl+S to save the selected line.' + #13#10 +
                      'Ctrl+Shift+S to save the entire table.' + #13#10 +
                      'Ctrl+Alt+S to save the selected line with header.' + #13#10 +
                      'Ctrl+Alt+Shift+S to save the entire table with header.';

  FEditingText := '';
  SetLength(FCachedSections, 0);

  FOnChangeDevice := nil;
  FOnCmpWindowDestroy := nil;

  FMiniMap := nil; //will be created in startup timer
  FCachedSectionIndex := 0;
  Caption := Caption + ' [' + IntToStr(Handle) + ']';
end;


procedure TfrmMemStatCompare.FormDestroy(Sender: TObject);
begin
  SetLength(FCachedSections, 0);
  FDeviceInfo.Free;
end;


procedure TfrmMemStatCompare.CreateMinimap;
begin
  FMiniMap := TMiniMap.Create(pnlMiniMap);
  FMiniMap.Parent := pnlMiniMap;
  FMiniMap.Left := 0;
  FMiniMap.Top := 0;
  FMiniMap.Width := pnlMiniMap.Width;
  FMiniMap.Height := pnlMiniMap.Height;
  FMiniMap.Visible := True;
  FMiniMap.Anchors := [akLeft, akTop, akRight, akBottom];

  FMiniMap.OnMouseDown := MinimapMouseDown;
  FMiniMap.OnMouseMove := MinimapMouseMove;
  FMiniMap.PopupMenu := pmimgMinimap;

  FMiniMap.Slot1 := @FSlot1;
  FMiniMap.Slot2 := @FSlot2;
  FMiniMap.Slot3 := @FSlot3;
  FMiniMap.Slot4 := @FSlot4;
end;


procedure TfrmMemStatCompare.SetMinimapColorOptions;
begin
  FMiniMap.FirstFileEntryChartColor := FMemStatColorOptions.FirstFileEntryChart;
  FMiniMap.SecondFileEntryChartColor := FMemStatColorOptions.SecondFileEntryChart;
  FMiniMap.ThirdFileEntryChartColor := FMemStatColorOptions.ThirdFileEntryChart;
  FMiniMap.FourthFileEntryChartColor := FMemStatColorOptions.FourthFileEntryChart;

  FMiniMap.FirstFileSelectedEntryChartColor := FMemStatColorOptions.FirstFileSelectedEntryChart;
  FMiniMap.SecondFileSelectedEntryChartColor := FMemStatColorOptions.SecondFileSelectedEntryChart;
  FMiniMap.ThirdFileSelectedEntryChartColor := FMemStatColorOptions.ThirdFileSelectedEntryChart;
  FMiniMap.FourthFileSelectedEntryChartColor := FMemStatColorOptions.FourthFileSelectedEntryChart;
end;


procedure TfrmMemStatCompare.imgMinimapMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlMiniMapMouseDown(Sender, Button, Shift, X, Y);
end;


procedure TfrmMemStatCompare.imgMinimapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlMiniMapMouseMove(Sender, Shift, X, Y);
end;


procedure TfrmMemStatCompare.MenuItem_ClearSelectedUserNotesClick(
  Sender: TObject);
var
  Node: PVirtualNode;
  Address: DWord;
  CurrentNote: string;
begin
  Node := vstSlotCmp.GetFirstSelected;
  if Node = nil then
    Exit;

  vstSlotCmp.BeginUpdate;
  try
    repeat
      if vstSlotCmp.Selected[Node] then
      begin
        Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

        CurrentNote := GetUserNoteAtAddress(Address);
        if CurrentNote <> '' then
        begin
          //CurrentNote := StringReplace(CurrentNote, CWriteWord_UserNote + ' ', '', [rfReplaceAll]);
          //CurrentNote := StringReplace(CurrentNote, CWriteRow_UserNote + ' ', '', [rfReplaceAll]);
          //CurrentNote := StringReplace(CurrentNote, CErase_UserNote + ' ', '', [rfReplaceAll]);

          UpdateUserNote(Address, '');
          FUserNotesModified := True;
        end;
      end;

      Node := Node^.NextSibling;
    until Node = nil;
  finally
    vstSlotCmp.EndUpdate;
  end;
end;


procedure TfrmMemStatCompare.MenuItem_ClearSimCmdsFromSelectedUserNotesClick(Sender: TObject);
var
  Node: PVirtualNode;
  Address: DWord;
  CurrentNote: string;
begin
  Node := vstSlotCmp.GetFirstSelected;
  if Node = nil then
    Exit;

  vstSlotCmp.BeginUpdate;
  try
    repeat
      if vstSlotCmp.Selected[Node] then
      begin
        Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

        CurrentNote := GetUserNoteAtAddress(Address);
        if CurrentNote <> '' then
        begin
          CurrentNote := StringReplace(CurrentNote, ' ' + CWriteWord_UserNote, '', [rfReplaceAll]);
          CurrentNote := StringReplace(CurrentNote, ' ' + CWriteRow_UserNote, '', [rfReplaceAll]);
          CurrentNote := StringReplace(CurrentNote, ' ' + CErase_UserNote, '', [rfReplaceAll]);

          UpdateUserNote(Address, CurrentNote);
          FUserNotesModified := True;
        end;
      end;

      Node := Node^.NextSibling;
    until Node = nil;
  finally
    vstSlotCmp.EndUpdate;
  end;
end;


procedure TfrmMemStatCompare.EraseSlot(var AFileSlot: TFileSlot; ASlotIndex: Integer);
var
  AllSections: TSectionArr;
  i, j: Integer;
  s: string;
begin
  AFileSlot.FileNameHex := '';
  AFileSlot.HasHex := True;

  FDeviceInfo.GetDeviceSections(AllSections);

  case ASlotIndex of
    1:
      vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot1_Data].Text := 'Slot1 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

    2:
      vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot2_Data].Text := 'Slot2 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

    3:
      vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot3_Data].Text := 'Slot3 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

    4:
      vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot4_Data].Text := 'Slot4 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

    else
      raise Exception.Create('Unsupported index when loading hex file: ' + IntToStr(ASlotIndex));
  end;

  SetLength(AFileSlot.DecodedHEX, 0);
  for i := 0 to Length(AllSections) - 1 do
    for j := 0 to Length(AllSections[i].AddrRanges) - 1 do
    begin
      SetLength(AFileSlot.DecodedHEX, Length(AFileSlot.DecodedHEX) + 1);
      AFileSlot.DecodedHEX[Length(AFileSlot.DecodedHEX) - 1].HAddr := AllSections[i].AddrRanges[j].MinAddr;
      AFileSlot.DecodedHEX[Length(AFileSlot.DecodedHEX) - 1].HData := $FFFFFFFF;
    end;

  //convert to KSEG
    //if ConvertPHYToKSEG then                       /////////////////////////////// this should not be a feature of this function
      for i := 0 to Length(AFileSlot.DecodedHEX) - 1 do
      begin
        s := IntToHex(AFileSlot.DecodedHEX[i].HAddr, 8);
        PhysicalAddrToKseg(s);
        AFileSlot.DecodedHEX[i].HAddr := HexToInt(s);
      end;
    
  ConvertDecodedHexToFullMemory(AFileSlot);
  SetVisibleEntries;
  vstSlotCmp.Repaint;
  DrawMiniMap;
end;


procedure TfrmMemStatCompare.MenuItem_Erase1Click(Sender: TObject);
begin
  EraseSlot(FSlot1, 1);
end;


procedure TfrmMemStatCompare.MenuItem_Erase2Click(Sender: TObject);
begin
  EraseSlot(FSlot2, 2);
end;


procedure TfrmMemStatCompare.MenuItem_Erase3Click(Sender: TObject);
begin
  EraseSlot(FSlot3, 3);
end;


procedure TfrmMemStatCompare.MenuItem_Erase4Click(Sender: TObject);
begin
  EraseSlot(FSlot4, 4);
end;


procedure TfrmMemStatCompare.MenuItem_ShowSimulatedMemoryClick(Sender: TObject);
begin
  frmSimulatedMem.Show;
end;


procedure TfrmMemStatCompare.MinimapMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlMiniMapMouseDown(Sender, Button, Shift, X, Y);
end;


procedure TfrmMemStatCompare.MinimapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlMiniMapMouseMove(Sender, Shift, X, Y);
end;


procedure TfrmMemStatCompare.lbeSearchDataChange(Sender: TObject);
begin
  tmrSearch.Enabled := True;
end;


procedure TfrmMemStatCompare.lbeSearchHexAddrChange(Sender: TObject);
begin
  tmrSearch.Enabled := True;
end;


procedure TfrmMemStatCompare.lbeSearchNoteChange(Sender: TObject);
begin
  tmrSearch.Enabled := True;
end;


procedure TfrmMemStatCompare.LoadHex(Sender: TObject; var AFileSlot: TFileSlot; ASlotIndex: Integer);
var
  Debugmsg: string;
begin
  if Sender <> nil then                 //open dialog only from menu.  nil is passed when loading from setting file
  begin
    if not OpenDialogHex.Execute then
      Exit;
  end
  else
    OpenDialogHex.FileName := AFileSlot.FileNameHex;

  if LoadHEXFile(OpenDialogHex.FileName, True, AFileSlot.DecodedHEX, Debugmsg) then
  begin
    AFileSlot.FileNameHex := OpenDialogHex.FileName;
    AFileSlot.HasHex := True;

    case ASlotIndex of
      1:
        vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot1_Data].Text := 'Slot1 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

      2:
        vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot2_Data].Text := 'Slot2 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

      3:
        vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot3_Data].Text := 'Slot3 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

      4:
        vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot4_Data].Text := 'Slot4 Data' + #13#10 + ExtractFileName(AFileSlot.FileNameHex) + #13#10 + ExtractFileName(AFileSlot.FileNameLst);

      else
        raise Exception.Create('Unsupported index when loading hex file: ' + IntToStr(ASlotIndex));
    end;
    
    ConvertDecodedHexToFullMemory(AFileSlot);
    SetVisibleEntries;
    vstSlotCmp.Repaint;
    DrawMiniMap;
  end;
end;  


procedure TfrmMemStatCompare.LoadHEX1Click(Sender: TObject);
begin
  LoadHex(Sender, FSlot1, 1);
end;


procedure TfrmMemStatCompare.LoadHEX2Click(Sender: TObject);
begin
  LoadHex(Sender, FSlot2, 2);
end;


procedure TfrmMemStatCompare.LoadHEX3Click(Sender: TObject);
begin
  LoadHex(Sender, FSlot3, 3);
end;


procedure TfrmMemStatCompare.LoadHEX4Click(Sender: TObject);
begin
  LoadHex(Sender, FSlot4, 4);
end;


function TfrmMemStatCompare.GetLstFileNameFromCmdLine: string;  ////////////////////////// this looks wrong
begin
  Result := FCmdlineLstFile;
  if UpperCase(ExtractFileExt(Result)) = '.LST' then
  begin
    Delete(Result, Length(Result) - 2, 3);
    Result := Result + 'hex';
  end;
end;


procedure TfrmMemStatCompare.LoadHexFromMainWindow(var AFileSlot: TFileSlot; ASlotIndex: Integer);
var
  Fnm: TFileName;
begin
  CloseHex(AFileSlot, ASlotIndex);

  Fnm := GetLstFileNameFromCmdLine;

  if FileExists(Fnm) then
  begin
    AFileSlot.FileNameHex := Fnm;
    LoadHex(nil, AFileSlot, ASlotIndex);
  end
  else
    MessageBox(Handle, PChar('File not found:'#13#10 + Fnm), PChar(Application.Title), MB_ICONERROR);
end;



procedure TfrmMemStatCompare.LoadHEXFromMainWindow1Click(Sender: TObject);
begin
  LoadHexFromMainWindow(FSlot1, 1);
end;


procedure TfrmMemStatCompare.LoadHEXFromMainWindow2Click(Sender: TObject);
begin
  LoadHexFromMainWindow(FSlot2, 2);
end;


procedure TfrmMemStatCompare.LoadHEXFromMainWindow3Click(Sender: TObject);
begin
  LoadHexFromMainWindow(FSlot3, 3);
end;


procedure TfrmMemStatCompare.LoadHEXFromMainWindow4Click(Sender: TObject);
begin
  LoadHexFromMainWindow(FSlot4, 4);
end;


procedure TfrmMemStatCompare.LoadExternalHex(ASlotIdex: Integer; AFromMainWindow: Boolean = False);
begin
  if AFromMainWindow then
    LoadHexFromMainWindow(FAllSlots[ASlotIdex]^, ASlotIdex + 1)
  else
    LoadHex(mmCmpMain, FAllSlots[ASlotIdex]^, ASlotIdex + 1);
end;


procedure TfrmMemStatCompare.LoadComparisonSettings;
var
  Ini: TMemIniFile;
  Fnm1, Fnm2, Fnm3, Fnm4: TFileName;
  AChipName: string;
  i: Integer;
begin
  Ini := TMemIniFile.Create(FSettingFilename);
  try
    CloseAllHexFiles;

    AChipName := Ini.ReadString('Device', 'ChipName', '');
    if AChipName = '' then
    begin
      AChipName := FDeviceInfo.DefaultChipName;
      if MessageBox(Handle, PChar('No device information could be found in the loaded file. Change device to ' + AChipName + '?'), PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = ID_YES then
        ChipName := AChipName
      else
        AChipName := ChipName;
    end
    else
      if AChipName <> ChipName then
        ChipName := AChipName;
    
    if FDefsFolder <> '' then
      LoadMlk(AChipName);

    Fnm1 := Ini.ReadString('Hex files', 'File_1', '');
    Fnm2 := Ini.ReadString('Hex files', 'File_2', '');
    Fnm3 := Ini.ReadString('Hex files', 'File_3', '');
    Fnm4 := Ini.ReadString('Hex files', 'File_4', '');

    if Fnm1 <> '' then
    begin
      FSlot1.FileNameHex := Fnm1;
      LoadHex(nil, FSlot1, 1);
    end;

    if Fnm2 <> '' then
    begin
      FSlot2.FileNameHex := Fnm2;
      LoadHex(nil, FSlot2, 2);
    end;

    if Fnm3 <> '' then
    begin
      FSlot3.FileNameHex := Fnm3;
      LoadHex(nil, FSlot3, 3);
    end;

    if Fnm4 <> '' then
    begin
      FSlot4.FileNameHex := Fnm4;
      LoadHex(nil, FSlot4, 4);
    end;

    for i := 0 to vstSlotCmp.Header.Columns.Count - 1 do
      vstSlotCmp.Header.Columns.Items[i].Width := Ini.ReadInteger('Table', 'Col_' + IntToStr(i), vstSlotCmp.Header.Columns.Items[i].Width);

    Width := Ini.ReadInteger('Window', 'Width', Width);
    Height := Ini.ReadInteger('Window', 'Height', Height);

    SetLength(FUserNoteArr, Ini.ReadInteger('UserNotes', 'Count', 0));
    for i := 0 to Length(FUserNoteArr) - 1 do
    begin
      FUserNoteArr[i].Note := Ini.ReadString('UserNotes', 'Note_' + IntToStr(i), '');
      FUserNoteArr[i].Address := Ini.ReadInteger('UserNotes', 'NoteAddr_' + IntToStr(i), 0);
    end;
  finally
    Ini.Free;
  end;

  vstSlotCmp.Repaint;

  Caption := 'Memory Statistics - Visual Compare - ' + ExtractFileName(FSettingFilename);
end;


procedure TfrmMemStatCompare.SaveComparisonSettings;
var
  Ini: TMemIniFile;
  i: Integer;
begin
  Ini := TMemIniFile.Create(FSettingFilename);
  try
    Ini.WriteString('Device', 'ChipName', FChipName);
    
    Ini.WriteString('Hex files', 'File_1', FSlot1.FileNameHex);
    Ini.WriteString('Hex files', 'File_2', FSlot2.FileNameHex);
    Ini.WriteString('Hex files', 'File_3', FSlot3.FileNameHex);
    Ini.WriteString('Hex files', 'File_4', FSlot4.FileNameHex);

    for i := 0 to vstSlotCmp.Header.Columns.Count - 1 do
      Ini.WriteInteger('Table', 'Col_' + IntToStr(i), vstSlotCmp.Header.Columns.Items[i].Width);

    Ini.WriteInteger('Window', 'Width', Width);
    Ini.WriteInteger('Window', 'Height', Height);

    Ini.WriteInteger('UserNotes', 'Count', Length(FUserNoteArr));

    for i := 0 to Length(FUserNoteArr) - 1 do
    begin
      Ini.WriteString('UserNotes', 'Note_' + IntToStr(i), FUserNoteArr[i].Note);
      Ini.WriteInteger('UserNotes', 'NoteAddr_' + IntToStr(i), FUserNoteArr[i].Address);
    end;

    Ini.UpdateFile;
  finally
    Ini.Free;
  end;

  Caption := 'Memory Statistics - Visual Compare - ' + ExtractFileName(FSettingFilename);
  FUserNotesModified := False;
end;


procedure TfrmMemStatCompare.Compare1Click(Sender: TObject);      //"Compare" menu item
begin
  if not FileExists(FSettingFilename) then
  begin
    mmCmpMain.Items.Items[0].Items[1].Caption := 'Save settings...';
    mmCmpMain.Items.Items[0].Items[2].Enabled := False;
  end
  else
  begin
    mmCmpMain.Items.Items[0].Items[1].Caption := 'Save settings';
    mmCmpMain.Items.Items[0].Items[2].Enabled := True;
  end
end;


procedure TfrmMemStatCompare.Loadsettingsfromfile1Click(Sender: TObject);
begin
  if FSettingFilename <> '' then
    OpenDialogSettings.FileName := FSettingFilename;

  if not OpenDialogSettings.Execute then
    Exit;

  if (Length(FUserNoteArr) > 0) and FUserNotesModified then
    if MessageBox(Handle, 'Current user notes are not saved. Do you want to save before loading a new settings file?', PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = IDYES then
      Savesettingstofile1Click(Sender);

  SetLength(FUserNoteArr, 0);

  FSettingFilename := OpenDialogSettings.FileName;
  LoadComparisonSettings;
end;


procedure TfrmMemStatCompare.Savesettingstofile1Click(Sender: TObject);
begin
  if not FileExists(FSettingFilename) then
    SaveAsSettings1Click(Sender)
  else
  begin
    if UpperCase(Copy(FSettingFilename, Length(FSettingFilename) - Length(CExt) + 1, MaxInt)) <> UpperCase(CExt) then
      FSettingFilename := FSettingFilename + CExt;
    SaveComparisonSettings;
  end;
end;


procedure TfrmMemStatCompare.SaveAsSettings1Click(Sender: TObject);
label
  Ask;
begin
  SaveDialogSettings.FileName := FSettingFilename;
  Ask:
  if not SaveDialogSettings.Execute then
    Exit;

  if FileExists(SaveDialogSettings.FileName) then
  begin
    if MessageBox(Handle, 'The selected file already exists. Do you want to replace it?', PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = IDYES then
    begin
      FSettingFilename := SaveDialogSettings.FileName;
      SaveComparisonSettings;
    end
    else
      goto Ask;
  end
  else
  begin
    FSettingFilename := SaveDialogSettings.FileName;
    if UpperCase(Copy(FSettingFilename, Length(FSettingFilename) - Length(CExt) + 1, MaxInt)) <> UpperCase(CExt) then
      FSettingFilename := FSettingFilename + CExt;
    SaveComparisonSettings;
  end;
end;


procedure TfrmMemStatCompare.pnlMiniMapMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlMiniMapMouseMove(Sender, Shift, X, Y);
end;


procedure TfrmMemStatCompare.pnlMiniMapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  SelIndex: Int64;
begin
  if ssLeft in Shift then
  begin
    SelIndex := Round(Int64(vstSlotCmp.RootNodeCount) * Int64(Y) / Int64(pnlMiniMap.Height));
    if SelIndex > Int64(vstSlotCmp.RootNodeCount) - 1 then
      SelIndex := vstSlotCmp.RootNodeCount - 1;

    ScrollIntoViewNodeByIndex(vstSlotCmp, SelIndex, ssCtrl in Shift);
    tmrRepaintMinimapOnSelect.Enabled := True;
  end;
end;


procedure TfrmMemStatCompare.pnlMiniMapResize(Sender: TObject);
begin
  //DrawMiniMap;    //no need to call this
end;


procedure TfrmMemStatCompare.ReloadHex(Sender: TObject; AFileSlot: TFileSlot; ASlotIndex: Integer);
var
  Debugmsg: string;
begin
  if AFileSlot.HasHex then
  begin
    SetLength(AFileSlot.DecodedHEX, 0);
    SetLength(AFileSlot.FullHEX, 0);
    SetLength(AFileSlot.Sections, 0);

    LoadHEXFile(AFileSlot.FileNameHex, True, AFileSlot.DecodedHEX, Debugmsg);
    ConvertDecodedHexToFullMemory(AFileSlot);
    SetVisibleEntries;
    DrawMiniMap;
  end
  else
    LoadHex(Sender, AFileSlot, ASlotIndex);
end;


procedure TfrmMemStatCompare.ReloadHEX1Click(Sender: TObject);
begin
  ReloadHex(Sender, FSlot1, 1);
end;


procedure TfrmMemStatCompare.ReloadHEX2Click(Sender: TObject);
begin
  ReloadHex(Sender, FSlot2, 2);
end;


procedure TfrmMemStatCompare.ReloadHEX3Click(Sender: TObject);
begin
  ReloadHex(Sender, FSlot3, 3);
end;


procedure TfrmMemStatCompare.ReloadHEX4Click(Sender: TObject);
begin
  ReloadHex(Sender, FSlot4, 4);
end;


procedure TfrmMemStatCompare.tmrEditingUserNotesTimer(Sender: TObject);
var
  ABounds: TRect;
begin
  tmrEditingUserNotes.Enabled := False;

  if FHitInfo.HitNode = nil then
    Exit;

  if FHitInfo.HitColumn = CColumnIdx_User_Notes then
  begin
    vstSlotCmp.EditNode(FHitInfo.HitNode, FHitInfo.HitColumn);

    if Assigned(vstSlotCmp.EditLink) then
    begin
      ABounds := vstSlotCmp.EditLink.GetBounds;
      ABounds.Left := ABounds.Left - 2;
      ABounds.Right := Max(ABounds.Right, ABounds.Left + vstSlotCmp.Header.Columns[FHitInfo.HitColumn].MinWidth);
      vstSlotCmp.EditLink.SetBounds(ABounds);
    end;
  end;
end;


procedure TfrmMemStatCompare.tmrHideUpdatingTableTimer(Sender: TObject);
begin
  tmrHideUpdatingTable.Enabled := False;
  pnlUpdatingTable.Hide;
end;


procedure TfrmMemStatCompare.tmrRepaintMinimapOnSelectTimer(Sender: TObject);
//var
//  SelectedNode: PVirtualNode;
begin
  tmrRepaintMinimapOnSelect.Enabled := False;

//  SelectedNode := vstSlotCmp.GetFirstSelected;
//  if SelectedNode = nil then
//    Exit;

  DrawMiniMap;
end;


procedure TfrmMemStatCompare.tmrSearchTimer(Sender: TObject);
begin
  tmrSearch.Enabled := False;
  SearchInSlotDataTable(lbeSearchHexAddr.Text, lbeSearchData.Text, lbeSearchNote.Text);
end;


procedure TfrmMemStatCompare.tmrStartupTimer(Sender: TObject);
begin
  tmrStartup.Enabled := False;

  if FMemStatMiscOptions.DisplayDecimalAddressesCmpTable then
    vstSlotCmp.Header.Columns.Items[3].Options := vstSlotCmp.Header.Columns.Items[3].Options + [coVisible]
  else
    vstSlotCmp.Header.Columns.Items[3].Options := vstSlotCmp.Header.Columns.Items[3].Options - [coVisible];
end;


procedure TfrmMemStatCompare.vstSlotCmpAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  {$IFDEF FPC}const{$ENDIF} CellRect: TRect);
var
  Len1, Len2, Len3, Len4: Integer;
begin
  if not Assigned(Node) then
    Exit;

  if not (Column in [CColumnIdx_Slot1_Data..CColumnIdx_Slot4_Data]) then
    Exit; 

  GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  //overlapped
  case Column of
    CColumnIdx_Slot1_Data:
    begin
      if (Len1 > 0) and (Len2 > 0) then
      begin
        if FSlot1.FullHEX[Node.Index].HData <> FSlot2.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FFirstSecondCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FFirstSecondCmpColor;
            
          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Right - 6, CellRect.Top, CellRect.Right, CellRect.Bottom);
        end;
      end;
    end; //0

    CColumnIdx_Slot2_Data:
    begin
      if (Len1 > 0) and (Len2 > 0) then
      begin
        if FSlot1.FullHEX[Node.Index].HData <> FSlot2.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FFirstSecondCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FFirstSecondCmpColor;

          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Left, CellRect.Top, CellRect.Left + 6, CellRect.Bottom);
        end;
      end;
      
      if (Len2 > 0) and (Len3 > 0) then
      begin
        if FSlot2.FullHEX[Node.Index].HData <> FSlot3.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FSecondThirdCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FSecondThirdCmpColor;

          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Right - 6, CellRect.Top, CellRect.Right, CellRect.Bottom);
        end;
      end;
    end; //1

    CColumnIdx_Slot3_Data:
    begin
      if (Len2 > 0) and (Len3 > 0) then
      begin
        if FSlot2.FullHEX[Node.Index].HData <> FSlot3.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FSecondThirdCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FSecondThirdCmpColor;

          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Left, CellRect.Top, CellRect.Left + 6, CellRect.Bottom);
        end;
      end;
      
      if (Len3 > 0) and (Len4 > 0) then
      begin
        if FSlot3.FullHEX[Node.Index].HData <> FSlot4.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FThirdFourthCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FThirdFourthCmpColor;

          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Right - 6, CellRect.Top, CellRect.Right, CellRect.Bottom);
        end;
      end;
    end; //2

    CColumnIdx_Slot4_Data:
    begin
      if (Len3 > 0) and (Len4 > 0) then
      begin
        if FSlot3.FullHEX[Node.Index].HData <> FSlot4.FullHEX[Node.Index].HData then
        begin
          if vstSlotCmp.Selected[Node] then
            TargetCanvas.Brush.Color := FThirdFourthCmpSelectedColor
          else
            TargetCanvas.Brush.Color := FThirdFourthCmpColor;

          TargetCanvas.Pen.Color := TargetCanvas.Brush.Color;
          TargetCanvas.Rectangle(CellRect.Left, CellRect.Top, CellRect.Left + 6, CellRect.Bottom);
        end;
      end;
    end; //3
  end; //case
end;


procedure TfrmMemStatCompare.vstSlotCmpBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Len1, Len2, Len3, Len4: Integer;
  SectionIndex: Integer;
begin
  if CellPaintMode <> cpmPaint then
    Exit;
    
  if not Assigned(Node) then
    Exit;

 GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  //main colors
  case Column of
    CColumnIdx_Index..CColumnIdx_User_Notes:
    begin
      SectionIndex := FCachedSectionIndex;

      if SectionIndex > - 1 then
      begin
        TargetCanvas.Brush.Color := FMemStatColorOptions.EntryColorTableArr[SectionIndex];
        TargetCanvas.Pen.Color := clWindow;

        if (Column = CColumnIdx_Address_Hex) or (Column = CColumnIdx_Address_Dec) then
          TargetCanvas.Brush.Color := DecreaseBrightnessBy8(TargetCanvas.Brush.Color);

        case Column of
          CColumnIdx_Slot1_Data:
          begin
            TargetCanvas.Pen.Color := FMemStatColorOptions.FirstFileEntryChart;
            TargetCanvas.Brush.Color := FCachedSlotEntryColorTableArr[SectionIndex].Slot1;
          end;

          CColumnIdx_Slot2_Data:
          begin
            TargetCanvas.Pen.Color := FMemStatColorOptions.SecondFileEntryChart;
            TargetCanvas.Brush.Color := FCachedSlotEntryColorTableArr[SectionIndex].Slot2;
          end;

          CColumnIdx_Slot3_Data:
          begin
            TargetCanvas.Pen.Color := FMemStatColorOptions.ThirdFileEntryChart;
            TargetCanvas.Brush.Color := FCachedSlotEntryColorTableArr[SectionIndex].Slot3;
          end;

          CColumnIdx_Slot4_Data:
          begin
            TargetCanvas.Pen.Color := FMemStatColorOptions.FourthFileEntryChart;
            TargetCanvas.Brush.Color := FCachedSlotEntryColorTableArr[SectionIndex].Slot4;
          end;
        end; //case

        TargetCanvas.Rectangle(CellRect);
      end;
    end;  //0
  end; //case
end;


procedure TfrmMemStatCompare.vstSlotCmpBeforeItemPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; {$IFDEF FPC}const{$ENDIF} ItemRect: TRect;
  var CustomDraw: Boolean);
begin
  FCachedSectionIndex := GetSectionIndexByEntryIndex(FCachedSections, Node^.Index);
end;


procedure TfrmMemStatCompare.vstSlotCmpBeforePaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  ComputeCmpColors;
  GetSectionsFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, FCachedSections);
end;


procedure TfrmMemStatCompare.vstSlotCmpClick(Sender: TObject);
begin
  tmrRepaintMinimapOnSelect.Enabled := True;
end;


procedure TfrmMemStatCompare.vstSlotCmpDblClick(Sender: TObject);
begin
  tmrEditingUserNotes.Enabled := True;
end;


procedure TfrmMemStatCompare.vstSlotCmpEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Address: DWord;
begin
  Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

  UpdateUserNote(Address, FEditingText);
  FUserNotesModified := True;
  FEditingText := ''; //Reset
end;


procedure TfrmMemStatCompare.vstSlotCmpEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Address: DWord;
begin
  Allowed := Column = 9;
  Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

  if Allowed then
    FEditingText := GetUserNoteAtAddress(Address);
end;


procedure TfrmMemStatCompare.vstSlotCmpGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
var
  Len1, Len2, Len3, Len4: Integer;
  Address: DWord;
begin
  GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  case Column of
    CColumnIdx_Index:
      CellText := IntToStr(Node.Index);

    CColumnIdx_Mem:
    begin
      GetSectionsFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, FCachedSections);
      CellText := GetDisplaySectionNameByEntryIndex(FCachedSections, Node^.Index, '???');
    end; //1

    CColumnIdx_Address_Hex:
    begin
      Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);
      CellText := '0x' + IntToHex(Address, 8);
    end;

    CColumnIdx_Address_Dec:
    begin
      Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);
      CellText := IntToStr(Address);
    end;

    CColumnIdx_Size:
      CellText := '?';

    CColumnIdx_Slot1_Data:
      if Node.Index < DWord(Len1) then
        CellText := '0x' + IntToHex(FSlot1.FullHEX[Node.Index].HData, 8)
      else
        CellText := '';  

    CColumnIdx_Slot2_Data:
      if Node.Index < DWord(Len2) then
        CellText := '0x' + IntToHex(FSlot2.FullHEX[Node.Index].HData, 8)
      else
        CellText := '';

    CColumnIdx_Slot3_Data:
      if Node.Index < DWord(Len3) then
        CellText := '0x' + IntToHex(FSlot3.FullHEX[Node.Index].HData, 8)
      else
        CellText := '';

    CColumnIdx_Slot4_Data:
      if Node.Index < DWord(Len4) then
        CellText := '0x' + IntToHex(FSlot4.FullHEX[Node.Index].HData, 8)
      else
        CellText := '';

    CColumnIdx_User_Notes:
    begin
      Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);
      CellText := GetUserNoteAtAddress(Address);
    end;

  else
    CellText := '';
  end; //case
end;


procedure TfrmMemStatCompare.vstSlotCmpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
    if Key = Ord('C') then
      Clipboard.AsText := VstSlotData_ToTextTable(not (ssShift in Shift), ssAlt in Shift);

  if ssCtrl in Shift then
    if Key = Ord('S') then
      SaveTableToFile(Handle, VstSlotData_ToTextTable(not (ssShift in Shift), ssAlt in Shift), SaveDialog1);
end;


procedure TfrmMemStatCompare.vstSlotCmpKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_HOME) or (Key = VK_END) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
  begin
    vstSlotCmpClick(Sender);

    Node := vstSlotCmp.GetFirstSelected;
    if Node <> nil then
      vstSlotCmp.ScrollIntoView(Node, False);
  end;
end;


procedure TfrmMemStatCompare.vstSlotCmpMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  vstSlotCmp.GetHitTestInfoAt(X, Y, True, FHitInfo);
end;


procedure TfrmMemStatCompare.vstSlotCmpNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; {$IFDEF FPC}const{$ENDIF} NewText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
begin
  FEditingText := NewText;
end;


function TfrmMemStatCompare.IndexOfAddressInUserNotes(AAddress: Cardinal): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i := 0 to Length(FUserNoteArr) - 1 do
    if FUserNoteArr[i].Address = AAddress then
    begin
      Result := i;
      Exit;
    end;
end;


function TfrmMemStatCompare.GetUserNoteAtAddress(AAddress: Cardinal): string;
var
  Index: Integer;
begin
  Index := IndexOfAddressInUserNotes(AAddress);
  if Index = -1 then
    Result := ''
  else
    Result := FUserNoteArr[Index].Note;
end;


procedure TfrmMemStatCompare.UpdateUserNote(AAddress: Cardinal; ANote: string);
var
  Index, n: Integer;
begin
  Index := IndexOfAddressInUserNotes(AAddress);
  if Index = -1 then //add new note
  begin
    if ANote <> '' then
    begin
      n := Length(FUserNoteArr);
      SetLength(FUserNoteArr, n + 1);
      FUserNoteArr[n].Note := ANote;
      FUserNoteArr[n].Address := AAddress;
    end;
  end
  else
  begin
    FUserNoteArr[Index].Note := ANote;
    FUserNoteArr[Index].Address := AAddress;
  end;
end;


procedure TfrmMemStatCompare.ComputeCmpColors;
var
  a: array of TColor;
  SelectionColor: TColor;
  i: Integer;
begin
  SelectionColor := GetCmpSelectionColor;
  SetLength(a, 2);

  a[0] := FMemStatColorOptions.FirstFileEntryChart;
  a[1] := FMemStatColorOptions.SecondFileEntryChart;
  FFirstSecondCmpColor := AverageColor(a);

  a[0] := FMemStatColorOptions.SecondFileEntryChart;
  a[1] := FMemStatColorOptions.ThirdFileEntryChart;
  FSecondThirdCmpColor := AverageColor(a);

  a[0] := FMemStatColorOptions.ThirdFileEntryChart;
  a[1] := FMemStatColorOptions.FourthFileEntryChart;
  FThirdFourthCmpColor := AverageColor(a);

  a[0] := FFirstSecondCmpColor;
  a[1] := SelectionColor;
  FFirstSecondCmpSelectedColor := AverageColor(a);

  a[0] := FSecondThirdCmpColor;
  a[1] := SelectionColor;
  FSecondThirdCmpSelectedColor := AverageColor(a);

  a[0] := FThirdFourthCmpColor;
  a[1] := SelectionColor;
  FThirdFourthCmpSelectedColor := AverageColor(a);

  a[0] := FMemStatColorOptions.FirstFileEntryChart;
  a[1] := SelectionColor;
  FirstFileEntryChartSelectedColor := AverageColor(a);

  a[0] := FMemStatColorOptions.SecondFileEntryChart;
  a[1] := SelectionColor;
  SecondFileEntryChartSelectedColor := AverageColor(a);

  a[0] := FMemStatColorOptions.ThirdFileEntryChart;
  a[1] := SelectionColor;
  ThirdFileEntryChartSelectedColor := AverageColor(a);

  a[0] := FMemStatColorOptions.FourthFileEntryChart;
  a[1] := SelectionColor;
  FourthFileEntryChartSelectedColor := AverageColor(a);

  SetLength(FCachedSlotEntryColorTableArr, Length(FMemStatColorOptions.EntryColorTableArr));
  for i := 0 to Length(FMemStatColorOptions.EntryColorTableArr) - 1 do
  begin
    FCachedSlotEntryColorTableArr[i].Slot1 := WeightedAverage2Colors(FMemStatColorOptions.EntryColorTableArr[i], FMemStatColorOptions.FirstFileEntryChart, 0.9);
    FCachedSlotEntryColorTableArr[i].Slot2 := WeightedAverage2Colors(FMemStatColorOptions.EntryColorTableArr[i], FMemStatColorOptions.SecondFileEntryChart, 0.9);
    FCachedSlotEntryColorTableArr[i].Slot3 := WeightedAverage2Colors(FMemStatColorOptions.EntryColorTableArr[i], FMemStatColorOptions.ThirdFileEntryChart, 0.9);
    FCachedSlotEntryColorTableArr[i].Slot4 := WeightedAverage2Colors(FMemStatColorOptions.EntryColorTableArr[i], FMemStatColorOptions.FourthFileEntryChart, 0.9);
  end;
end;


function TfrmMemStatCompare.GetVstSlotDataLine(Node: PVirtualNode; var ASections: TSectionArr): string;
var
  Len1, Len2, Len3, Len4: Integer;
  Address: DWord;
begin
  Result := IntToStr(Node.Index) + #9;

  GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  Address := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

  Result := Result + GetDisplaySectionNameByEntryIndex(ASections, Node^.Index, '???') + #9;

  Result := Result + '0x' + IntToHex(Address, 8) + #9;
  Result := Result + IntToStr(Address) + #9;

  if Len1 > 0 then
    if Node.Index < DWord(Len1) then
      Result := Result + '0x' + IntToHex(FSlot1.FullHEX[Node.Index].HData, 8) + #9
    else
      Result := Result + '?' + #9;

  if Len2 > 0 then
    if Node.Index < DWord(Len2) then
      Result := Result + '0x' + IntToHex(FSlot2.FullHEX[Node.Index].HData, 8) + #9
    else
      Result := Result + '?' + #9;

  if Len3 > 0 then
    if Node.Index < DWord(Len3) then
      Result := Result + '0x' + IntToHex(FSlot3.FullHEX[Node.Index].HData, 8) + #9
    else
      Result := Result + '?' + #9;

  if Len4 > 0 then
    if Node.Index < DWord(Len4) then
      Result := Result + '0x' + IntToHex(FSlot4.FullHEX[Node.Index].HData, 8)
    else
      Result := Result + '?';

  Result := Result + GetUserNoteAtAddress(Address) + #9;

  Result := StringReplace(Result, #9#9, #9, [rfReplaceAll]);
  if Result[Length(Result)] = #9 then
    Result := Copy(Result, 1, Length(Result) - 1);
end;


//columns separated by #9, rows separated by #13#10
function TfrmMemStatCompare.VstSlotData_ToTextTable(CopyOnlySelectedLine, CopyWithHeader: Boolean): string;
var
  CurrentNode: PVirtualNode;
  s, s1: string;
  Len1, Len2, Len3, Len4: Integer;
  Sections: TSectionArr;
begin
  CurrentNode := vstSlotCmp.GetFirst;
  if CurrentNode = nil then
    Exit;

  if CopyWithHeader then
  begin
    GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

    s := vstSlotCmp.Header.Columns.Items[CColumnIdx_Index].Text + #9 +
         vstSlotCmp.Header.Columns.Items[CColumnIdx_Mem].Text + #9 +
         vstSlotCmp.Header.Columns.Items[CColumnIdx_Address_Hex].Text + #9 +
         vstSlotCmp.Header.Columns.Items[CColumnIdx_Address_Dec].Text;
         //[4]
    if Len1 > 0 then
    begin
      s1 := StringReplace(vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot1_Data].Text, #13#10, ' - ', [rfReplaceAll]);
      if Copy(s1, Length(s1) - 2, 3) = ' - ' then //no lst loaded
        Delete(s1, Length(s1) - 2, 3);
      
      s := s + #9 + s1;
    end;
                                               
    if Len2 > 0 then
    begin
      s1 := StringReplace(vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot2_Data].Text, #13#10, ' - ', [rfReplaceAll]);
      if Copy(s1, Length(s1) - 2, 3) = ' - ' then //no lst loaded
        Delete(s1, Length(s1) - 2, 3);

      s := s + #9 + s1;
    end;

    if Len3 > 0 then
    begin
      s1 := StringReplace(vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot3_Data].Text, #13#10, ' - ', [rfReplaceAll]);
      if Copy(s1, Length(s1) - 2, 3) = ' - ' then //no lst loaded
        Delete(s1, Length(s1) - 2, 3);
      
      s := s + #9 + s1;
    end;

    if Len4 > 0 then
    begin
      s1 := StringReplace(vstSlotCmp.Header.Columns.Items[CColumnIdx_Slot4_Data].Text, #13#10, ' - ', [rfReplaceAll]);
      if Copy(s1, Length(s1) - 2, 3) = ' - ' then //no lst loaded
        Delete(s1, Length(s1) - 2, 3);
      
      s := s + #9 + s1;
    end;

    s := s + #9 + vstSlotCmp.Header.Columns.Items[CColumnIdx_User_Notes].Text;   //user notes

    s := s + #13#10;
  end
  else
    s := '';

  GetSectionsFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Sections);

  repeat
    if not CopyOnlySelectedLine then
    begin  //copy all
      if vstSlotCmp.IsVisible[CurrentNode] then
        s := s + GetVstSlotDataLine(CurrentNode, Sections) + #13#10
    end
    else //only selected 
      if vstSlotCmp.Selected[CurrentNode] then
      begin
        s := s + GetVstSlotDataLine(CurrentNode, Sections);
        Result := s;
        Exit;
      end;

    CurrentNode := CurrentNode.NextSibling;
  until CurrentNode = nil;
  
  Result := s;
end;


procedure TfrmMemStatCompare.DrawMiniMap;
var
  Node: PVirtualNode;
begin
  if FMiniMap = nil then //might be called before being initialized
    Exit;

  Node := vstSlotCmp.GetFirstSelected;
  if Node <> nil then
    FMiniMap.SelectedEntryIndex := Node^.Index
  else
    FMiniMap.SelectedEntryIndex := -1;

  FMiniMap.DrawMiniMap;
end;


procedure TfrmMemStatCompare.SetVisibleEntries;
var
  Len1, Len2, Len3, Len4: Integer;
  CurrentNode: PVirtualNode;

  Diff1, Diff2, Diff3, IsDiff, Visibility: Boolean;
  Len1Len2_GreaterThan0: Boolean;
  Len2Len3_GreaterThan0: Boolean;
  Len3Len4_GreaterThan0: Boolean;
begin
  GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  Len1Len2_GreaterThan0 := (Len1 > 0) and (Len2 > 0);
  Len2Len3_GreaterThan0 := (Len2 > 0) and (Len3 > 0);
  Len3Len4_GreaterThan0 := (Len3 > 0) and (Len4 > 0);


  CurrentNode := vstSlotCmp.GetFirst;
  if CurrentNode = nil then
    Exit;

  vstSlotCmp.BeginUpdate;
  try
    //lblSettingVisibility.Repaint;

    repeat
      Diff1 := False;
      Diff2 := False;
      Diff3 := False;

      if Len1Len2_GreaterThan0 then
        Diff1 := FSlot1.FullHEX[CurrentNode.Index].HData <> FSlot2.FullHEX[CurrentNode.Index].HData;

      if Len2Len3_GreaterThan0 then
        Diff2 := FSlot2.FullHEX[CurrentNode.Index].HData <> FSlot3.FullHEX[CurrentNode.Index].HData;

      if Len3Len4_GreaterThan0 then
        Diff3 := FSlot3.FullHEX[CurrentNode.Index].HData <> FSlot4.FullHEX[CurrentNode.Index].HData;

      IsDiff := Diff1 or Diff2 or Diff3;
      Visibility := True;  //default

      case cmbCmpViewOptions.ItemIndex of
        0: Visibility := True;
        1: Visibility := IsDiff; //Visible if different
        2: Visibility := not IsDiff; //Hidden if different (remain visible on those which are same)
      end;

      vstSlotCmp.IsVisible[CurrentNode] := Visibility;

      CurrentNode := CurrentNode.NextSibling;
    until CurrentNode = nil;
  finally
    vstSlotCmp.EndUpdate;
  end;
  
  vstSlotCmp.Repaint;
end;


procedure TfrmMemStatCompare.spdbtnJumpToPrevSectionClick(Sender: TObject);
var
  Node: PVirtualNode;
  SectionIndex: Integer;
  Sections: TSectionArr;
  n: Int64;
begin
  if vstSlotCmp.GetFirst = nil then
    Exit;

  Node := vstSlotCmp.GetFirstSelected;

  if Node = nil then
    if vstSlotCmp.RootNodeCount > 0 then
    begin
      vstSlotCmp.Selected[vstSlotCmp.GetFirst] := True;
      vstSlotCmp.ScrollIntoView(vstSlotCmp.GetFirst, False);
      vstSlotCmp.SetFocus;
      DrawMiniMap;
      Exit;
    end;

  GetSectionsFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Sections);
  SectionIndex := GetSectionIndexByEntryIndex(Sections, Node^.Index);

  if SectionIndex > -1 then
  begin
    n := GetAccumulatedLen(Sections, SectionIndex);

    vstSlotCmp.Selected[Node] := False; //useful when allowing multiselect
    Node := GetNodeByIndex(vstSlotCmp, Max(0, n - 1));
    vstSlotCmp.Selected[Node] := True;
    vstSlotCmp.ScrollIntoView(Node, True);
    vstSlotCmp.SetFocus;
    DrawMiniMap;
  end;
end;


procedure TfrmMemStatCompare.spdbtnJumpToNextSectionClick(Sender: TObject);
var
  Node: PVirtualNode;
  SectionIndex: Integer;
  Sections: TSectionArr;
  n: Int64;
begin
  if vstSlotCmp.GetFirst = nil then
    Exit;

  Node := vstSlotCmp.GetFirstSelected;

  if Node = nil then
    if vstSlotCmp.RootNodeCount > 0 then
    begin
      vstSlotCmp.Selected[vstSlotCmp.GetFirst] := True;
      vstSlotCmp.ScrollIntoView(vstSlotCmp.GetFirst, False);
      vstSlotCmp.SetFocus;
      DrawMiniMap;
      Exit;
    end;

  GetSectionsFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Sections);
  SectionIndex := GetSectionIndexByEntryIndex(Sections, Node^.Index);

  if SectionIndex > -1 then
  begin
    n := GetAccumulatedLen(Sections, SectionIndex + 1);

    vstSlotCmp.Selected[Node] := False; //useful when allowing multiselect
    Node := GetNodeByIndex(vstSlotCmp, Min(vstSlotCmp.RootNodeCount, Max(n, 0)));

    if Node = nil then
      Node := vstSlotCmp.GetLast;

    vstSlotCmp.Selected[Node] := True;
    vstSlotCmp.ScrollIntoView(Node, True);
    vstSlotCmp.SetFocus;
    DrawMiniMap;
  end;
end;


procedure TfrmMemStatCompare.SetChipName(Value: string);
begin
  if FChipName <> Value then
  begin
    FChipName := Value;
    lblChipName.Caption := FChipName;
  end;
end;


procedure TfrmMemStatCompare.SearchInSlotDataTable(AAddressHex, AData, ANote: string);
var
  Node: PVirtualNode;
  VisibleFromAddrHex, VisibleFromData, VisibleFromNote: Boolean;
  Len1, Len2, Len3, Len4: Integer;
  CurrentAddress: Cardinal;
  CurrentAddressStr: string;
  CurrentNote: string;
  CurrentData1, CurrentData2, CurrentData3, CurrentData4: string;
  UpperCaseAddressHex, UpperCaseData, UpperCaseNote: string;
  AddrEmpty, DataEmpty, NoteEmpty: Boolean;
begin
  Node := vstSlotCmp.GetFirst;
  if Node = nil then
    Exit;

  GetAllSlotsLengths(FSlot1, FSlot2, FSlot3, FSlot4, Len1, Len2, Len3, Len4);

  UpperCaseAddressHex := UpperCase(AAddressHex);
  UpperCaseData := UpperCase(AData);
  UpperCaseNote := UpperCase(ANote);

  AddrEmpty := AAddressHex = '';
  DataEmpty := AData = '';
  NoteEmpty := ANote = '';

  vstSlotCmp.BeginUpdate;
  try
    repeat
      CurrentAddress := GetAddressFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);
      CurrentAddressStr := GetAddressStrFromAllFileSlots(FSlot1, FSlot2, FSlot3, FSlot4, Node^.Index);

      if Len1 > 0 then
        CurrentData1 := FSlot1.FullHEX[Node.Index].HDataStr
      else
        CurrentData1 := '';

      if Len2 > 0 then
        CurrentData2 := FSlot2.FullHEX[Node.Index].HDataStr
      else
        CurrentData2 := '';

      if Len3 > 0 then
        CurrentData3 := FSlot3.FullHEX[Node.Index].HDataStr
      else
        CurrentData3 := '';

      if Len4 > 0 then
        CurrentData4 := FSlot4.FullHEX[Node.Index].HDataStr
      else
        CurrentData4 := '';

      CurrentNote := UpperCase(GetUserNoteAtAddress(CurrentAddress));

      VisibleFromAddrHex := AddrEmpty or (Pos(UpperCaseAddressHex, CurrentAddressStr) > 0);
      VisibleFromData := DataEmpty or (Pos(UpperCaseData, CurrentData1) > 0) or (Pos(UpperCaseData, CurrentData2) > 0) or (Pos(UpperCaseData, CurrentData3) > 0) or (Pos(UpperCaseData, CurrentData4) > 0);
      VisibleFromNote := NoteEmpty or (Pos(UpperCaseNote, CurrentNote) > 0);

      vstSlotCmp.IsVisible[Node] := VisibleFromAddrHex and VisibleFromData and VisibleFromNote;
      Node := Node^.NextSibling;
    until Node = nil;
  finally
    vstSlotCmp.EndUpdate;
    vstSlotCmp.UpdateScrollBars(True);
  end;
end;


function TfrmMemStatCompare.GetCmpFocusedSelectionColor: TColor;
begin
  Result := ColorToRGB(vstSlotCmp.Colors.FocusedSelectionColor)
end;


function TfrmMemStatCompare.GetCmpUnfocusedSelectionColor: TColor;
begin
  Result := ColorToRGB(vstSlotCmp.Colors.UnfocusedSelectionColor);
end;


function TfrmMemStatCompare.GetCmpSelectionColor: TColor;
begin
  if vstSlotCmp.Focused then
    Result := GetCmpFocusedSelectionColor
  else
    Result := GetCmpUnfocusedSelectionColor;
end;


function TfrmMemStatCompare.GetSlotCount: Integer;
begin
  Result := Length(FAllSlots);
end;


procedure TfrmMemStatCompare.DoOnCmpWindowDestroy(ACmpWindowHandle: THandle);
begin
  if not Assigned(FOnCmpWindowDestroy) then
    raise Exception.Create('OnCmpWindowDestroy not assigned.');

  FOnCmpWindowDestroy(ACmpWindowHandle);
end;


{Simulated memory via COM port connection}
procedure TfrmMemStatCompare.EraseMemoryChunk(ASlotIdex: Integer; AStartAddress, ASize: Cardinal; AUserNote: string = '');  //A chunk is usually the same size as an erase page size. However, this class doesn't have to know such details.
var
  MaxAddress, EntryAddress: Int64;
  i: Integer;
  TempShiftAmount, TempPointerSize: Byte;
  CurrentNote: string;
begin
  MaxAddress := AStartAddress + ASize;
  UpdateDevBitness(FDeviceInfo.DeviceBitness, TempShiftAmount, TempPointerSize);

  vstSlotCmp.BeginUpdate;
  try
    for i := 0 to Length(FAllSlots[ASlotIdex]^.FullHEX) - 1 do
    begin
      EntryAddress := FAllSlots[ASlotIdex]^.FullHEX[i].HAddr;
      if (EntryAddress >= Int64(AStartAddress)) and (EntryAddress < MaxAddress) then
      begin
        case FDeviceInfo.DeviceBitness of
          db8: FAllSlots[ASlotIdex]^.FullHEX[i].HData := $FF;
          db16: FAllSlots[ASlotIdex]^.FullHEX[i].HData := $FFFF;
          db32: FAllSlots[ASlotIdex]^.FullHEX[i].HData := $FFFFFFFF;
        end;

        FAllSlots[ASlotIdex]^.FullHEX[i].HDataStr := IntToHex(FAllSlots[ASlotIdex]^.FullHEX[i].HData, TempPointerSize shl 1);

        if AUserNote > '' then
        begin
          CurrentNote := GetUserNoteAtAddress(EntryAddress);
          UpdateUserNote(EntryAddress, CurrentNote + ' ' + AUserNote);
          //FUserNoteArr[i].Note := FUserNoteArr[i].Note + ' ' + AUserNote;
          FUserNotesModified := True;
        end;
      end;  //address in range

    end;    
  finally
    vstSlotCmp.EndUpdate;
  end;

  FMiniMap.Repaint;
end;


procedure TfrmMemStatCompare.WriteMemory(ASlotIdex: Integer; AStartAddress: Cardinal; var AData: array of Byte; AUserNote: string = '');
var
  MaxAddress, EntryAddress: Int64;
  i, ChunkOffset: Integer;
  TempShiftAmount, TempPointerSize: Byte;
  CurrentNote: string;
begin
  MaxAddress := Int64(AStartAddress) + Int64(Length(AData));
  UpdateDevBitness(FDeviceInfo.DeviceBitness, TempShiftAmount, TempPointerSize);

  vstSlotCmp.BeginUpdate;
  try
    ChunkOffset := 0;
    for i := 0 to Length(FAllSlots[ASlotIdex]^.FullHEX) - 1 do
    begin
      EntryAddress := FAllSlots[ASlotIdex]^.FullHEX[i].HAddr;
      if (EntryAddress >= Int64(AStartAddress)) and (EntryAddress < MaxAddress) then
      begin
        Move(AData[ChunkOffset], FAllSlots[ASlotIdex]^.FullHEX[i].HData, TempPointerSize);  //src, dst, cnt
        Inc(ChunkOffset, TempPointerSize);

        FAllSlots[ASlotIdex]^.FullHEX[i].HDataStr := IntToHex(FAllSlots[ASlotIdex]^.FullHEX[i].HData, TempPointerSize shl 1);

        if AUserNote > '' then
        begin
          CurrentNote := GetUserNoteAtAddress(EntryAddress);
          UpdateUserNote(EntryAddress, CurrentNote + ' ' + AUserNote);
//          FUserNoteArr[i].Note := FUserNoteArr[i].Note + ' ' + AUserNote;
          FUserNotesModified := True;
        end;
      end;  //address in range

    end;
  finally
    vstSlotCmp.EndUpdate;
  end;

  FMiniMap.Repaint;
end;


procedure TfrmMemStatCompare.HighlightMemoryChunk(ASlotIdex: Integer; AStartAddress, ASize: Cardinal);   //A chunk can be the same size as an erase page size or a write row size.
begin
  // show something on minimap
end;


procedure TfrmMemStatCompare.HighlightSlotAsConnected(ASlotIdex: Integer);
begin
  // display some icon on column header
end;


end.
