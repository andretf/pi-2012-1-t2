function ret = main()
clear all;
I = imread('lenna.bmp');
figure, imshow(I);

for q = 1 : 5 : 15
   jpg = jpeg_compacta(I, q);
   J = jpeg_descompacta(jpg);
   psnr(I, J)
end;

figure, imshow(J);

