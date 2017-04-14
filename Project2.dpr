library Project2;

{
  EX-Offensive Hack:
  Версия: 0.1, в стадии разработки.
  Ve4niySooN
}

uses
  SysUtils, Classes, Windows, EXO_Main, EXO_Offsets, EXO_Drawing,
  EXO_Hooking, EXO_Settings;

{$R *.res}

procedure EXO_Render;
begin
  if EXO_PlayerInfo then
  begin
    if Sys.ESPBox.Enabled   then EXO_ESPBox;
    if Sys.Aimbot.Enabled   then EXO_Aimbot;
    if Sys.Trigger.Enabled  then EXO_Trigger;
  end;
end;

begin
  // нужно создать поток. иначе игра повесится.
  if not EXO_GetModuleInfo then ErrorMsg(mSModule) else
  begin
    while True do
    begin
      EXO_HookEngine;
      EXO_Render;
    end;
  end;
end.


