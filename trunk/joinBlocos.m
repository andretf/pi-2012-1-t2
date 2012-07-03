%% Junta os blocos 8x8 numa matriz
% lenna é 512x512... então qtdBlocos por linha = qtdBlocos por coluna.

function matriz = joinBlocos(G)
qtdBlocos = size(G, 3);
dim_i = qtdBlocos/size(G, 1);
dim_j = qtdBlocos/size(G, 2);
matriz = zeros(dim_i, dim_j);
x = 1; % contador

for i = 0 : (dim_i - 1)/8
   xFrom = i * 8 + 1;
   xTo = i * 8 + 8;
   for j = 0 : (dim_j - 1)/8
      yFrom = j * 8 + 1;
      yTo = j * 8 + 8;
      matriz(xFrom:xTo, yFrom:yTo) = G( :, :, x);
      x = x + 1;
   end
end

return