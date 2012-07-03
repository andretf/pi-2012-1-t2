function res = iRunLength(AC)
EOB = 255;
res = [];

% k guarda a posição atual no vetor de saída
k = 1;
ibloco = 1;
proximozeros = 1;

for i = 1 : size(AC, 2);
   if AC(i) == EOB
      for j = ibloco : 63
         res(k) = 0;
         k = k+1;
      end;
      ibloco = 1;
      proximozeros = 1;
      
   elseif proximozeros == 1
      for l = 1:AC(i)
         res(k) = 0;
         k = k+1;
         ibloco = ibloco+1;
      end;
      proximozeros = 0;
      
   elseif proximozeros == 0
      res(k) = AC(i);
      k = k+1;
      ibloco = ibloco+1;
      proximozeros = 1;
   end
end

return

      
