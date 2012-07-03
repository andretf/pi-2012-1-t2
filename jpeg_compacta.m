% figure, imshow(I);
% I = double(I);
% I = I -128;

%% onde I é a imagem e q é o fator multiplicativo q >= 1
function jpeg = jpeg_compacta(I, q)
% imagem original

% jpeg = Img retorno
% 1. Subtraia 128 do valor de cada pixel da imagem
jpeg = double(I);
jpeg = jpeg - 128;

% 2. Aplique a transformada DCT 2D em blocos de 8x8
% jpg = dct2(jpg);
% figure, imshow(J, 'Após DCT2');

% 3  Tabela de Quantização dos coeficientes da DCT usando o multiplicador passado
Q = q .* [...
      16 11 10 16 24 40 51 61; ...
      12 12 14 19 26 58 60 55; ...
      14 13 16 24 40 57 69 56; ...
      14 17 22 29 51 87 80 62; ...
      18 22 37 56 68 109 103 77; ...
      24 35 55 64 81 104 113 92; ...
      49 64 78 87 103 121 120 101; ...
      72 92 95 98 112 100 103 99];

% cria blocos 8x8
G = separaBlocos(jpeg);
DC = [];
AC = [];

for x = 1 : size(G, 3)
   % aplica DCT2 pra cada um dos blocos
   G(:, :, x) = dct2(G(:, :, x));
   
   % aplica quantização em cada um dos elementos dos blocos
   % Bj,k = round(Gj,k / Qj,k)
   G(:, :, x) = round(G(:, :, x)./Q);
   
   DC = [DC; G(1, 1, x)];
   AC = [AC; [runLength(zigzag(G(:, :, x)))].'];
end


% Faz a compressão DPCM dos coeficientes DC
% Isto codifica cada coeficiente DC como um delta do coeficiente anterior
DC = DPCM(DC);

% Coloca numa estrutura os dados comprimidos e a info relevante
jpeg = struct('field_q', q,...
   'field_sizeI', size(I), ...
   'field_sizeG', size(G),...
   'field_DC', DC,...
   'field_AC', AC);

return