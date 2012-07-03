% Elimina 0's no vetor v
% RunLength / Cod. Huffman

function ret = runLength(AC)
EOB = 255;		% S�mbolo End-Of-Block
iZeros = 0;		% contador dos zeros (n)
pos = 1;			% Ind�ce atual no vetor de restorno


for i = 1 : size(AC, 2);
   
   % vai incrementando os zeros
   if AC(i) == 0
		iZeros = iZeros + 1;
   else
      % quando o elemento for diferente de zero
      % atribui os zeros � posi�a� e o elemento � seguinte
      % (1)  O si�mbolo (n) denota quantos zeros precedem um AC na~o-nulo;
      
      ret(pos) = iZeros;
      
      % (2) O n�mero (ex: 7, 1 ou 19) � a palavra-s�mbolo que representa a corrida de 
      % zeros, e a distribui��o de coeficientes quantizados ser� agora representada 
      % pela distribui��o de palavras-s�mbolo � ou seja, voc� ter� um dicion�rio de 
      % palavras-s�mbolo e uma distribui��o das suas ocorr�ncias nas corridas de 
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

% (3) O s�mbolo EOB (end of block) representa o final do bloco
ret(pos) = EOB;

return