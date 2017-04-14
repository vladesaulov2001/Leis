unit EXO_Hooking;

interface

uses SysUtils, Windows, TlHelp32, EXO_Offsets, EXO_Drawing;

function Hook_GetValue(Addr, Prt, Size: Cardinal): Cardinal;
function Hook_GetPoint(Addr: Cardinal; Size: Integer): Cardinal;
function Hook_W2SPoint(Addr: Cardinal; Size: Integer): WorldToScreenMatrix_t;

function Hook_SetValue(Addr, Value, Size: Cardinal): Boolean;
function IsValidValue(Max, Cur: Cardinal): Boolean;
procedure ErrorMsg(msg: PChar);

implementation

function Hook_GetPoint(Addr: Cardinal; Size: Integer): Cardinal;
var
  TempResult, TempRead: Cardinal;
begin
  ReadProcessMemory(Handle, Ptr(Addr), @TempResult, Size, TempRead);
  Result := TempResult;
end;

function Hook_W2SPoint(Addr: Cardinal; Size: Integer): WorldToScreenMatrix_t;
var
  TempRead: Cardinal;
begin
  ReadProcessMemory(Handle, Ptr(Addr), @Result, Size, TempRead);
end;

function Hook_GetValue(Addr, Prt, Size: Cardinal): Cardinal;
var
  TempAddr, TempResult, TempValue, TempType, TempRead: Cardinal;
begin
  ReadProcessMemory(Handle, Ptr(Addr), @TempAddr, Size, TempRead);
  TempValue := TempAddr + Prt;
  ReadProcessMemory(Handle, Ptr(TempValue), @TempResult, Size, TempRead);
  Result := TempResult;
end;

function Hook_SetValue(Addr, Value, Size: Cardinal): Boolean;
var
  TempWrite: Cardinal;
  Buffer: PChar;
begin
  GetMem(Buffer,1);
  Buffer := PChar(IntToStr(Value));
  if WriteProcessMemory(Handle, Ptr(Addr), Buffer, Size, TempWrite) then
  Result := True;
end;

function IsValidValue(Max, Cur: Cardinal): Boolean;
begin
  if (Cur > Max) and (Max < 1) and (Max > 25000)
  then Result := False
  else Result := True;
end;

procedure ErrorMsg(msg: PChar);
begin
  msg := PChar(msg + #10+#10+ 'Application will be closed.'+#10+'Sorry :C');
  MessageBox(0, msg, 'EDH Error:', MB_ICONERROR);
  Halt;
end;

end.
