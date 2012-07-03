function vetor = DPCM(vetor)
% Representa cada elemento do vetor vec pela sua diferença para o elemento anterior
% Iniciamos pelo último elemento e iteramos até o segundo

for x = size(vetor, 1) : -1 : 2
   % Para cada elemento, substitui-o por ele menos o anterior
   vetor(x,1) = vetor(x, 1) - vetor(x-1, 1);
end

return