program MSSQLDemo;

uses
  Forms,
  DemoUnit in 'DemoUnit.pas' {frmMSSQLDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMSSQLDemo, frmMSSQLDemo);
  Application.Run;
end.
