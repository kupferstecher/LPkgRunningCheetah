{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RunningCheetah;

{$warn 5023 off : no warning about unused units}
interface

uses
  uRunningCheetah, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uRunningCheetah', @uRunningCheetah.Register);
end;

initialization
  RegisterPackage('RunningCheetah', @Register);
end.
