rgbImage = imread('replay.jpg');
[rows, columns, numberOfColorBands] = size(rgbImage);
totalPixels = rows*columns;
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
numberOfBins = 256;
[pixelCount, grayLevels] = hist(h(:), numberOfBins);
c = sum(pixelCount(52:62));
vdgpr = c/totalPixels;
display(vdgpr);