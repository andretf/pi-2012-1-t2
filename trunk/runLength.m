% Elimina 0's no vetor v
% RunLength / Cod. Huffman

function ret = runLength(AC)
EOB = 255;		% Símbolo End-Of-Block
iZeros = 0;		% contador dos zeros (n)
pos = 1;			% Indíce atual no vetor de restorno


for i = 1 : size(AC, 2);
   
   % vai incrementando os zeros
   if AC(i) == 0
		iZeros = iZeros + 1;
   else
      % quando o elemento for diferente de zero
      % atribui os zeros à posiçaõ e o elemento à seguinte
      % (1)  O si´mbolo (n) denota quantos zeros precedem um AC na~o-nulo;
      
      ret(pos) = iZeros;
      
      % (2) O número (ex: 7, 1 ou 19) é a palavra-símbolo que representa a corrida de 
      % zeros, e a distribuição de coeficientes quantizados será agora representada 
      % pela distribuição de palavras-símbolo – ou seja, você terá um dicionário de 
      % palavras-símbolo e uma distribuição das suas ocorrências nas corridas de 
      % todos os blocos da imagem;
      
      ret(pos + 1) = AC(i);
      
      pos = pos + 2;
		iZeros = 0;
	end
end

if (iZeros > 0)
   ret(pos) = iZeros;
	pos = pos + 1;
end

% (3) O símbolo EOB (end of block) representa o final do bloco
ret(pos) = EOB;

return