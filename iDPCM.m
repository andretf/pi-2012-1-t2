function resp = iDPCM(vec);
% Fun��o inversa � DPCM: dado um vetor compactado com
% a fun�ao de compress�o preditiva DPCM, retorna o vetor original

for x = 2:size(vec,1)
   % Para cada elemento, substitui-o por ele mais o anterior
   vec(x)=vec(x, 1)+vec(x-1, 1);
end

resp = vec;