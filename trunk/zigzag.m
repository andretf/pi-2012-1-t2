function v = zigzag(m)
	%Função que constrói o vetor v a partir da matriz m percorrida em zigzag.
	%inicializa o vetor v
	v = [];

	%i indexa as linhas que serão acessadas em zigzag
	i = [ 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];

	%j indexa as colunas que serão acessadas em zigzag
	j = [ 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];	

	%acessa os elementos de m indexados por i e j e coloca-os no vetor v
	for x = 1 : size(i, 2)
		v = [v, m(i(x), j(x))];
	end

return
