% Inverso da RunLength / Cod. Huffman

function ret = iRunLength(AC)
EOB = 255;		% Símbolo End-Of-Block
pos = 1;			% Indíce atual no vetor de restorno
iZeros = 1;		% contador dos zeros (n)
iBloco = 1;
ret = [];

for i = 1 : size(AC, 2);
	% (3)
   if AC(i) == EOB
      for j = iBloco : 63
         ret(pos) = 0;
         pos = pos + 1;
      end;
      iBloco = 1;
      iZeros = 1;
     
	% (2)
   elseif iZeros == 1
      for l = 1 : AC(i)
         ret(pos) = 0;
         pos = pos + 1;
         iBloco = iBloco + 1;
      end;
      iZeros = 0;
      
	% (1)
   elseif iZeros == 0
      ret(pos) = AC(i);
      pos = pos + 1;
      iBloco = iBloco + 1;
      iZeros = 1;
   end
end

return

      
