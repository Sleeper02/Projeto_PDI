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
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    aaa: TMemo;
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
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aaaChange(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
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
  rNorm, gNorm, bNorm: Single;
begin
  // Normalizar valores de 0-255 para 0-1
  rNorm := r / 255;
  gNorm := g / 255;
  bNorm := b / 255;

  // Usando Min e Max da unidade Math
  min_val := Min(Min(rNorm, gNorm), bNorm);
  max_val := Max(Max(rNorm, gNorm), bNorm);
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
  if rNorm = max_val then
    h := (gNorm - bNorm) / delta
  else if gNorm = max_val then
    h := 2 + (bNorm - rNorm) / delta
  else
    h := 4 + (rNorm - gNorm) / delta;
  h := h * 60;
  if h < 0 then
    h := h + 360;
end;

procedure HSVtoRGB(h, s, v: Single; var r, g, b: Single);
var
  c, x, m, hPrime, modValue: Single;
  hSeg: Integer;
begin
  // Garantir que H está entre 0 e 360
  h := h - 360 * Floor(h / 360);

  // Normaliza S e V para 0–1 (se forem porcentagens)
  s := s / 100; // ⚠️ Comente se S e V já estiverem em 0–1
  v := v / 100; // ⚠️ Comente se S e V já estiverem em 0–1

  c := v * s;
  hPrime := h / 60; // H' = H / 60°
  hSeg := Trunc(hPrime); // Setor (0–5)
  modValue := hPrime - 2 * Floor(hPrime / 2); // H' mod 2
  x := c * (1 - Abs(modValue - 1)); // Cálculo correto de X
  m := v - c;

  case hSeg of
    0: begin r := c; g := x; b := 0; end;
    1: begin r := x; g := c; b := 0; end;
    2: begin r := 0; g := c; b := x; end;
    3: begin r := 0; g := x; b := c; end;
    4: begin r := x; g := 0; b := c; end;
    5: begin r := c; g := 0; b := x; end;
  else
    r := 0; g := 0; b := 0;
  end;

  // Ajustar para o brilho e converter para 0–255
  r := (r + m) * 255;
  g := (g + m) * 255;
  b := (b + m) * 255;
end;


{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.aaaChange(Sender: TObject);
begin

end;

procedure TForm1.MenuItem14Click(Sender: TObject);
  var
    coluna, linha: Integer;
    corAtual, corVizinho: TColor;
    rAtual, gAtual, bAtual: Byte;
    somaR, somaG, somaB: Integer;
    r, g, b: Integer;
  begin
    if Image1.Picture.Bitmap.Empty then
      Exit;

    // Prepara Image2 com o mesmo tamanho da Image1
    Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

    // Limpa Image2 com preto
    Image2.Picture.Bitmap.Canvas.Brush.Color := clBlack;
    Image2.Picture.Bitmap.Canvas.FillRect(0, 0, Image2.Picture.Bitmap.Width, Image2.Picture.Bitmap.Height);

    // Aplica o filtro Laplaciano
    for coluna := 0 to Image1.Picture.Bitmap.Width - 1 do
    begin
      for linha := 0 to Image1.Picture.Bitmap.Height - 1 do
      begin
        // Obtém a cor do pixel atual
        corAtual := Image1.Picture.Bitmap.Canvas.Pixels[coluna, linha];
        rAtual := Red(corAtual);
        gAtual := Green(corAtual);
        bAtual := Blue(corAtual);

        // Inicializa os somatórios
        somaR := 4 * rAtual;
        somaG := 4 * gAtual;
        somaB := 4 * bAtual;

        // Vizinho esquerdo
        if coluna > 0 then
        begin
          corVizinho := Image1.Picture.Bitmap.Canvas.Pixels[coluna - 1, linha];
          somaR := somaR - Red(corVizinho);
          somaG := somaG - Green(corVizinho);
          somaB := somaB - Blue(corVizinho);
        end;

        // Vizinho direito
        if coluna < Image1.Picture.Bitmap.Width - 1 then
        begin
          corVizinho := Image1.Picture.Bitmap.Canvas.Pixels[coluna + 1, linha];
          somaR := somaR - Red(corVizinho);
          somaG := somaG - Green(corVizinho);
          somaB := somaB - Blue(corVizinho);
        end;

        // Vizinho superior
        if linha > 0 then
        begin
          corVizinho := Image1.Picture.Bitmap.Canvas.Pixels[coluna, linha - 1];
          somaR := somaR - Red(corVizinho);
          somaG := somaG - Green(corVizinho);
          somaB := somaB - Blue(corVizinho);
        end;

        // Vizinho inferior
        if linha < Image1.Picture.Bitmap.Height - 1 then
        begin
          corVizinho := Image1.Picture.Bitmap.Canvas.Pixels[coluna, linha + 1];
          somaR := somaR - Red(corVizinho);
          somaG := somaG - Green(corVizinho);
          somaB := somaB - Blue(corVizinho);
        end;

        // Calcula os valores finais com clamp
        r := EnsureRange(Abs(somaR), 0, 255);
        g := EnsureRange(Abs(somaG), 0, 255);
        b := EnsureRange(Abs(somaB), 0, 255);

        // Define o novo pixel na Image2
        Image2.Picture.Bitmap.Canvas.Pixels[coluna, linha] := RGBToColor(r, g, b);
      end;
    end;
    Image2.Refresh;
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
var
  h, s, v: Single;
  r, g, b: Single;
begin
  h := StrToFloat(Edit1.Text); // H em graus (0–360)
  s := StrToFloat(Edit2.Text); // S em porcentagem (0–100)
  v := StrToFloat(Edit3.Text); // V em porcentagem (0–100)

  HSVtoRGB(h, s, v, r, g, b);

  // Exibe os resultados
  ShowMessage('RGB: ' + FloatToStr(Round(r)) + ', ' + FloatToStr(Round(g)) + ', ' + FloatToStr(Round(b)));
end;

procedure TForm1.MenuItem6Click(Sender: TObject);    //sair
begin
  Form1.Close();
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
var
  r, g, b: Single;
  h, s, v: Single;
begin
  // Exemplo de uso - você pode substituir estes valores pelos seus
  r := StrToFloat(Edit1.Text); // Valores entre 0-255
  g := StrToFloat(Edit2.Text); // Valores entre 0-255
  b := StrToFloat(Edit3.Text); // Valores entre 0-255

  // Chama a função de conversão
  RGBtoHSV(r, g, b, h, s, v);

  // Exibe os resultados
  ShowMessage('RGB (' + FloatToStr(r) + ', ' + FloatToStr(g) + ', ' + FloatToStr(b) + ') ' +
              'convertido para HSV (' + FloatToStr(h) + '°, ' + FloatToStr(s*100) + '%, ' + FloatToStr(v*100) + '%)');
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin

end;

end.

