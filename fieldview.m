rgbImage = imread('img7517.jpg');
[r, c, numColorChannels] = size(rgbImage);
numberOfBins = 256;
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
[count, y] = hist(h(:), numberOfBins);
FP = sum(count(52:62))/(r*c);
r2 = r/2;
c2 = c/2;
h = hsv(1:r2,1:c2,1);
[count, y] = hist(h(:), numberOfBins);
FP11 = sum(count(52:62))*100/(r2*c2);
h = hsv(1:r2,c2:c,1);
[count, y] = hist(h(:), numberOfBins);
FP12 = sum(count(52:62))*100/(r2*c2);
h = hsv(r2:r,1:c,1);
[count, y] = hist(h(:), numberOfBins);
FP2 = sum(count(52:62))*100/(r2*c);
display([FP, FP11, FP12, FP2]);
%T1 = T2 = 65, T3 = 10
%if (FP2>T1)& (FP11+FP12)>T2 -long view
%else if (FP11-FP12)>T3 - boundary view
%else pitch view.