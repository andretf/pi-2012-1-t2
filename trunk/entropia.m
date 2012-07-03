
function [H_entropia, total_simbolos] = entropia(acs_lista)
vetor = double(acs_lista(:));
vetor = sort(vetor);
[total_simbolos, sy] = size(vetor); iguais = 1;
contador = 1;
    for i=2:total_simbolos
       if (vetor(i) == vetor(i-1))
          iguais = iguais + 1;
       else
       	freq(1,contador) = iguais;
			iguais = 1;
			contador = contador + 1;	
      end 
   end

freq(1,contador) = iguais;
prob = zeros(1, contador);
prob(1,:) = double(freq(1,:)) ./ double(total_simbolos);
H_entropia = double(0);

for i=1:contador
	H_entropia = H_entropia - prob(1,i)*log2(prob(1,i));
end