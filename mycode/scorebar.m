im1 = rgb2gray(imread('replay3.jpg'));
im2 = rgb2gray(imread('scorebar1.jpg'));
[r, c, x] = size(rgbImage);
numberOfBins = 256;
r1 = 6*r/7;
im1 = im1(r1:r,:,1);
[counts, y] = imhist(im1, numberOfBins);
[count, y] = imhist(im2, numberOfBins);
c = sum(abs(counts(:) - count(:)));
disp(c);