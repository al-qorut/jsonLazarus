unit unit_json;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  fpjson, jsonparser;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  JSonData:TJSONData;
  jSonArray:TJSonArray;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  J : TJSONData;
begin
   try
    // Parse JSON Data to TJSONData
    J:=GetJSON(Memo1.Text);
    // Get the value for the path in edtPath
    Memo2.Text:=J.FindPath(edit1.Text).AsString;
  except
    on E: Exception do ShowMessage('Error finding path!');
  end;
  j.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  jData:TJSONData;
  jArray:TJSonArray;
  i,j:Integer;
begin
  memo1.Lines.Clear;
  memo1.Lines.LoadFromFile(extractFilePath(paramstr(0))+'json.txt');
  jData:=GetJSON(memo1.Text);
  jArray:=TJSONArray(jData.FindPath('timestamps_int'));
  for i:=0 to Pred(jArray.Count) do
  begin
    Memo2.Lines.Add('Number of items in this array = '+intTostr(jArray.Items[i].Count));
    for j:=0 to Pred(jArray.Items[i].Count) do
    begin
      Memo2.Lines.Add('Item['+intTostr(i)+'].['+intTostr(j)+'] = '+jArray.Items[i].Items[j].AsString);
    end;
  end;
  jData.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  xArray : TJSONArray;
  i : Integer;
begin
  memo3.Text:=jSonArray.Items[comboBox1.ItemIndex].FindPath('intepreter').AsString;
  memo4.Text:=jSonArray.Items[comboBox1.ItemIndex].FindPath('intervensi').AsString;
  memo5.Text:=jSonArray.Items[comboBox1.ItemIndex].FindPath('detail').AsString;
  xArray := TJSONArray(jSonArray.Items[comboBox1.ItemIndex].FindPath('content'));
  comboBox2.Items.Clear;
  for i:=0 to pred(xArray.Count) do
      ComboBox2.Items.Add(xArray.Items[i].FindPath('age').Items[0].AsString +'-'+xArray.Items[i].FindPath('age').Items[1].AsString);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  xArray : TJSONArray;
  i : Integer;
begin
   StringGrid1.ColCount:=2;
   xArray := TJSONArray(jSonArray.Items[comboBox1.ItemIndex].FindPath('content').Items[ComboBox2.ItemIndex].FindPath('list'));
   StringGrid1.RowCount:=xArray.Count+1;
   for i:=0 to pred(xArray.Count) do
    begin
      if comboBox1.ItemIndex=0 then
      StringGrid1.Cells[0,i+1]:=xArray.Items[i].FindPath('type').AsString;
      StringGrid1.Cells[1,i+1]:=xArray.Items[i].FindPath('quest').AsString;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
x : TStrings;
i:Integer;
begin
  x := TStringList.Create;
  try
   x.LoadFromFile(extractFilePath(paramstr(0))+'paud.txt');
   jSonData := getJson(x.Text);
   jSonArray := TJSONArray(jSondata.FindPath('praSkrining'));
   for i:=0 to pred(jSonArray.Count) do
      ComboBox1.Items.Add(jSonArray.Items[i].FindPath('title').AsString);
  finally
    x.free;
  end;
end;

end.

