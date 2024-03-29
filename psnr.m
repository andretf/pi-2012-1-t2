% Imagem
% Comprimida
function output = psnr(original, noisy)
original = double(original);
noisy = double(noisy);
I_max = max(max(original));
I_min = min(min(original));
A = (I_max - I_min);
output = 10*log10((A^2)/(std2(original - noisy)^2));