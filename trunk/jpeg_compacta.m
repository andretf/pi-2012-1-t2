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


	%%%%%%%%%%%%% FUNÇÕES %%%%%%%%%%%%%%%%
   
% Função DCT 2D
function retorno = myDCT2(bloco)
	tamanhoBloco= 8;
	retorno = zeros(tamanhoBloco, tamanhoBloco);

	for u = 0 : tamanhoBloco-1
   	for v = 0 : tamanhoBloco-1
      	if u == 0
         	alphaU = sqrt(1/8);
      	else
         	alphaU = sqrt(2/8);
      	end
      
      	if v == 0
         	alphaV = sqrt(1/8);
      	else
         	alphaV = sqrt(2/8);
      	end
      
      	somatorio = 0;
      
      	for x = 0 : tamanhoBloco-1
         	for y = 0 : tamanhoBloco-1
            	somatorio = somatorio + ...
            				(bloco(x+1, y+1) * ...
            				cos((pi/8) * (x + 1/2) * u) * ...
            				cos((pi/8) * (y + 1/2) * v));
         	end
      	end
      
      	retorno(u+1, v+1) = alphaU * alphaV * somatorio;
   	end
	end

  
% 3. Mostre que existe uma relação entre a distorção introduzida pela quantização (e.g. usando PSNR)
%		e o número de bits usados na quantização dos coeficientes da DCT
% ---------------------------------------------------------------------------------
% calc_snr - calculates the snr of a figure being compressed
%
% assumption: SNR calculation is done in the following manner:
%             the deviation from the original image is considered 
%             to be the noise therefore:
%
%                   noise = original_image - compressed_image
%
%             the SNR is defined as:  
%
%                   SNR = energy_of_image/energy_of_noise
%
%             which yields: 
%
%                   SNR = energy_of_image/((original_image-compressed_image)^2)
% ---------------------------------------------------------------------------------
function SNR = calc_snr(original_image, noisy_image)
	original_image_energy = sum( original_image(:).^2 );
	noise_energy = sum( (original_image(:)-noisy_image(:)).^2 );
	SNR = original_image_energy/noise_energy;

% 4. Para cada img use uma fator multiplicativo p/ a Tabela de Quantização "q" (q >= 1)
%		p/ mudar os passos de quantização especs na Tabela.

return