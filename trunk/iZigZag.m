
function resp = iZigZag(v);
% É a função inversa à zigZag: dado um vetor v, resultante da aplicação
% da função zigzag em uma matriz, reconstrói a matriz original

%inicializa a matriz resposta com zeros
resp = zeros(8);

%i indexa as linhas que serão acessadas em zigzag
i=[ 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];

%j indexa as colunas que serão acessadas em zigzag
j=[ 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];	

%para cada elemento do vetor coloca ele na posição indexada por i e j na matriz
for x=1:size(v, 2)
   resp(i(x),j(x)) = v(1, x);
end;
