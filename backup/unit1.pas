unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, Types, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
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
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public

  end;

// Declaração da função RGBtoHSV
procedure RGBtoHSV(r, g, b: Single; var h, s, v: Single);

var
  Form1: TForm1;

implementation

{$R *.lfm}

// Implementação da função RGBtoHSV
procedure RGBtoHSV(r, g, b: Single; var h, s, v: Single);
var
  min_val, max_val, delta: Single;
begin
  // Usando Min e Max da unidade Math
  min_val := Min(Min(r, g), b);
  max_val := Max(Max(r, g), b);
  v := max_val;
  delta := max_val - min_val;

  if max_val <> 0 then
    s := delta / max_val
  else
  begin
    s := 0;
    h := -1;
    Exit;
  end;

  if r = max_val then
    h := (g - b) / delta
  else if g = max_val then
    h := 2 + (b - r) / delta
  else
    h := 4 + (r - g) / delta;

  h := h * 60;
  if h < 0 then
    h := h + 360;
end;


{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;
//
//function copiarImagem1NaImagem2();
//var
//  x,y : integer;
//  E,S : array[0...Image1.Width-1, 0...Image1.Height-1) of byte;
//begin
//  for x:=0 to Image1.Width-1 do
//      for y:=0 to Image1.Height-1 do
//          S[x,y] = E[x,y];
//end;

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

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
var
  r, g, b: Single;
  h, s, v: Single;
begin
  // Exemplo de uso - você pode substituir estes valores pelos seus
  r := 0.5;  // Vermelho (de 0.0 até 1.0)
  g := 0.3;  // Verde (de 0.0 até 1.0)
  b := 0.9;  // Azul (de 0.0 até 1.0)

  // Chama a função de conversão
  RGBtoHSV(r, g, b, h, s, v);

  // Exibe os resultados
  ShowMessage('RGB (' + FloatToStr(r) + ', ' + FloatToStr(g) + ', ' + FloatToStr(b) + ') ' +
              'convertido para HSV (' + FloatToStr(h) + '°, ' + FloatToStr(s*100) + '%, ' + FloatToStr(v*100) + '%)');

end;

procedure TForm1.MenuItem6Click(Sender: TObject);    //sair
begin
  Form1.Close();
end;

procedure TForm1.MenuItem8Click(Sender: TObject);  //criar 10% de ruído
var
  i, x, y : integer;
  cor : Tcolor;
  aux : TPicture;
begin
  aux := Image1.Picture;
  Image2.Picture := Image1.Picture;
  for i:=0 to round(0.1*(Image2.Width*Image2.Height)) do
          begin
             x:= random(Image2.Width-1);
             y:= random(Image2.Height-1);
             cor:= random(255);
             Image2.Canvas.Pixels[x,y] := RGB(cor,cor,cor);
          end;
end;

end.

