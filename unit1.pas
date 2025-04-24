unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);    //abrir imagem de entrada
begin
  if(OpenDialog1.Execute)
      then
      begin
        Image1.Picture.LoadFromFile(OpenDialog1.FileName);
      end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);     //salvar imagem de saída
begin
    if(SaveDialog1.Execute)
      then
        Image2.Picture.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);    //sair
begin
  Form1.Close();
end;

procedure TForm1.MenuItem8Click(Sender: TObject);  //criar 10% de ruído
var
  i, x, y : integer;
  cor : Tcolor;
begin
  Image2.Picture := Image1.Picture;
  for i:=0 to round(0.1*(Image1.Width*Image1.Height)) do
          begin
             x:= random(Image1.Width-1);
             y:= random(Image1.Height-1);
             cor:= random(255);
             Image2.Canvas.Pixels[x,y] := RGB(cor,cor,cor);
          end;
end;

end.

