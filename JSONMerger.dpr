program JSONMerger;

uses
  Vcl.Forms,
  JSONMerger.Classes in 'Source\RT\JSONMerger.Classes.pas',
  Unit1 in 'Source\VCL\Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
