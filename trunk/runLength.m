function resp  =  runLength(v)
% Elimina corridas de zeros no vetor v
% Utiliza a seguinte sintaxe:

%Simbolo que marca o fim do bloco.
EOB = 255;

% incicia a contagem dos zeros do vetor
nzeros = 0;
k = 1;
for i = 1:size(v,2);
   if v(i) == 0
		nzeros = nzeros+1;
   else
      % quando o elemento for diferente de zero
      % atribui os zeros à posiçaõ e o elemento à seguinte
		resp(k) = nzeros;
		resp(k+1) = v(i);
		k = k+2;
		nzeros = 0;
	end
end

% verifica a colocação do último marcador
if (nzeros  == 0)
   resp(k) = EOB;
else
   resp(k) = nzeros;
   resp(k+1) = EOB;
end

return