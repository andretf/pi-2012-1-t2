function resp = iDPCM(vec);
% Função inversa à DPCM: dado um vetor compactado com
% a funçao de compressão preditiva DPCM, retorna o vetor original

for x = 2:size(vec,1)
   % Para cada elemento, substitui-o por ele mais o anterior
   vec(x)=vec(x, 1)+vec(x-1, 1);
end

resp = vec;