% Faz o caulclo do psnr

function ret = main(original)

for q = 1 : 3 : 10
   J = jpeg_descompacta(jpeg_compacta(original, q));
   figure, imshow(J, title('q = ' + q));
   q
   psnr(original, J)
end;

