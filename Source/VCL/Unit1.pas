unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.JSON, System.StrUtils,
  JSONMerger.Classes, Vcl.Mask, CSControls.CSEditLabeled, CSEdit, CSControls.Labels;

type
  TForm1 = class(TForm)
    memObj1: TMemo;
    memObj2: TMemo;
    memObjRes: TMemo;
    lblObj1: TLabel;
    lblObj2: TLabel;
    lblObjRes: TLabel;
    btnMerge: TButton;
    edtWrapper: TCSEdit;
    lblTerminated: TCSLabel;
    btnClear1: TButton;
    btnClear2: TButton;
    btnClear3: TButton;
    btnClearAll: TButton;
    procedure btnMergeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure btnClear1Click(Sender: TObject);
    procedure btnClear2Click(Sender: TObject);
    procedure btnClear3Click(Sender: TObject);
  private
    procedure ClearMemos;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnClear1Click(Sender: TObject);
begin
  memObj1.Clear;
end;

procedure TForm1.btnClear2Click(Sender: TObject);
begin
  memObj2.Clear;
end;

procedure TForm1.btnClear3Click(Sender: TObject);
begin
  memObjRes.Clear;
end;

procedure TForm1.btnClearAllClick(Sender: TObject);
begin
  ClearMemos;
end;

procedure TForm1.btnMergeClick(Sender: TObject);
var
  LJM: TJSONMerger;
  LJObj1, LJObj2, LJRes: TJSONObject;
  LWrap: string;
begin
  btnClear3.OnClick(nil);

  LJM := TJSONMerger.Create(nil);
  try
    LJObj1 := TJSONObject.ParseJSONValue( memObj1.Lines.Text ) as TJSONObject;
    LJObj2 := TJSONObject.ParseJSONValue( memObj2.Lines.Text ) as TJSONObject;
    LWrap  := IfThen(edtWrapper.AsString <> '', edtWrapper.AsString, '');

    LJRes := LJM.MergeJAddObj(LJObj1, LJObj2, LWrap);

    if LJRes <> nil then
    begin
      memObjRes.Lines.Add( LJRes.Format(2) );
    end;

    lblTerminated.Caption := 'Merge terminato';
  finally
    FreeAndNil(LJM);
  end;
end;

procedure TForm1.ClearMemos;
begin
  memObj1.Clear;
  memObj2.Clear;
  memObjRes.Clear;
  lblTerminated.Caption := ''
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ClearMemos;
end;

end.
