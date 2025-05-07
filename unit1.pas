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
    Edit4: TEdit;
    Edit5: TEdit;
    Edit8: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
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
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
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
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    //procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    //procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

  procedure RGBtoHSV(r, g, b: Single; var h, s, v: Single);

var
  Form1: TForm1;
  E,S : array[0..399,0..399] of integer;

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

procedure TForm1.Button1Click(Sender: TObject);    //botão de copiar saída na entrada
var
  x,y : integer;
begin
  Image1.Picture := Image2.Picture;
  for y:=0 to Image1.Height-1 do
      for x:=0 to Image1.Width-1 do
          E[x,y] := S[x,y];   //se converto assim fica tudo branco
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

procedure TForm1.MenuItem16Click(Sender: TObject);
  var
    coluna, linha: Integer;
    corOriginal: TColor;
    R, G, B: Byte;
    novoR, novoG, novoB: Integer;
    fatorC, gama: Double;
    valorNormalizado: Double;
  begin
    if Image1.Picture.Bitmap.Empty then
      Exit;

    // Obter valores de c e γ dos edits
    fatorC := StrToFloat(Edit4.Text);
    gama := StrToFloat(Edit5.Text);

    // Preparar Image2
    Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

    // Processar cada pixel
    for coluna := 0 to Image1.Picture.Bitmap.Width - 1 do
    begin
      for linha := 0 to Image1.Picture.Bitmap.Height - 1 do
      begin
        // Obter cor original
        corOriginal := Image1.Picture.Bitmap.Canvas.Pixels[coluna, linha];
        R := Red(corOriginal);
        G := Green(corOriginal);
        B := Blue(corOriginal);

        // Aplicar fórmula para cada canal
        valorNormalizado := R / 255;
        novoR := Round(fatorC * Power(valorNormalizado, gama) * 255);
        novoR := EnsureRange(novoR, 0, 255);

        valorNormalizado := G / 255;
        novoG := Round(fatorC * Power(valorNormalizado, gama) * 255);
        novoG := EnsureRange(novoG, 0, 255);

        valorNormalizado := B / 255;
        novoB := Round(fatorC * Power(valorNormalizado, gama) * 255);
        novoB := EnsureRange(novoB, 0, 255);

        // Atualizar pixel na imagem de saída
        Image2.Picture.Bitmap.Canvas.Pixels[coluna, linha] := RGBToColor(novoR, novoG, novoB);
      end;
    end;
    Image2.Refresh;
    ShowMessage('Compressão aplicada!');
  end;

procedure TForm1.Label11Click(Sender: TObject);
begin

end;

procedure TForm1.Label7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem10Click(Sender: TObject);  //filtro da média (N8)
var
  x,y,filtro : integer;
begin
  for y:=1 to Image1.Height-2 do
     for x:= 1 to Image1.Width-2 do
       begin
         filtro := E[x-1,y-1] + E[x,y-1] + E[x+1,y-1]

         + E[x-1,y]   + E[x,y] + E[x+1,y]

         + E[x-1,y+1] + E[x,y+1] + E[x+1,y+1];

         S[x,y] := round( filtro/ 9);

         Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
       end;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);   //equalização (jeito Professor)
var
  i, x, y, pixel: integer;
  freq, freqAcc, valorEq: array[0..255]  of byte;
begin
     for i:=0 to 255 do
         freq[i] := 0;

     for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.width-1 do
             begin
               pixel := E[x,y];
               freq[pixel] := freq[pixel] + 1;  //montando o vetor de frequências de cada tom de cinza
             end;

     freqAcc[0] := freq[0];
     for i:=1 to 255 do
         freqAcc[i] := freq[i] + freqAcc[i-1]; //montando o vetor de frequência acumulada

     for i:=0 to 255 do
         valorEq[i] := round((255*freqAcc[i])/(Image1.Width*Image1.Height))-1;    //montando vetor de valores equalizados

     for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             begin
               pixel := E[x,y];  //todos os pixels dessa tonalidade devem ser substituídos pelo valor valorEq[pixel] se for maior que 0
               if(valorEq[pixel] > 0) then
                  S[x,y] := valorEq[pixel]
               else
                 S[x,y] := 0;
               Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
             end;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);   //binarização
var
   x,y,a : integer;

begin
   a := StrToInt(Edit9.Text);         //usuário escolhe um limiar

   for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

   for y:=0 to Image1.Height-1 do
       for x:=0 to Image1.Width-1 do
           begin
             if(E[x,y] > a) then
                S[x,y] := 255
             else
               S[x,y] := 0;
             Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
           end;
end;

procedure TForm1.MenuItem15Click(Sender: TObject); //detecção de bordas por Sobel
var
   x,y,gx,gy,min,max : integer;
   mag : array[0..399,0..399] of integer;
begin
   for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];
   for y:=1 to Image1.Height-2 do
     for x:= 1 to Image1.Width-2 do
     begin
       gx := -1*E[x-1,y-1] + 1*E[x+1,y-1]  //mascara gx
             -2*E[x-1,y]+ 2*E[x+1,y]
             -1*E[x-1,y+1] + 1*E[x+1,y-1];

       gy := -1*E[x-1,y-1] -2*E[x,y-1] -1*E[x+1,y-1]   //mascara gy
             +1*E[x-1,y+1] +2*E[x,y+1] +1*E[x+1,y+1];

       mag[x,y] := round(sqrt(gx*gx + gy*gy));
       min := 99999999;
       max := -99999999;
      end;

   for y:=1 to Image1.Height-2 do
     for x:= 1 to Image1.Width-2 do
     begin
       if min > mag[x,y] then min := mag[x,y];
       if max < mag[x,y] then max := mag[x,y];
     end;

   for y:=1 to Image1.Height-2 do
     for x:= 1 to Image1.Width-2 do
     begin
       S[x,y] := round(((mag[x,y] - min)/(max-min))*255);
       Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
     end;

end;

procedure TForm1.MenuItem17Click(Sender: TObject);    //limiarização
var
   x,y,a,b,c : integer;

begin
   a := StrToInt(Edit6.Text);            //a função (valor fixo) será aplicada no intervalo que o usuário escolher
   b := StrToInt(Edit7.Text);
   c := StrToInt(Edit8.Text);

   for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

   for y:=0 to Image1.Height-1 do
       for x:=0 to Image1.Width-1 do
           if(E[x,y] > a) AND (E[x,y] < b) then
              S[x,y] := c;
           Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
end;

//equalização (jeito Julia) (ignorar)
//var
//  i, x, y, j, freqAcc, valorEqualizado, aux: integer;
//  rotulo : array[0..399, 0..399] of integer;
//  R,G,B : byte;
//  cor, menor : Tcolor;
//begin
//     for y:=0 to Image1.Height-1 do
//         for x:=0 to Image1.Width-1 do
//             rotulo[x,y] := 0;  //se for 0 ainda não foi visitado, se for 1 já foi visitado
//
//     freqAcc := 1;
//     menor := Image1.Canvas.Pixels[0,0];
//
//     for x:=0 to Image1.Height-1 do
//         for y:=0 to Image1.Width-1 do
//
//             for j:=0 to Image1.Height-1 do
//               for i:=0 to Image1.Width-1 do
//                   if(menor > Image1.Canvas.Pixels[i,j]) AND (rotulo[i,j] = 0) then
//                     menor := Image1.Canvas.Pixels[i,j];
//               cor := menor; //menor tom que ainda não foi equalizado para ser equalizado
//
//               for i:=0 to Image1.Height-1 do    //calculando a frequencia acumulada
//                   for j:=0 to Image1.Width-1 do
//                       if(Image1.Canvas.Pixels[i,j] = cor) AND (rotulo[i,j] = 0) then
//                         begin
//                          rotulo[i,j] := 1;
//                          freqAcc := freqAcc+1;
//                         end;
//
//             aux := round((255*freqAcc)/(Image1.Width*Image1.Height));
//             if (aux > 0) then
//                valorEqualizado := aux
//             else
//                 valorEqualizado := 0;
//
//             for j:=0 to Image1.Height-1 do
//               for i:=0 to Image1.Width-1 do
//                 if(Image1.Canvas.Pixels[i,j] = cor) then
//                    Image1.Canvas.Pixels[i,j] := valorEqualizado;


procedure TForm1.MenuItem18Click(Sender: TObject);        //inverter P&B
var
  x, y : integer;
  invertido : byte;
begin
    for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

     for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             begin
               invertido := 255 - E[x,y];
               S[x,y] := RGB(invertido, invertido, invertido);
               Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
             end;
end;

procedure TForm1.MenuItem19Click(Sender: TObject);    //transformada discreta do cosseno
begin

end;

//procedure TForm1.MenuItem19Click(Sender: TObject);      //inverter colorida
//var
//  i, x, y : integer;
//  R,G,B : byte;
//  cor : Tcolor;
//begin
//     for y:=0 to Image1.Height-1 do
//         for x:=0 to Image1.Width-1 do
//             begin
//               cor := Image1.Canvas.Pixels[x,y];
//               R := getRValue(cor);
//               G := getGValue(cor);
//               B := getBValue(cor);
//               Image2.Canvas.Pixels[x,y] := RGB(255-R, 255-G, 255-B);
//             end;
//end;

//procedure TForm1.MenuItem19Click(Sender: TObject);
//begin

//end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);    //abrir imagem de entrada
var
   x,y : integer;
   cor : Tcolor;
   R,G,B,cinza : integer;
begin
  if(OpenDialog1.Execute)
      then
      begin
        Image1.Picture.LoadFromFile(OpenDialog1.FileName);
      end;
      for y:=0 to Image1.Height-1 do
          for x:=0 to Image1.Width-1 do
              begin
                cor := Image1.Canvas.Pixels[x,y];
                R := getRValue(cor);
                G := getGvalue(cor);
                B := getBValue(cor);
                cinza := round(0.299*R + 0.587*G + 0.144*B);
                E[x,y] := cinza;   //se converto assim fica tudo branco
                Image1.Canvas.Pixels[x,y] := RGB(cinza,cinza,cinza);
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

procedure TForm1.MenuItem8Click(Sender: TObject);  //criar 10% de ruído
var
  i, x, y : integer;
  ruido : integer;
begin
  for i:=0 to round(0.1*(Image2.Width*Image2.Height)) do
          begin
             x:= random(Image2.Width-1);
             y:= random(Image2.Height-1);
             if(i mod 2 = 0) then     //ruido sal e pimenta
                    ruido := 0
             else
               ruido := 255;
             S[x,y] := ruido;
             Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
          end;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
end;

end.

