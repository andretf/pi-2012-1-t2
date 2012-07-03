%% Junta os blocos 8x8 numa matriz
% Supõe que a imagem seja quadrada

function matriz = joinBlocos(G)
qtdBlocos = size(G, 3);
dim = sqrt(qtdBlocos);
matriz = zeros(dim, dim);
x = 1; % contador

for i = 0 : (dim - 1)
   xFrom = i * 8 + 1;
   xTo = i * 8 + 8;
   for j = 0 : (dim - 1)
      yFrom = j * 8 + 1;
      yTo = j * 8 + 8;
      matriz(xFrom:xTo, yFrom:yTo) = G( :, :, x);
      x = x + 1;
   end
end

return