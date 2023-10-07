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


unit SettingsForm;

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
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, MemStatUtils, VirtualTrees, Buttons,
  ImgList
  {$IFDEF FPC}
    , ColorBox
  {$ENDIF}
  , Types;

type

  { TfrmSettings }

  TfrmSettings = class(TForm)
    ColorDialog1: TColorDialog;
    btnOK: TButton;
    btnCancel: TButton;
    lblDevWarning: TLabel;
    pagctrlSettings: TPageControl;
    TabSheetMiscColors: TTabSheet;
    pagctrlColors: TPageControl;
    TabSheetChartMemCmpColors: TTabSheet;
    TabSheetChartMiscColors: TTabSheet;
    grpTextColorsChart: TGroupBox;
    lblChartTextBackgroundColor: TLabel;
    lblChartTextColor: TLabel;
    pnlTextBackgroundChart: TPanel;
    colboxTextBackgroundChart: TColorBox;
    pnlTextColorChart: TPanel;
    colboxTextColorChart: TColorBox;
    grpLinesAndBackgroundColorsChart: TGroupBox;
    lblChartBackgroundColor: TLabel;
    ChartLineColor: TLabel;
    pnlBackgroundChart: TPanel;
    colboxBackgroundChart: TColorBox;
    pnlLineChart: TPanel;
    colboxLineChart: TColorBox;
    grpEntriesColorsChartMemComp: TGroupBox;
    lblFirstFileEntryColor: TLabel;
    lblSecondFileEntryColor: TLabel;
    lblThirdFileEntryColor: TLabel;
    pnlFirstFileEntryChart: TPanel;
    colboxFirstFileEntryChart: TColorBox;
    pnlSecondFileEntryChart: TPanel;
    colboxSecondFileEntryChart: TColorBox;
    pnlThirdFileEntryChart: TPanel;
    colboxThirdFileEntryChart: TColorBox;
    grpSelectedEntriesColorsChartMemComp: TGroupBox;
    pnlFirstFileSelectedEntryChart: TPanel;
    colboxFirstFileSelectedEntryChart: TColorBox;
    pnlSecondFileSelectedEntryChart: TPanel;
    colboxSecondFileSelectedEntryChart: TColorBox;
    pnlThirdFileSelectedEntryChart: TPanel;
    colboxThirdFileSelectedEntryChart: TColorBox;
    grpOverlapColorsChartMemComp: TGroupBox;
    lblFourthFileEntryColor: TLabel;
    pnlFourthFileEntryChart: TPanel;
    colboxFourthFileEntryChart: TColorBox;
    lblFirstFileSelectedEntryColor: TLabel;
    lblSecondFileSelectedEntryColor: TLabel;
    lblThirdFileSelectedEntryColor: TLabel;
    lblFourthFileSelectedEntryColor: TLabel;
    pnlFourthFileSelectedEntryChart: TPanel;
    colboxFourthFileSelectedEntryChart: TColorBox;
    rdgrpColorType: TRadioGroup;
    pnlOverlap: TPanel;
    colboxOverlap: TColorBox;
    TabSheetMiscSettings: TTabSheet;
    chkDisplayDecimalAddressesCmpTable: TCheckBox;
    chkDisplayTableHints: TCheckBox;
    TabSheetMemorySections: TTabSheet;
    btnAdd: TButton;
    btnDelete: TButton;
    spdbtnMoveUp: TSpeedButton;
    spdbtnMoveDown: TSpeedButton;
    grpChartMemoryAllocation: TGroupBox;
    pnlEntryChart: TPanel;
    colboxEntryChart: TColorBox;
    lblEntryColor: TLabel;
    pnlSelectedEntryChart: TPanel;
    lblSelectedEntryColor: TLabel;
    colboxSelectedEntryChart: TColorBox;
    grpTable: TGroupBox;
    lblEntryColorTable: TLabel;
    pnlEntryColorTable: TPanel;
    colboxEntryColorTable: TColorBox;
    lblTextColorTable: TLabel;
    pnlTextColorTable: TPanel;
    colboxTextColorTable: TColorBox;
    lbeDisplayName: TLabeledEdit;
    lbeLongDisplayName: TLabeledEdit;
    lbeDefinitionName: TLabeledEdit;
    lbeAddressOffsetS1: TLabeledEdit;
    lbeMinDefaultAddr: TLabeledEdit;
    lbeAddressOffsetS2: TLabeledEdit;
    lbeMaxDefaultAddr: TLabeledEdit;
    lbeMemoryTranslationInfoValue: TLabeledEdit;
    cmbMemoryTranslationInfoOperation: TComboBox;
    lblMemoryTranslationInfoOperation: TLabel;
    chkVisibleOnCompare: TCheckBox;
    imglstMemSections: TImageList;
    chkDisplayEvenIfMissingFromDefinition: TCheckBox;
    bitbtnUpdate: TBitBtn;
    tmrUpdate: TTimer;
    chkVisibleOnTable: TCheckBox;
    grpDevice: TGroupBox;
    lbeDefaultChipName: TLabeledEdit;
    lbeDefFilePrefix: TLabeledEdit;
    lbeExpectedPrefix: TLabeledEdit;
    cmbDeviceBitness: TComboBox;
    lblDeviceBitness: TLabel;
    grpDeviceDefinitions: TGroupBox;
    lbeDefsFolder: TLabeledEdit;
    btnBrowseDefsFolder: TButton;
    rdgrpDefinitionFilePriority: TRadioGroup;
    chkShowDefsFolderOnMainWindow: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure GenericColorPanelDblClick(Sender: TObject);
    procedure colboxGenericChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgrpColorTypeClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure vstMemSectionsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
    procedure vstMemSectionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vstMemSectionsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spdbtnMoveUpClick(Sender: TObject);
    procedure spdbtnMoveDownClick(Sender: TObject);
    procedure vstMemSectionsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstMemSectionsAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      {$IFDEF FPC}const{$ENDIF} CellRect: TRect);
    procedure FormShow(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure chkVisibleOnCompareKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkVisibleOnCompareMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkDisplayEvenIfMissingFromDefinitionKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure chkDisplayEvenIfMissingFromDefinitionMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cmbMemoryTranslationInfoOperationChange(Sender: TObject);
    procedure GenericLabeledEditChange(Sender: TObject);
    procedure chkDisplayDecimalAddressesCmpTableKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure chkDisplayDecimalAddressesCmpTableMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkDisplayTableHintsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkDisplayTableHintsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkVisibleOnTableKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkVisibleOnTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rdgrpDefinitionFilePriorityClick(Sender: TObject);
    procedure lbeDefsFolderKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBrowseDefsFolderClick(Sender: TObject);
    procedure lbeDefaultChipNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbeDefFilePrefixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbeExpectedPrefixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDeviceBitnessChange(Sender: TObject);
    procedure chkShowDefsFolderOnMainWindowKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkShowDefsFolderOnMainWindowMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FDevInfoEditArr: TDevInfoEditArr;
    FModified: Boolean;
    FUpdateIndicationDir: Boolean; //used on glowing the Update button text
    FPrevSelectedNode: PVirtualNode;

    vstMemSections: TVirtualStringTree;

    procedure SetModified(Value: Boolean);

    procedure UpdateSelectedMemorySectionFromControls;
    procedure SetControlsFromSelectedMemorySection;
    procedure UpdateColorBoxesFromPanels;
    procedure SwapSections(Idx1, Idx2: Integer);
    procedure CreateRemainingComponents;

    procedure DisplayModifiedOnUpdateButton;
    procedure ResetUpdateColor;

    property Modified: Boolean read FModified write SetModified;
  public
    function FindPanelByName(AName: string): TPanel;
  end;

var
  frmSettings: TfrmSettings;

function EditMemStatOptions(var MemStatOptions: TMemStatOptions): Boolean;

implementation

{$IFDEF FPC}
  {$R *.frm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}

{$IFnDEF FPC}
  uses
    FileCtrl;
{$ENDIF}


const
  CDefaultColorPanelSize = 43; //px

procedure SetLabelColorsFromPanels;
var
  i: Integer;
  TempPanel: TPanel;
  TempLabel: TLabel;
begin
  for i := 0 to frmSettings.ComponentCount - 1 do
    if frmSettings.Components[i] is TPanel then
    begin
      TempPanel := frmSettings.Components[i] as TPanel;
      if (TempPanel.Width = CDefaultColorPanelSize) and (TempPanel.Height = CDefaultColorPanelSize) then
      begin
        TempLabel := TLabel(TempPanel.Tag);
        TempLabel.Color := TempPanel.Color; 
      end;
    end;
end;
  

function EditMemStatOptions(var MemStatOptions: TMemStatOptions): Boolean;
var
  i, j: Integer;
begin
  Result := False;
  Application.CreateForm(TfrmSettings, frmSettings);

  frmSettings.pnlFirstFileEntryChart.Color := MemStatOptions.Colors.FirstFileEntryChart;
  frmSettings.pnlSecondFileEntryChart.Color := MemStatOptions.Colors.SecondFileEntryChart;
  frmSettings.pnlThirdFileEntryChart.Color := MemStatOptions.Colors.ThirdFileEntryChart;
  frmSettings.pnlFourthFileEntryChart.Color := MemStatOptions.Colors.FourthFileEntryChart;

  frmSettings.pnlFirstFileSelectedEntryChart.Color := MemStatOptions.Colors.FirstFileSelectedEntryChart;
  frmSettings.pnlSecondFileSelectedEntryChart.Color := MemStatOptions.Colors.SecondFileSelectedEntryChart;
  frmSettings.pnlThirdFileSelectedEntryChart.Color := MemStatOptions.Colors.ThirdFileSelectedEntryChart;
  frmSettings.pnlFourthFileSelectedEntryChart.Color := MemStatOptions.Colors.FourthFileSelectedEntryChart;

  frmSettings.pnlOverlap.Color := MemStatOptions.Colors.Overlap;
  frmSettings.rdgrpColorType.ItemIndex := Ord(MemStatOptions.Colors.UseOverlapColor);

  frmSettings.pnlTextBackgroundChart.Color := MemStatOptions.Colors.TextBackgroundChart;
  frmSettings.pnlTextColorChart.Color := MemStatOptions.Colors.TextColorChart;
  
  frmSettings.pnlBackgroundChart.Color := MemStatOptions.Colors.BackgroundChart;
  frmSettings.pnlLineChart.Color := MemStatOptions.Colors.LineChart;

  frmSettings.chkDisplayDecimalAddressesCmpTable.Checked := MemStatOptions.Misc.DisplayDecimalAddressesCmpTable;
  frmSettings.chkDisplayTableHints.Checked := MemStatOptions.Misc.DisplayTableHints;
  frmSettings.chkShowDefsFolderOnMainWindow.Checked := MemStatOptions.Misc.ShowDefsFolderOnMainWindow;

  frmSettings.lbeDefaultChipName.Text := MemStatOptions.Misc.DefaultChipName;
  frmSettings.lbeDefFilePrefix.Text := MemStatOptions.Misc.DefFilePrefix;
  frmSettings.lbeExpectedPrefix.Text := MemStatOptions.Misc.ExpectedPrefix;
  frmSettings.cmbDeviceBitness.ItemIndex := Ord(MemStatOptions.Misc.DeviceBitness);
  frmSettings.lbeDefsFolder.Text := MemStatOptions.Misc.DefsFolder;
  frmSettings.rdgrpDefinitionFilePriority.ItemIndex := Ord(MemStatOptions.Misc.DefsFolderPriority);

  SetLength(frmSettings.FDevInfoEditArr, Length(MemStatOptions.DevInfoEditArr));
  for i := 0 to Length(MemStatOptions.DevInfoEditArr) - 1 do
  begin
    frmSettings.FDevInfoEditArr[i].Section.DisplayName := MemStatOptions.DevInfoEditArr[i].Section.DisplayName;
    frmSettings.FDevInfoEditArr[i].Section.LongDisplayName := MemStatOptions.DevInfoEditArr[i].Section.LongDisplayName;
    frmSettings.FDevInfoEditArr[i].Section.DefName := MemStatOptions.DevInfoEditArr[i].Section.DefName;

    SetLength(frmSettings.FDevInfoEditArr[i].Section.AddrRanges, Length(MemStatOptions.DevInfoEditArr[i].Section.AddrRanges));
    for j := 0 to Length(frmSettings.FDevInfoEditArr[i].Section.AddrRanges) - 1 do
      frmSettings.FDevInfoEditArr[i].Section.AddrRanges[j] := MemStatOptions.DevInfoEditArr[i].Section.AddrRanges[j];

    frmSettings.FDevInfoEditArr[i].MemoryTranslationInfo := MemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo;
    frmSettings.FDevInfoEditArr[i].AddressOffsets := MemStatOptions.DevInfoEditArr[i].AddressOffsets;
    frmSettings.FDevInfoEditArr[i].EntryColor := MemStatOptions.DevInfoEditArr[i].EntryColor;
    frmSettings.FDevInfoEditArr[i].SelectedEntryColor := MemStatOptions.DevInfoEditArr[i].SelectedEntryColor;
    frmSettings.FDevInfoEditArr[i].TableEntryColor := MemStatOptions.DevInfoEditArr[i].TableEntryColor;
    frmSettings.FDevInfoEditArr[i].TableTextColor := MemStatOptions.DevInfoEditArr[i].TableTextColor;
    frmSettings.FDevInfoEditArr[i].VisibleOnTable := MemStatOptions.DevInfoEditArr[i].VisibleOnTable;
    frmSettings.FDevInfoEditArr[i].VisibleOnCompare := MemStatOptions.DevInfoEditArr[i].VisibleOnCompare;
    frmSettings.FDevInfoEditArr[i].DisplayEvenIfMissingFromDefinition := MemStatOptions.DevInfoEditArr[i].DisplayEvenIfMissingFromDefinition;
  end;

  frmSettings.vstMemSections.RootNodeCount := Length(frmSettings.FDevInfoEditArr);

  frmSettings.UpdateColorBoxesFromPanels;
  SetLabelColorsFromPanels;

  frmSettings.ShowModal;
  if frmSettings.Tag = 1 then
  begin
    Result := True;

    MemStatOptions.Colors.FirstFileEntryChart := frmSettings.pnlFirstFileEntryChart.Color;
    MemStatOptions.Colors.SecondFileEntryChart := frmSettings.pnlSecondFileEntryChart.Color;
    MemStatOptions.Colors.ThirdFileEntryChart := frmSettings.pnlThirdFileEntryChart.Color;
    MemStatOptions.Colors.FourthFileEntryChart := frmSettings.pnlFourthFileEntryChart.Color;

    MemStatOptions.Colors.FirstFileSelectedEntryChart := frmSettings.pnlFirstFileSelectedEntryChart.Color;
    MemStatOptions.Colors.SecondFileSelectedEntryChart := frmSettings.pnlSecondFileSelectedEntryChart.Color;
    MemStatOptions.Colors.ThirdFileSelectedEntryChart := frmSettings.pnlThirdFileSelectedEntryChart.Color;
    MemStatOptions.Colors.FourthFileSelectedEntryChart := frmSettings.pnlFourthFileSelectedEntryChart.Color;

    MemStatOptions.Colors.Overlap := frmSettings.pnlOverlap.Color;
    MemStatOptions.Colors.UseOverlapColor := frmSettings.rdgrpColorType.ItemIndex = 1;

    MemStatOptions.Colors.TextBackgroundChart := frmSettings.pnlTextBackgroundChart.Color;
    MemStatOptions.Colors.TextColorChart := frmSettings.pnlTextColorChart.Color;

    MemStatOptions.Colors.BackgroundChart := frmSettings.pnlBackgroundChart.Color;
    MemStatOptions.Colors.LineChart := frmSettings.pnlLineChart.Color;

    MemStatOptions.Misc.DisplayDecimalAddressesCmpTable := frmSettings.chkDisplayDecimalAddressesCmpTable.Checked;
    MemStatOptions.Misc.DisplayTableHints := frmSettings.chkDisplayTableHints.Checked;
    MemStatOptions.Misc.ShowDefsFolderOnMainWindow := frmSettings.chkShowDefsFolderOnMainWindow.Checked;

    MemStatOptions.Misc.DefaultChipName := frmSettings.lbeDefaultChipName.Text;
    MemStatOptions.Misc.DefFilePrefix := frmSettings.lbeDefFilePrefix.Text;
    MemStatOptions.Misc.ExpectedPrefix := frmSettings.lbeExpectedPrefix.Text;
    MemStatOptions.Misc.DeviceBitness := TDeviceBitness(frmSettings.cmbDeviceBitness.ItemIndex);
    MemStatOptions.Misc.DefsFolder := frmSettings.lbeDefsFolder.Text;
    MemStatOptions.Misc.DefsFolderPriority := TDefsFolderPriority(frmSettings.rdgrpDefinitionFilePriority.ItemIndex);
    
    SetLength(MemStatOptions.DevInfoEditArr, Length(frmSettings.FDevInfoEditArr));
    for i := 0 to Length(MemStatOptions.DevInfoEditArr) - 1 do
    begin
      MemStatOptions.DevInfoEditArr[i].Section.DisplayName := frmSettings.FDevInfoEditArr[i].Section.DisplayName;
      MemStatOptions.DevInfoEditArr[i].Section.LongDisplayName := frmSettings.FDevInfoEditArr[i].Section.LongDisplayName;
      MemStatOptions.DevInfoEditArr[i].Section.DefName := frmSettings.FDevInfoEditArr[i].Section.DefName;

      SetLength(MemStatOptions.DevInfoEditArr[i].Section.AddrRanges, Length(frmSettings.FDevInfoEditArr[i].Section.AddrRanges));
      for j := 0 to Length(frmSettings.FDevInfoEditArr[i].Section.AddrRanges) - 1 do
        MemStatOptions.DevInfoEditArr[i].Section.AddrRanges[j] := frmSettings.FDevInfoEditArr[i].Section.AddrRanges[j];

      MemStatOptions.DevInfoEditArr[i].MemoryTranslationInfo := frmSettings.FDevInfoEditArr[i].MemoryTranslationInfo;
      MemStatOptions.DevInfoEditArr[i].AddressOffsets := frmSettings.FDevInfoEditArr[i].AddressOffsets;
      MemStatOptions.DevInfoEditArr[i].EntryColor := frmSettings.FDevInfoEditArr[i].EntryColor;
      MemStatOptions.DevInfoEditArr[i].SelectedEntryColor := frmSettings.FDevInfoEditArr[i].SelectedEntryColor;
      MemStatOptions.DevInfoEditArr[i].TableEntryColor := frmSettings.FDevInfoEditArr[i].TableEntryColor;
      MemStatOptions.DevInfoEditArr[i].TableTextColor := frmSettings.FDevInfoEditArr[i].TableTextColor;

      MemStatOptions.DevInfoEditArr[i].VisibleOnTable := frmSettings.FDevInfoEditArr[i].VisibleOnTable;
      MemStatOptions.DevInfoEditArr[i].VisibleOnCompare := frmSettings.FDevInfoEditArr[i].VisibleOnCompare;
      MemStatOptions.DevInfoEditArr[i].DisplayEvenIfMissingFromDefinition := frmSettings.FDevInfoEditArr[i].DisplayEvenIfMissingFromDefinition;
    end;

    if Length(MemStatOptions.Colors.EntryColorArr) <> Length(MemStatOptions.DevInfoEditArr) then
    begin
      SetLength(MemStatOptions.Colors.EntryColorArr, Length(MemStatOptions.DevInfoEditArr));
      SetLength(MemStatOptions.Colors.SelectedEntryColorArr, Length(MemStatOptions.DevInfoEditArr));
      SetLength(MemStatOptions.Colors.EntryColorTableArr, Length(MemStatOptions.DevInfoEditArr));
      SetLength(MemStatOptions.Colors.TextColorTableArr, Length(MemStatOptions.DevInfoEditArr));
    end;

    for i := 0 to Length(MemStatOptions.DevInfoEditArr) - 1 do
    begin
      MemStatOptions.Colors.EntryColorArr[i] := MemStatOptions.DevInfoEditArr[i].EntryColor;
      MemStatOptions.Colors.SelectedEntryColorArr[i] := MemStatOptions.DevInfoEditArr[i].SelectedEntryColor;
      MemStatOptions.Colors.EntryColorTableArr[i] := MemStatOptions.DevInfoEditArr[i].TableEntryColor;
      MemStatOptions.Colors.TextColorTableArr[i] := MemStatOptions.DevInfoEditArr[i].TableTextColor;
    end;
  end;
end;


procedure TfrmSettings.SetModified(Value: Boolean);
begin
  if FModified <> Value then
  begin
    FModified := Value;
    btnOK.Enabled := True;
  end
  else
    ResetUpdateColor;
end;


procedure TfrmSettings.DisplayModifiedOnUpdateButton;
begin
  bitbtnUpdate.Font.Color := clRed;
  bitbtnUpdate.Font.Style := [fsBold];
  tmrUpdate.Tag := 1;
  tmrUpdate.Enabled := True;
end;


procedure TfrmSettings.ResetUpdateColor;
begin
  bitbtnUpdate.Font.Color := clWindowText;
  bitbtnUpdate.Font.Style := [];
  tmrUpdate.Enabled := False;
end;


//this function should always return a panel, nevel nil
function TfrmSettings.FindPanelByName(AName: string): TPanel;
var
  i: Integer;
begin
  Result := nil; //if this function returns nil, then there is a component with a wrong name format
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TPanel then
      if (Components[i] as TPanel).Name = AName then
      begin
        Result := Components[i] as TPanel;
        Break;
      end;
end;


//'colboxPFMEntryChart' to 'pnlPFMEntryChart'
function ColorBoxName_To_PanelName(s: string): string;
begin
  Delete(s, 1, 6);
  Result := 'pnl' + s;
end;


procedure TfrmSettings.btnAddClick(Sender: TObject);
begin
  if Trim(lbeDefinitionName.Text) = '' then
  begin
    MessageBox(Handle, 'Please enter a valid string for definition name.', PChar(Application.Title), MB_ICONINFORMATION);
    Exit;
  end;

  SetLength(FDevInfoEditArr, Length(FDevInfoEditArr) + 1);
  vstMemSections.RootNodeCount := Length(FDevInfoEditArr);
  vstMemSections.Selected[vstMemSections.GetLast] := True;
  UpdateSelectedMemorySectionFromControls;

  vstMemSections.Repaint;
  ResetUpdateColor;
  Modified := True;
end;



procedure TfrmSettings.btnDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  i: Integer;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
  begin
    MessageBox(Handle, 'Please select a memory item to be removed.', PChar(Application.Title), MB_ICONINFORMATION);
    Exit;
  end;

  if MessageBox(Handle, 'Are you sure you want to remove the selected item?', PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = IDNO then
    Exit;

  for i := Node^.Index to Length(FDevInfoEditArr) - 1 do
    FDevInfoEditArr[i] := FDevInfoEditArr[i + 1];

  SetLength(FDevInfoEditArr, Length(FDevInfoEditArr) - 1);
  vstMemSections.RootNodeCount := Length(FDevInfoEditArr);

  vstMemSections.Repaint;
  ResetUpdateColor;
  Modified := True;
end;


procedure TfrmSettings.btnUpdateClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
  begin
    MessageBox(Handle, 'Please select a memory item to be edited.', PChar(Application.Title), MB_ICONINFORMATION);
    Exit;
  end;

  if Trim(lbeDefinitionName.Text) = '' then
  begin
    MessageBox(Handle, 'Please enter a valid string for definition name.', PChar(Application.Title), MB_ICONINFORMATION);
    Exit;
  end;

  UpdateSelectedMemorySectionFromControls;
  vstMemSections.Repaint;
  ResetUpdateColor;
  Modified := True;
end;


procedure TfrmSettings.btnOKClick(Sender: TObject);
begin
  if fsBold in bitbtnUpdate.Font.Style then
    if MessageBox(Handle, 'One of the sections is not updated. ' +
                          'If you close the window now, the new setting is going to be discarded. ' +
                          'Continue closing without updating?',
                  PChar(Application.Title),
                  MB_ICONQUESTION + MB_YESNO) = IDNO then
      Exit;

  Tag := 1;
  Close;
end;


procedure TfrmSettings.btnBrowseDefsFolderClick(Sender: TObject);
var
  ADir: string;
begin
  ADir := lbeDefsFolder.Text;
  {$IFDEF FPC}
    if SelectDirectory('"Defs" Folder', '', ADir) then
  {$ELSE}
    if SelectDirectory('"Defs" Folder', '', ADir, [sdNewFolder, sdShowEdit, sdShowShares, sdNewUI, sdValidateDir], Self) then
  {$ENDIF}
    begin
      lbeDefsFolder.Text := ADir;
      Modified := True;
    end;
end;


procedure TfrmSettings.btnCancelClick(Sender: TObject);
begin
  Tag := 0;
  Close;
end;


procedure TfrmSettings.chkDisplayDecimalAddressesCmpTableKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    Modified := True;
end;


procedure TfrmSettings.chkDisplayDecimalAddressesCmpTableMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Modified := True;
end;


procedure TfrmSettings.chkDisplayEvenIfMissingFromDefinitionKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkDisplayEvenIfMissingFromDefinitionMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkDisplayTableHintsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_SPACE then
    Modified := True;
end;


procedure TfrmSettings.chkDisplayTableHintsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Modified := True;
end;


procedure TfrmSettings.chkShowDefsFolderOnMainWindowKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkShowDefsFolderOnMainWindowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkVisibleOnCompareKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_SPACE then
    DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkVisibleOnCompareMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkVisibleOnTableKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_SPACE then
    DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.chkVisibleOnTableMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.cmbDeviceBitnessChange(Sender: TObject);
begin
  Modified := True;
end;


procedure TfrmSettings.cmbMemoryTranslationInfoOperationChange(Sender: TObject);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.colboxGenericChange(Sender: TObject);
var
  PanelToChange: TPanel;
  TempLabel: TLabel;
begin
  PanelToChange := FindPanelByName(ColorBoxName_To_PanelName((Sender as TColorBox).Name));
  PanelToChange.Color := (Sender as TColorBox).Selected;

  if pagctrlSettings.ActivePage = TabSheetMemorySections then
    DisplayModifiedOnUpdateButton
  else
    Modified := True;

  TempLabel := TLabel(PanelToChange.Tag);
  if TempLabel <> nil then
    TempLabel.Color := (Sender as TColorBox).Selected;
end;


procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfrmSettings.CreateRemainingComponents;
var
  NewColum: TVirtualTreeColumn;
begin
  vstMemSections := TVirtualStringTree.Create(Self);
  vstMemSections.Parent := TabSheetMemorySections;

  vstMemSections.Font.Charset := DEFAULT_CHARSET;
  vstMemSections.Font.Color := clWindowText;
  vstMemSections.Font.Height := -11;
  vstMemSections.Font.Name := 'Tahoma';
  vstMemSections.Font.Style := [];
  vstMemSections.Left := lbeDisplayName.Left;
  vstMemSections.Top := 4;
  vstMemSections.Width := grpTable.Left + grpTable.Width - 3;
  vstMemSections.Height := lbeDisplayName.Top - 36;
  vstMemSections.Anchors := [akLeft, akTop, akRight, akBottom];
  vstMemSections.Colors.UnfocusedSelectionColor := clInactiveCaption;
  vstMemSections.DefaultNodeHeight := 36;
  vstMemSections.Header.AutoSizeIndex := 0;
  vstMemSections.Header.DefaultHeight := 21;
  vstMemSections.Header.Font.Charset := DEFAULT_CHARSET;
  vstMemSections.Header.Font.Color := clWindowText;
  vstMemSections.Header.Font.Height := -11;
  vstMemSections.Header.Font.Name := 'Tahoma';
  vstMemSections.Header.Font.Style := [];
  vstMemSections.Header.Height := 21;
  vstMemSections.Header.Options := [hoColumnResize, hoDblClickResize, hoDrag, hoShowHint, hoShowSortGlyphs, hoVisible];
  vstMemSections.Header.Style := hsFlatButtons;
  vstMemSections.StateImages := imglstMemSections;
  vstMemSections.TabOrder := 0;
  vstMemSections.TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus];
  vstMemSections.TreeOptions.PaintOptions := [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages];
  vstMemSections.TreeOptions.SelectionOptions := [toFullRowSelect];
  vstMemSections.OnAfterCellPaint := vstMemSectionsAfterCellPaint;
  vstMemSections.OnGetText := vstMemSectionsGetText;
  vstMemSections.OnGetImageIndex := vstMemSectionsGetImageIndex;
  vstMemSections.OnKeyUp := vstMemSectionsKeyUp;
  vstMemSections.OnMouseUp := vstMemSectionsMouseUp;

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 90;
  NewColum.Position := 0;
  NewColum.Width := 90;
  NewColum.Text := 'Display Name';
  NewColum.Hint := 'Displayed in table entries';
  NewColum.Options := [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coFixed, coAllowFocus];

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 150;
  NewColum.Position := 1;
  NewColum.Width := 150;
  NewColum.Text := 'Long Display Name';
  NewColum.Hint := 'Displayed in table entries';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 108;
  NewColum.Position := 2;
  NewColum.Width := 108;
  NewColum.Text := 'Definition Name';
  NewColum.Hint := 'Section name as used by tags in definition files';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 136;
  NewColum.Position := 3;
  NewColum.Width := 136;
  NewColum.Text := 'Mem Translation Info';
  NewColum.Hint := 'Operation and constant value, used to identify memory section';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 108;
  NewColum.Position := 4;
  NewColum.Width := 108;
  NewColum.Text := 'Address Offsets';
  NewColum.Hint := 'Section specific address offsets';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 128;
  NewColum.Position := 5;
  NewColum.Width := 128;
  NewColum.Text := 'Default Addr Range';
  NewColum.Hint := 'Default address range, used when a section is not found in definition file';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 120;
  NewColum.Position := 6;
  NewColum.Width := 120;
  NewColum.Text := 'Entry Color (chart)';
  NewColum.Hint := 'Displayed in table entries';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 174;
  NewColum.Position := 7;
  NewColum.Width := 174;
  NewColum.Text := 'Selected Entry Color (chart)';
  NewColum.Hint := '';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 120;
  NewColum.Position := 8;
  NewColum.Width := 120;
  NewColum.Text := 'Entry Color (table)';
  NewColum.Hint := '';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 120;
  NewColum.Position := 9;
  NewColum.Width := 120;
  NewColum.Text := 'Text Color (table)';
  NewColum.Hint := '';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 166;
  NewColum.Position := 10;
  NewColum.Width := 166;
  NewColum.Text := 'Visible on table / compare';
  NewColum.Hint := '';

  NewColum := vstMemSections.Header.Columns.Add;
  NewColum.MinWidth := 250;
  NewColum.Position := 11;
  NewColum.Width := 250;
  NewColum.Text := 'Display even if missing from definition';
  NewColum.Hint := '';
end;


procedure TfrmSettings.FormCreate(Sender: TObject);
var
  i: Integer;
  TempPanel: TPanel;
  TempLabel: TLabel;
begin
  CreateRemainingComponents;

  for i := 0 to ComponentCount - 1 do
    if Components[i] is TPanel then
    begin
      if Pos('Color', (Components[i] as TPanel).Name) > 0 then
      begin
        TempPanel := Components[i] as TPanel;
        TempPanel.Hint := 'Double click to edit...';
      end;

      if ((Components[i] as TPanel).Width = 43) and ((Components[i] as TPanel).Width = 43) then  ////////////////// find a better way to identify color panels
      begin
        TempPanel := Components[i] as TPanel;
        TempPanel.Hint := 'Double click to edit...';

        TempLabel := TLabel.Create(Self);
        TempLabel.Parent := TempPanel;
        TempLabel.Name := 'ColorLabel_' + TempPanel.Name;
        TempLabel.Left := 0;
        TempLabel.Top := 0;
        TempLabel.Width := TempPanel.Width;
        TempLabel.Height := TempPanel.Height;
        TempLabel.Transparent := False;
        TempLabel.AutoSize := False;
        TempLabel.Visible := True;
        TempLabel.ParentColor := False;
        TempLabel.Color := clGreen;
        TempLabel.Caption := '';
        TempLabel.OnDblClick := GenericColorPanelDblClick;

        TempPanel.Tag := Int64(TempLabel);

        TempPanel.Font.Color := clRed;
        TempPanel.Caption := TempPanel.Name;
      end;
    end;

  Tag := 0;
  FModified := False;
  FUpdateIndicationDir := True;
  FPrevSelectedNode := nil;

  lbeDefinitionName.Hint := lbeDefinitionName.Hint + #13#10 + 'Misc info for EBI/SQI on PIC32:' + #13#10 +
                               'MemStatistics uses this name to search for the EBI address range in definition file.'#13#10 +
                               '.Mlk file - section example:'#13#10#13#10 +
                               '  <EBIROM>'#13#10 +
                               '    <MIN_ADDR>0x20000000</MIN_ADDR>'#13#10 +
                               '    <MAX_ADDR>0x204FFFFF</MAX_ADDR>'#13#10 +
                               '  </EBIROM>'#13#10#13#10#13#10 +
                               '.Json file - section example:'#13#10#13#10 +

                               '"ebirom": {'#13#10 +
                               '   "max_addr": "0x204FFFFF",'#13#10 +
                               '   "min_addr": "0x20000000"'#13#10 +
                               '},'#13#10#13#10 +

                              'MemStatistics uses this name to search for the SQI address range in definition file.'#13#10 +
                               '.Mlk file - section example:'#13#10#13#10 +
                               '  <SQIROM>'#13#10 +
                               '    <MIN_ADDR>0x30000000</MIN_ADDR>'#13#10 +
                               '    <MAX_ADDR>0x304FFFFF</MAX_ADDR>'#13#10 +
                               '  </SQIROM>'#13#10#13#10#13#10 +
                               '.Json file - section example:'#13#10#13#10 +

                               '"sqirom": {'#13#10 +
                               '   "max_addr": "0x304FFFFF",'#13#10 +
                               '   "min_addr": "0x30000000"'#13#10 +
                               '},';

  lbeMemoryTranslationInfoValue.Hint := 'Start address, depending on operation.'#13#10 +
                                        'On PIC32 this can be 0x9D000000 for PFM, 0xA0000000 for RAM, 0xBFC00000 for BFM and CFG etc.';

  rdgrpDefinitionFilePriority.Hint := 'Which type of file to search for: mlk/json or local device list (ini).' + #13#10 +
                                      'When a device is not found at the first location, it is then searched on the other.';  
end;


procedure TfrmSettings.FormShow(Sender: TObject);
begin
  pagctrlColors.ActivePageIndex := 0;
  pagctrlSettings.ActivePageIndex := 0;
end;


procedure TfrmSettings.GenericColorPanelDblClick(Sender: TObject);
var
  TempPanel: TPanel;
begin
  if Sender is TPanel then
    TempPanel := Sender as TPanel
  else
    if Sender is TLabel then
      TempPanel := ((Sender as TLabel).Parent) as TPanel
    else
      Exit;

  ColorDialog1.Color := TempPanel.Color;

  if not ColorDialog1.Execute then
    Exit;

  TempPanel.Color := ColorDialog1.Color;
  if Sender is TLabel then
    (Sender as TLabel).Color := ColorDialog1.Color;

  if pagctrlSettings.ActivePage = TabSheetMemorySections then
    DisplayModifiedOnUpdateButton
  else
    Modified := True;
end;


procedure TfrmSettings.GenericLabeledEditChange(Sender: TObject);
begin
  DisplayModifiedOnUpdateButton;
end;


procedure TfrmSettings.lbeDefaultChipNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    Modified := True;
end;


procedure TfrmSettings.lbeDefFilePrefixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    Modified := True;
end;


procedure TfrmSettings.lbeDefsFolderKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    Modified := True;
end;


procedure TfrmSettings.lbeExpectedPrefixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    Modified := True;
end;


procedure TfrmSettings.rdgrpColorTypeClick(Sender: TObject);
begin
  pnlOverlap.Visible := rdgrpColorType.ItemIndex = 1;     
  colboxOverlap.Visible := rdgrpColorType.ItemIndex = 1;
  Modified := True;
end;


procedure TfrmSettings.rdgrpDefinitionFilePriorityClick(Sender: TObject);
begin
  Modified := True;
end;


procedure TfrmSettings.UpdateColorBoxesFromPanels;
var
  PanelToChange: TPanel;
  CurrentColorBox: TColorBox;
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TColorBox then
  begin
    CurrentColorBox := Components[i] as TColorBox;
    PanelToChange := FindPanelByName(ColorBoxName_To_PanelName(CurrentColorBox.Name));
    CurrentColorBox.Selected := PanelToChange.Color;
  end;
end;



procedure TfrmSettings.vstMemSectionsAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  {$IFDEF FPC}const{$ENDIF} CellRect: TRect);
begin
  case Column of
    6:
    begin
      TargetCanvas.Pen.Color := FDevInfoEditArr[Node^.Index].EntryColor;
      TargetCanvas.Brush.Color := TargetCanvas.Pen.Color;
      TargetCanvas.Rectangle(CellRect.Left + 1, CellRect.Top + 1, CellRect.Left + 32 + 1, CellRect.Bottom - 1);
    end;

    7:
    begin
      TargetCanvas.Pen.Color := FDevInfoEditArr[Node^.Index].SelectedEntryColor;
      TargetCanvas.Brush.Color := TargetCanvas.Pen.Color;
      TargetCanvas.Rectangle(CellRect.Left + 1, CellRect.Top + 1, CellRect.Left + 32 + 1, CellRect.Bottom - 1);
    end;

    8:
    begin
      TargetCanvas.Pen.Color := FDevInfoEditArr[Node^.Index].TableEntryColor;
      TargetCanvas.Brush.Color := TargetCanvas.Pen.Color;
      TargetCanvas.Rectangle(CellRect.Left + 1, CellRect.Top + 1, CellRect.Left + 32 + 1, CellRect.Bottom - 1);
    end;

    9:
    begin
      TargetCanvas.Pen.Color := FDevInfoEditArr[Node^.Index].TableTextColor;
      TargetCanvas.Brush.Color := TargetCanvas.Pen.Color;
      TargetCanvas.Rectangle(CellRect.Left + 1, CellRect.Top + 1, CellRect.Left + 32 + 1, CellRect.Bottom - 1);
    end;
  end;
end;


procedure TfrmSettings.vstMemSectionsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  Ghosted := True;
  if Column in [6..9] then
    ImageIndex := 0;
end;


procedure TfrmSettings.vstMemSectionsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: {$IFDEF FPC}string{$ELSE}WideString{$ENDIF});
const
  CAddressTranslationOperation: array[TAddressTranslationOperation] of string = ('None', 'ADD', 'OR');
  CBoolToStr: array[Boolean] of string = ('No', 'Yes');
begin
  case Column of
    0: CellText := FDevInfoEditArr[Node^.Index].Section.DisplayName;
    1: CellText := FDevInfoEditArr[Node^.Index].Section.LongDisplayName;
    2: CellText := FDevInfoEditArr[Node^.Index].Section.DefName;
    3: CellText := CAddressTranslationOperation[FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Operation] + ' 0x' + IntToHex(FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Value, 8);
    4: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].AddressOffsets.S1, 8) + ', 0x' + IntToHex(FDevInfoEditArr[Node^.Index].AddressOffsets.S2, 8);
    5: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].DefaultAddrRange.MinAddr, 8) + ' 0x' + IntToHex(FDevInfoEditArr[Node^.Index].DefaultAddrRange.MaxAddr, 8);
    6: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].EntryColor, 8);
    7: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].SelectedEntryColor, 8);
    8: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].TableEntryColor, 8);
    9: CellText := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].TableTextColor, 8);
    10: CellText := CBoolToStr[FDevInfoEditArr[Node^.Index].VisibleOnTable] + ' / ' + CBoolToStr[FDevInfoEditArr[Node^.Index].VisibleOnCompare];
    11: CellText := CBoolToStr[FDevInfoEditArr[Node^.Index].DisplayEvenIfMissingFromDefinition];
  end;
end;




procedure TfrmSettings.UpdateSelectedMemorySectionFromControls;
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
    Exit;

  FDevInfoEditArr[Node^.Index].Section.DisplayName := lbeDisplayName.Text;
  FDevInfoEditArr[Node^.Index].Section.LongDisplayName := lbeLongDisplayName.Text;
  FDevInfoEditArr[Node^.Index].Section.DefName := lbeDefinitionName.Text;
  FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Operation := TAddressTranslationOperation(cmbMemoryTranslationInfoOperation.ItemIndex);
  FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Value := HexToInt(lbeMemoryTranslationInfoValue.Text);
  FDevInfoEditArr[Node^.Index].AddressOffsets.S1 := HexToInt(lbeAddressOffsetS1.Text);
  FDevInfoEditArr[Node^.Index].AddressOffsets.S2 := HexToInt(lbeAddressOffsetS2.Text);
  FDevInfoEditArr[Node^.Index].DefaultAddrRange.MinAddr := HexToInt(lbeMinDefaultAddr.Text);
  FDevInfoEditArr[Node^.Index].DefaultAddrRange.MaxAddr := HexToInt(lbeMaxDefaultAddr.Text);

  FDevInfoEditArr[Node^.Index].EntryColor := pnlEntryChart.Color;
  FDevInfoEditArr[Node^.Index].SelectedEntryColor := pnlSelectedEntryChart.Color;
  FDevInfoEditArr[Node^.Index].TableEntryColor := pnlEntryColorTable.Color;
  FDevInfoEditArr[Node^.Index].TableTextColor := pnlTextColorTable.Color;

  FDevInfoEditArr[Node^.Index].VisibleOnTable := chkVisibleOnTable.Checked;
  FDevInfoEditArr[Node^.Index].VisibleOnCompare := chkVisibleOnCompare.Checked;
  FDevInfoEditArr[Node^.Index].DisplayEvenIfMissingFromDefinition := chkDisplayEvenIfMissingFromDefinition.Checked;
end;


procedure TfrmSettings.SetControlsFromSelectedMemorySection;
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
    Exit;

  if (FPrevSelectedNode <> nil) and (fsBold in bitbtnUpdate.Font.Style) then
    if MessageBox(Handle,
                  PChar('There are changed properties for the selected section. ' +
                        'By selecting another section, you will discard those changes. ' +
                        'You can click Update to record the changes to the list.' + #13#10#13#10 +
                        'Go back to previous action/content?'),
                  PChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = IDYES then
    begin
      vstMemSections.Selected[FPrevSelectedNode] := True;
      Exit;
    end;

  FPrevSelectedNode := Node;

  lbeDisplayName.Text := FDevInfoEditArr[Node^.Index].Section.DisplayName;
  lbeLongDisplayName.Text := FDevInfoEditArr[Node^.Index].Section.LongDisplayName;
  lbeDefinitionName.Text := FDevInfoEditArr[Node^.Index].Section.DefName;
  cmbMemoryTranslationInfoOperation.ItemIndex := Ord(FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Operation);
  lbeMemoryTranslationInfoValue.Text := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].MemoryTranslationInfo.Value, 8);
  lbeAddressOffsetS1.Text := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].AddressOffsets.S1, 8);
  lbeAddressOffsetS2.Text := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].AddressOffsets.S2, 8);
  lbeMinDefaultAddr.Text := '0x' + IntToHex(FDevInfoEditArr[Node^.Index].DefaultAddrRange.MinAddr, 8);
  lbeMaxDefaultAddr.Text := ' 0x' + IntToHex(FDevInfoEditArr[Node^.Index].DefaultAddrRange.MaxAddr, 8);

  pnlEntryChart.Color := FDevInfoEditArr[Node^.Index].EntryColor;
  pnlSelectedEntryChart.Color := FDevInfoEditArr[Node^.Index].SelectedEntryColor;
  pnlEntryColorTable.Color := FDevInfoEditArr[Node^.Index].TableEntryColor;
  pnlTextColorTable.Color := FDevInfoEditArr[Node^.Index].TableTextColor;

  SetLabelColorsFromPanels;

  chkVisibleOnTable.Checked := FDevInfoEditArr[Node^.Index].VisibleOnTable;
  chkVisibleOnCompare.Checked := FDevInfoEditArr[Node^.Index].VisibleOnCompare;
  chkDisplayEvenIfMissingFromDefinition.Checked := FDevInfoEditArr[Node^.Index].DisplayEvenIfMissingFromDefinition;

  UpdateColorBoxesFromPanels;
  ResetUpdateColor;
end;


procedure SwapStrings(var s1, s2: string);
var
  ph: string;
begin
  ph := s1;
  s1 := s2;
  s2 := ph;
end;


procedure SwapIntegers(var i1, i2: Integer);
var
  ph: Integer;
begin
  ph := i1;
  i1 := i2;
  i2 := ph;
end;


procedure SwapTColors(var i1, i2: TColor);
var
  ph: Integer;
begin
  ph := i1;
  i1 := i2;
  i2 := ph;
end;


procedure SwapDefSectionAddrRangeArr(var r1, r2: TDefSectionAddrRangeArr);      //probably it would be safe to swap pointers, but better swap the whole arrays
var
  ph: TDefSectionAddrRangeArr;
  i: Integer;
begin
  //ph := r1;
  SetLength(ph, Length(r1));
  for i := 0 to Length(ph) - 1 do
    ph[i] := r1[i];

  //r1 := r2;
  SetLength(r1, Length(r2));
  for i := 0 to Length(r1) - 1 do
    r1[i] := r2[i];

  //r2 := ph;
  SetLength(r2, Length(ph));
  for i := 0 to Length(r2) - 1 do
    r2[i] := ph[i];
end;


procedure SwapDefSectionAddrRange(var a1, a2: TDefSectionAddrRange);
var
  ph: TDefSectionAddrRange;
begin
  ph := a1;
  a1 := a2;
  a2 := ph;
end;


procedure SwapMemoryTranslationInfo(var m1, m2: TMemoryTranslationInfo);
var
  ph: TMemoryTranslationInfo;
begin
  ph := m1;
  m1 := m2;
  m2 := ph;
end;


procedure SwapBooleans(var a1, a2: Boolean);
var
  ph: Boolean;
begin
  ph := a1;
  a1 := a2;
  a2 := ph;
end;


procedure TfrmSettings.SwapSections(Idx1, Idx2: Integer);
begin
  SwapStrings(FDevInfoEditArr[Idx1].Section.DisplayName, FDevInfoEditArr[Idx2].Section.DisplayName);
  SwapStrings(FDevInfoEditArr[Idx1].Section.LongDisplayName, FDevInfoEditArr[Idx2].Section.LongDisplayName);
  SwapStrings(FDevInfoEditArr[Idx1].Section.DefName, FDevInfoEditArr[Idx2].Section.DefName);
  SwapDefSectionAddrRangeArr(FDevInfoEditArr[Idx1].Section.AddrRanges, FDevInfoEditArr[Idx2].Section.AddrRanges);  //probably not needed here
  
  SwapIntegers(FDevInfoEditArr[Idx1].AddressOffsets.S1, FDevInfoEditArr[Idx2].AddressOffsets.S1);
  SwapIntegers(FDevInfoEditArr[Idx1].AddressOffsets.S2, FDevInfoEditArr[Idx2].AddressOffsets.S2);
  SwapDefSectionAddrRange(FDevInfoEditArr[Idx1].DefaultAddrRange, FDevInfoEditArr[Idx2].DefaultAddrRange);
  SwapMemoryTranslationInfo(FDevInfoEditArr[Idx1].MemoryTranslationInfo, FDevInfoEditArr[Idx2].MemoryTranslationInfo);

  SwapTColors(FDevInfoEditArr[Idx1].EntryColor, FDevInfoEditArr[Idx2].EntryColor);
  SwapTColors(FDevInfoEditArr[Idx1].SelectedEntryColor, FDevInfoEditArr[Idx2].SelectedEntryColor);
  SwapTColors(FDevInfoEditArr[Idx1].TableEntryColor, FDevInfoEditArr[Idx2].TableEntryColor);
  SwapTColors(FDevInfoEditArr[Idx1].TableTextColor, FDevInfoEditArr[Idx2].TableTextColor);
  SwapBooleans(FDevInfoEditArr[Idx1].VisibleOnCompare, FDevInfoEditArr[Idx2].VisibleOnCompare);
end;


procedure TfrmSettings.tmrUpdateTimer(Sender: TObject);
const
  clDarkGreen = TColor($004000);    //64 shl 8
begin
  if FUpdateIndicationDir then
  begin
    tmrUpdate.Tag := tmrUpdate.Tag + 1;
    if tmrUpdate.Tag > 32 then
      FUpdateIndicationDir := False;
  end
  else
  begin
    tmrUpdate.Tag := tmrUpdate.Tag - 1;
    if tmrUpdate.Tag < -32 then
      FUpdateIndicationDir := True;
  end;

  //Adding (clMaroon + Tag shl 2) results in a range of clBlack to clRed
  //Adding (clDarkGreen + Tag shl 1) results in a part of clLime
  //combining these two, should result in a slight orange text color
  bitbtnUpdate.Font.Color := (clMaroon + tmrUpdate.Tag {shl 2} * 4) or (clDarkGreen + tmrUpdate.Tag {shl 1} * 2);
end;


procedure TfrmSettings.spdbtnMoveUpClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
    Exit;

  if Node^.Index = 0 then
    Exit;

  SwapSections(Node^.Index, Node^.Index - 1);
  Node := Node^.PrevSibling;
  vstMemSections.Selected[Node] := True;
  vstMemSections.Repaint;
  Modified := True;
end;


procedure TfrmSettings.spdbtnMoveDownClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;
  if Node = nil then
    Exit;

  if Node^.Index = vstMemSections.GetLast.Index then
    Exit;

  SwapSections(Node^.Index, Node^.Index + 1);
  Node := Node^.NextSibling;
  vstMemSections.Selected[Node] := True;
  vstMemSections.Repaint;
  Modified := True;
end;


procedure TfrmSettings.vstMemSectionsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;

  if FPrevSelectedNode <> Node then
    SetControlsFromSelectedMemorySection;
end;


procedure TfrmSettings.vstMemSectionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: PVirtualNode;
begin
  Node := vstMemSections.GetFirstSelected;

  if FPrevSelectedNode <> Node then
    SetControlsFromSelectedMemorySection;
end;

end.
