
%T1 = T2 = 65, T3 = 10
%if (FP2>T1)& (FP11+FP12)>T2 -long view
%else if (FP11-FP12)>T3 - boundary view
%else pitch view.
img = sprintf('images/img1.jpg');
rgbImage = imread(img);
[r, c, numColorChannels] = size(rgbImage);
x = r*c;
r2 = r/2;
c2 = c/2;
x1 = r2*c2;
x2 = r2*c;
numberOfBins = 256;
T1 = 65;
T2 = 65;
T3 = 10;
fName = 'fieldview_kolekar.csv';
fid = fopen(fName, 'w');

for i= 1:9:37105
    img = sprintf('images/img%d.jpg', i);
    rgbImage = imread(img);
    hsv = rgb2hsv(rgbImage);
    h = hsv(:,:,1);
    [count, y] = hist(h(:), numberOfBins);
    FP = sum(count(52:62))/x;
    h = hsv(1:r2,1:c2,1);
    [count, y] = hist(h(:), numberOfBins);
    FP11 = sum(count(52:62))*100/(x1);
    h = hsv(1:r2,c2:c,1);
    [count, y] = hist(h(:), numberOfBins);
    FP12 = sum(count(52:62))*100/(x1);
    h = hsv(r2:r,1:c,1);
    [count, y] = hist(h(:), numberOfBins);
    FP2 = sum(count(52:62))*100/(x2);
    class = 'pitch';
    if (FP2 >= T1) && ((FP11 + FP12)>=T2)
        class = 'long';
    elseif ((FP11-FP12)>T3)
        class = 'boundary';
    end
    disp(sprintf('%d as - %s', i,class));
    fprintf(fid, ',%s,%f,%f,%f,%f,%s,%s\r\n', img,FP,FP11,FP12,FP2,class,class);
end
fclose(fid);