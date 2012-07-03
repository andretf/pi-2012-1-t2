function Img = jpeg_descompacta(jpeg)

% Coloca numa estrutura os dados comprimidos e a info relevante
% jpeg = struct('field_q', q,...
%			   'field_sizeI', size(I), ...
%            'field_sizeG', size(G),...
%            'field_DC', DC,...
%            'field_AC', AC);

Q = jpeg.field_q .* [...
	16 11 10 16 24 40 51 61; ...
   12 12 14 19 26 58 60 55; ...
   14 13 16 24 40 57 69 56; ...
   14 17 22 29 51 87 80 62; ...
   18 22 37 56 68 109 103 77; ...
   24 35 55 64 81 104 113 92; ...
   49 64 78 87 103 121 120 101; ...
   72 92 95 98 112 100 103 99];


%%%%%%%% ALGO

% faz caminho inverso:
% 1. DPCM inverso -> DC
% 2. RunLength inverso -> AC
% 3. zig-zag inverso -> AC
% 4. coloca as infos do DC, AC -> bloco
% 5. desfaz a quantização -> bloco
% 6. faz o DCT2 inverso -> bloco
% 7. bloco -> Imagem Saída

% 1. DESFAZ CORRIDAS DE ZEROS
AC = irunLength(jpeg.field_AC.');

% 2. DESFAZER DPCM
DC = iDPCM(jpeg.field_DC);

% 3. DESFAZ DCT E QUANTIZAÇÃO
G = zeros(jpeg.field_sizeG(1), jpeg.field_sizeG(2), jpeg.field_sizeG(3));



% para cada um dos blocos, faz os passos 4 a 7
for i = 1 : jpeg.field_sizeG(3)
   G(:, :, i) = iZigZag( AC(1 + 63*(i-1) : 63*i ) );
   G(1, 1, i) = DC(i, 1);
   G(:, :, i) = G(:, :, i) .* Q;
   G(:, :, i) = idct2(G(:, :, i));
end

%% Como é na compactação, fazer bottom-top no For de cima (descompact.)
%for x = 1 : size(G, 3)
%	% aplica DCT2 pra cada um dos blocos
%	G(:, :, x) = dct2(G(:, :, x));
%   
%	% aplica quantização em cada um dos elementos dos blocos
%	% Bj,k = round(Gj,k / Qj,k)
%   G(:, :, x) = round(G(:, :, x)./Q);
%   
%	DC = [DC; G(1, 1, x)];
%	AC = [AC; [runLength(zigzag(G(:, :, x)))].'];
%end

   
   
Img = joinBlocos(G);
Img = Img + 128;
Img = uint8(Img);

return

