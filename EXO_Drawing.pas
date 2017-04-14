unit EXO_Drawing;

interface

uses SysUtils, Windows, EXO_Offsets;

function WorldToScreen(wFrom, wTo: vec3_type): Boolean;
function Get3D(x, y, z, eX, eY, eZ: Single): Single;
function GetColor(Team: Byte): color_type;

procedure DrawBox(x, y, w, h, t: Integer);
procedure DrawRect(x, y, w, h: Integer);

type
  WorldToScreenMatrix_t = record
    Matrix: array [0..4, 0..4] of Single;
end;

var
	W2S_M: WorldToScreenMatrix_t;
  Rect: TRect;
  Desc: HDC;
  Brush: HBRUSH;

implementation

procedure DrawBox(x, y, w, h, t: Integer);
begin
	DrawRect( x,  y,  w,  t);
	DrawRect( x,  y,  t,  h);
	DrawRect((x + w), y,  t,  h);
	DrawRect( x,  y + h,  w + t, t);
end;

procedure DrawRect(x, y, w, h: Integer);
var
  Box: TRect;
begin
  Box.Left    := x;
  Box.Top     := y;
  Box.Right   := x + w;
  Box.Bottom  := y + h;
  FillRect(Desc, Box, Brush);
end;

function GetColor(Team: Byte): color_type;
begin
  case Team of
    2: begin Result.R := 255; Result.G := 0; Result.R := 0; end;
    3: begin Result.R := 0; Result.G := 0; Result.R := 255; end;
  else
  begin
    Result.R := 255;
    Result.G := 255;
    Result.B := 255;
  end;
  end;
end;

function Get3D(x, y, z, eX, eY, eZ: Single): Single;
begin
  Result := Sqrt( (eX - x) * (eX - x) + (eY - Y) * (eY - Y) + (eZ - z) * (eZ - z) );
end;

function WorldToScreen(wFrom, wTo: vec3_type): Boolean;
var
  w, invw, x, y: Single;
  Width, Height: Integer;
begin

  wTo.x := W2S_M.Matrix[0][0] * wFrom.x + W2S_M.Matrix[0][1] * wFrom.y + W2S_M.Matrix[0][2] * wFrom.z + W2S_M.Matrix[0][3];
  wTo.y := W2S_M.Matrix[1][0] * wFrom.x + W2S_M.Matrix[1][1] * wFrom.y + W2S_M.Matrix[1][2] * wFrom.z + W2S_M.Matrix[1][3];

  w := W2S_M.Matrix[3][0] * wFrom.x + W2S_M.Matrix[3][1] * wFrom.y + W2S_M.Matrix[3][2] * wFrom.z + W2S_M.Matrix[3][3];

  if (w < 0.01) then Result := False;

  invw := 1.0 / w;

  wTo.x := wTo.x * invw;
  wTo.y := wTo.y * invw;

  Width := Rect.Right - Rect.Left;
  Height := Rect.Bottom - Rect.Top;

  x := Width / 2;
  y := Height / 2;

  x := x + (0.5 * wTo.x * Width + 0.5);
  y := y - (0.5 * wTo.y * Height + 0.5);

  wTo.x := x + Rect.Left;
  wTo.y := y + Rect.Top;

  Result := True;
end;

end.


