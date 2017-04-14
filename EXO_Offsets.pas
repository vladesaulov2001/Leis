unit EXO_Offsets;

interface

uses SysUtils, Windows;

// OFFSETS:

const

  oTeam       = $F0;
  oDent       = $10;
  oEntID      = $64;
  oX          = $134;
  oY          = $138;
  oZ          = $13C;
  oHealth     = $FC;
  oFlags      = $100;

  owAngPtr: Cardinal    = $2380;


  mSModule = 'Search failed: required modules not found.';
  mWMemory = 'Action failed: error writing in memory.';
  mRMemory = 'Action failed: error reading in memory.';
  mCConfig = 'Action failed: error reading settings file.';


type
  select_type = record
    Enabled:  Boolean;
    Value:    Cardinal;
end;

type
  color_type = record
    R, G, B:      Byte;
    wR, wG, wB:   Byte;
end;

type
  patching_type = record
    ESPBox, Aimbot, Trigger: select_type;
end;

type
  vec3_type = record
    x, y, z: Single;
end;

type
  player_type = record
    Validate: boolean;
    Team, Health, iCount, fFlags: Integer;
    ScreenPos: array [1..2] of Integer;
    Origin, Angles: vec3_type;
    Color: color_type;
end;

var
  Thread, Handle, Window, Process: Integer;
  dwClient, dwOpenGL, dwEngine, dwPBase, dwEntity, dwBase, dwAngPtr: Cardinal;
  iEnemies: array [0..64] of Integer;
  iCount: Integer;
  Sys: patching_type;
  LocalPlayer, TempPlayer:    player_type;
  Player:   array [0..64] of player_type;

  owPBase:  Cardinal    = $A187CC;
  oEntity:  Cardinal    = $A89444;
  oW2S_M:   Cardinal    = $9A2954;

implementation

end.
