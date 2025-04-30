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
    MenuItem18: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    //procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    //procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  E,S : array[0..399,0..399] of integer;

implementation

{$R *.lfm}

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

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.MenuItem10Click(Sender: TObject);  //filtro da média (N8)
var
  x,y,filtro : integer;
begin
  for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

  for y:=1 to Image1.Height-2 do
     for x:= 1 to Image1.Width-2 do
       begin
         filtro := (1/9)*E[x-1,y-1] + (1/9)*E[x,y-1] + (1/9)*E[x+1,y-1]
               + (1/9)*E[x-1,y] + (1/9)*E[x,y] + (1/9)*E[x+1,y]
               + (1/9)*E[x-1,y+1] + (1/9)*E[x,y+1] + (1/9)*E[x+1,y+1];   //????
         S[x,y] := filtro;
       end;

  for y:=0 to Image1.Height-1 do
      for x:=0 to Image1.Width-1 do
          Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);


end;

procedure TForm1.MenuItem12Click(Sender: TObject);   //equalização (jeito Professor)
var
  i, x, y, pixel, valorEq: integer;
  freq, freqAcc : array[0..255] of byte;
begin
     for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

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
         begin
            freqAcc[i] := freq[i] + freq[i-1]; //montando o vetor de frequência acumulada
            valorEq := round((255*freqAcc[i])/(Image1.Width*Image1.Height))-1;
            if (valorEq > 0) then
                 begin
                  for y:=0 to Image1.Height-1 do
                      for x:=0 to Image1.Width-1 do
                          pixel := S[x,y];
                          if pixel = i then
                             S[x,y] := valorEq;
                 end
              else
                  begin
                    for y:=0 to Image1.Height-1 do
                        for x:=0 to Image1.Width-1 do
                            pixel := S[x,y];
                            if(pixel = i) then
                               S[x,y] := 0;
                 end;
         end;

     for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);

end;

procedure TForm1.MenuItem13Click(Sender: TObject);   //binarização
var                                                 //usuário escolhe um limiar
   x,y,a : integer;

begin
   Writeln ('\nDigite o limiar desejado: ');
   Readln(a);

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
           end;

   for y:=0 to Image1.Height-1 do
       for x:=0 to Image1.Width-1 do
           Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);

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
var                                                   //a função será aplicada no intervalo que o usuário escolher
   x,y,a,b,c : integer;

begin
   Writeln ('\nDigite o menor valor do intervalo: ');
   Readln(a);
   Writeln ('\nDigite o maior valor do intervalo: ');
   Readln(b);
   Writeln ('\nDigite o valor que deseja aplicar no intervalo escolhido: ');  //a função T será um valor fixo escolhido pelo usuário
   Readln(c);

   for y:=0 to Image1.Height-1 do
         for x:=0 to Image1.Width-1 do
             S[x,y] := E[x,y];

   for y:=0 to Image1.Height-1 do
       for x:=0 to Image1.Width-1 do
           if(E[x,y] > a) AND (E[x,y] < b) then
              S[x,y] := c;

   for y:=0 to Image1.Height-1 do
       for x:=0 to Image1.Width-1 do
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
             end;

     for y:=0 to Image2.Height-1 do
         for x:=0 to Image2.Width-1 do
             Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
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
   R,G,B,cinza : byte;
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

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem8Click(Sender: TObject);  //criar 10% de ruído
var
  i, x, y : integer;
  ruido : byte;
begin
  for y:=0 to Image1.Height-1 do
      for x:=0 to Image1.Width-1 do
          S[x,y] := E[x,y];

  for i:=0 to round(0.1*(Image2.Width*Image2.Height)) do
          begin
             x:= random(Image2.Width-1);
             y:= random(Image2.Height-1);
             if(i mod 2 = 0) then     //ruido sal e pimenta
                    ruido := 0
             else
               ruido := 255;
             S[x,y] := ruido;
          end;
  for y:=0 to Image1.Height-1 do
      for x:=0 to Image1.Width-1 do
          Image2.Canvas.Pixels[x,y] := RGB(S[x,y],S[x,y],S[x,y]);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
end;

end.

