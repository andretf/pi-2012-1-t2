function retorno= entropia_e_compressao(im) 
%lista de acs e dcs
dcs_lista = im.field_DC( : );
acs_lista = im.field_AC( : );

numOfTimes = size(dcs_lista,1);
%prepara a lista de acs para calcular a entropia
start = size(acs_lista,1);
for x = 1:numOfTimes
   acs_lista( start + x ) = dcs_lista(x);
end

[retorno.entropia, retorno.total_simbolos] = entropia(acs_lista);

% (3) o nu´mero total de bits e´ o produto do nu´mero de “si´mbolos” da sequ¨e^ncia
% pelo nu´mero de bits necessa´rio para codificar cada um dos “si´mbolos”
% com o co´digo o´timo (este nu´mero e´ dado pela entropia da distribuic¸a~o encontrada);
retorno.total_de_bits = retorno.entropia * retorno.total_simbolos;

tamanho_da_imagem = 256 * 256 * 8;

retorno.tamanho_relativo_ao_original = retorno.total_de_bits / tamanho_da_imagem;

% (4) Observe a taxa de compressao total obtida
retorno.taxa_de_compressao = tamanho_da_imagem / retorno.total_de_bits;