unit uRunningCheetah;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Graphics;

Type

{ TRunningCheetah }

 TRunningCheetah = class(TCustomControl)
  private
    fAnimated: Boolean;
    fAnimateTimer: TTimer;
    fBmpIndex: Integer;
    fBMPBckGnd: TBitmap;
    fBMPs: array[0..7] of TBitmap;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
  protected
    Procedure Paint; override;
    procedure TimerCall(Sender: TObject);
  private
    Procedure SetAnimated(AValue: Boolean);
  published
    Property Anchors;
    Property Animated: Boolean read fAnimated write SetAnimated default true;
end;

 procedure Register;

IMPLEMENTATION
uses
  LResources,Dialogs, LCLIntf;

{ TRunningCheetah }

constructor TRunningCheetah.Create(AOwner: TComponent);
var ii: Integer;
begin
  inherited Create(AOwner);

  Width:= 144; Height:= 118;
  Constraints.MinWidth := 144; Constraints.MaxWidth := 144;
  Constraints.MinHeight:= 118; Constraints.MaxHeight:= 118;

  fBMPBckGnd:= TBitmap.Create;
  fBMPBckGnd.LoadFromLazarusResource('Background');


  for ii:= 0 to 7 do fBMPs[ii]:= TBitmap.Create;

  fBMPs[0].LoadFromLazarusResource('RunCheetah1');
  fBMPs[1].LoadFromLazarusResource('RunCheetah2');
  fBMPs[2].LoadFromLazarusResource('RunCheetah3');
  fBMPs[3].LoadFromLazarusResource('RunCheetah4');
  fBMPs[4].LoadFromLazarusResource('RunCheetah5');
  fBMPs[5].LoadFromLazarusResource('RunCheetah6');
  fBMPs[6].LoadFromLazarusResource('RunCheetah7');
  fBMPs[7].LoadFromLazarusResource('RunCheetah8');

  fBmpIndex:= 0;
  fAnimated:= true;
  Invalidate;

  if not (csDesigning in ComponentState) then begin
    fAnimateTimer:= TTimer.Create(self);
    fAnimateTimer.Interval:= 50;
    fAnimateTimer.OnTimer:=@TimerCall;
    fAnimateTimer.Enabled:= true;
  end;

end;

destructor TRunningCheetah.Destroy;
var ii: Integer;
begin
  for ii:= 0 to 7 do fBMPs[ii].Destroy;

  inherited Destroy;
end;

procedure TRunningCheetah.Paint;
begin

  fBMPBckGnd.Canvas.Draw(6,28,fBMPs[fBmpIndex]);

  Canvas.Draw(0,0,fBMPBckGnd);

  inherited Paint;

end;

procedure TRunningCheetah.TimerCall(Sender: TObject);
begin
  fBmpIndex:= fBmpIndex +1;
  if fBmpIndex > 7 then fBmpIndex:= 0;

  Invalidate;
end;

procedure TRunningCheetah.SetAnimated(AValue: Boolean);
begin
  if fAnimated=AValue then Exit;
  fAnimated:=AValue;

  if fAnimated then begin
    if not (csDesigning in ComponentState) then fAnimateTimer.Enabled:= true;
  end else begin
    if not (csDesigning in ComponentState) then fAnimateTimer.Enabled:= false;
    fBmpIndex:= 0;
  end;

  Invalidate;

end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure Register;
begin

  RegisterComponents('Additional',[TRunningCheetah]);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
INITIALIZATION
{$I picture/RunningCheetah.lrs}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end.

