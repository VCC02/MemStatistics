program MemStatistics;

uses
  Forms,
  MemStatisticsMain in 'MemStatisticsMain.pas' {frmMemStatisticsMain},
  SettingsForm in 'SettingsForm.pas' {frmSettings},
  MikroStuff in 'MikroStuff.pas',
  MemTables in 'MemTables.pas',
  MemStatUtils in 'MemStatUtils.pas',
  MemStatCompareForm in 'MemStatCompareForm.pas' {frmMemStatCompare},
  DevicesForm in 'DevicesForm.pas' {frmDevices},
  MiniMap in 'Common\MiniMap.pas',
  DefParser in 'DefParser.pas',
  DeviceInfo in 'Common\DeviceInfo.pas',
  ClickerZoomPreviewForm in '..\MiscUtils\ClickerZoomPreviewForm.pas' {frmClickerZoomPreview},
  SimulatedMemForm in 'SimulatedMemForm.pas' {frmSimulatedMem},
  PollingFIFO in '..\MiscUtils\PollingFIFO.pas',
  SimpleCOM in '..\MiscUtils\SimpleCOM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMemStatisticsMain, frmMemStatisticsMain);
  Application.CreateForm(TfrmClickerZoomPreview, frmClickerZoomPreview);
  Application.CreateForm(TfrmSimulatedMem, frmSimulatedMem);
  Application.Run;
end.
