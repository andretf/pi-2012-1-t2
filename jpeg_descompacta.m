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
G = zeros(jpeg.field_G(1), jpeg.field_G(2), jpeg.field_G(3));

% para cada um dos blocos, faz os passos 4 a 7
for i = 1 : jpeg.field_G(3)
   G(:, :, i) = iZigZag(AC());		
   G(1, 1, i) = DC(i, 1);
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

   
IM = [];
LINHA = [];
for i = 1 : num_linhas*num_colunas
   aux = iZigZag(AC((i-1)*63 + 1 : i*63));
   aux(1,1) = DC(i, 1);
   LINHA = [LINHA, idct2(aux.*TQ) + 128];
   if mod(i, num_colunas) == 0
      IM = [IM; LINHA];
      LINHA = [];
   end;
end;
   
descomprimida = iExpandeMatriz(IM, exp_hor, exp_vert);

%(5) "programa para reconstruir a imagem invertendo os passos usados na
% versão simplificada de codificação."
blocos_total = size(entrada.acs, 2)

% expande os coeficientes comprimidos por RecodificaCoeficientes
myAcs = ExpandeCoeficientes(entrada.palavras_simbolo, blocos_total) ;

% "Use a Tabela de Quantização dos coeficientes da DCT mostrada em aula."
TabelaQuantizacao = [ 16 11 10 16 24 40 51 61; ...
      12 12 14 19 26 58 60 55; ...
      14 13 16 24 40 57 69 56; ...
      14 17 22 29 51 87 80 62; ...
      18 22 37 56 68 109 103 77; ...
      24 35 55 64 81 104 113 92; ...
      49 64 78 87 103 121 120 101; ...
      72 92 95 98 112 100 103 99];
TabelaQuantizacao = TabelaQuantizacao .* entrada.q;

% des-aplica a Transformada DCT 2D: prepara os dcs
dpcm_lista = entrada.dcs;
N = size(dpcm_lista,2);
dcs_temp = zeros(1,N);
dcs_temp(1) = dpcm_lista(1);
for x=2:N
   dcs_temp(x) = dpcm_lista(x) + dcs_temp(x-1);
end

% desfaz a varredura zig-zag, refazendo os blocos a partir da seqüência 1D de valores
blocos_lista = zeros(8, 8, blocos_total);
for x=1:blocos_total
   tmp_acs = myAcs(:,x);
   tmp_bloco = zeros(1, 64);
   tmp_bloco(1) = 1 ;
   tmp_bloco(2:64) = tmp_acs(1:63);
   list = Alternador(8);
   tmp_bloco = tmp_bloco(list(:));
   tmp_bloco = reshape(tmp_bloco, 8, 8);
   blocos_lista(:,:,x) = tmp_bloco;
   
   % des-aplica a Transformada DCT 2D
   tmp_bloco = blocos_lista(:,:,x);
   tmp_bloco(1,1) = dcs_temp(x);
   blocos_lista(:,:,x) = tmp_bloco;
   blocos_lista(:,:,x) = blocos_lista(:,:,x) .* TabelaQuantizacao;
   blocos_lista(:,:,x) = inverteDCT_II( blocos_lista(:,:,x) ) ;
end

% junta os blocos 8x8 de volta em uma unica imagem
saida = junta_blocos( blocos_lista, entrada.sx, entrada.sy );

% adiciona de volta 128 do valor de cada pixel da imagem
saida = saida + 128;
saida = uint8(saida);

function saida = ExpandeCoeficientes(entrada, totalBlocks)
EOB = 9999;
entradaIndex = 1;
saidaIndex = 1;
for (j=1:totalBlocks)
   while(entrada(entradaIndex) ~= EOB)
      numOfZ = entrada(entradaIndex);
      while(numOfZ ~= 0)
         saida(saidaIndex, j) = 0;
         numOfZ = numOfZ - 1;
         saidaIndex = saidaIndex + 1;
      end
      entradaIndex = entradaIndex + 1;
      saida(saidaIndex, j) = entrada(entradaIndex);
      entradaIndex = entradaIndex + 1;
      saidaIndex = saidaIndex + 1;
   end
   entradaIndex = entradaIndex + 1;
   while(saidaIndex < 64)
      saida(saidaIndex, j) = 0;
      saidaIndex = saidaIndex + 1;
   end
   saidaIndex = 1;
end

