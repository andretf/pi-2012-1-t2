
function resp = iZigZag(v);
% � a fun��o inversa � zigZag: dado um vetor v, resultante da aplica��o
% da fun��o zigzag em uma matriz, reconstr�i a matriz original

%inicializa a matriz resposta com zeros
resp = zeros(8);

%i indexa as linhas que ser�o acessadas em zigzag
i=[ 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];

%j indexa as colunas que ser�o acessadas em zigzag
j=[ 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];	

%para cada elemento do vetor coloca ele na posi��o indexada por i e j na matriz
for x=1:size(v, 2)
   resp(i(x),j(x)) = v(1, x);
end;
