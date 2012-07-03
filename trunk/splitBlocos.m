% Devolve os blocos 8x8 da imagem
function retorno = splitBlocos(I)
qtdBlocos = size(I, 1) / 8; % lenna é 512x512... então qtdBlocos por linha = qtdBlocos por coluna.
retorno = zeros(8, 8, qtdBlocos);
bloco = zeros(8, 8);
i = 1; % contador

% calcula as coordenadas em pixeis de um bloco – limites do bloco
for x = 0 : (qtdBlocos - 1)
   xFrom = x * 8 + 1;
   xTo = x * 8 + 8;
   for y = 0 : (qtdBlocos - 1)
      yFrom = y * 8 + 1;
      yTo = y * 8 + 8;
      retorno( :, :, i) = I(xFrom:xTo, yFrom:yTo);
	   i = i + 1;
   end
end

return