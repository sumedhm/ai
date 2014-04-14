fName = 'output.csv';
fid = fopen(fName, 'w');    
for i= 2000:20:37105
    img = sprintf('images/img%d.jpg', i);
    rgbImage = imread(img);
    [rows, columns, numberOfColorBands] = size(rgbImage);
    totalPixels = rows*columns;
    hsv = rgb2hsv(rgbImage);
    h = hsv(:,:,1);
    numberOfBins = 256;
    [pixelCount, grayLevels] = hist(h(:), numberOfBins);
    c = sum(pixelCount(52:62));
    vdgpr = c/totalPixels;
    x = 'no';
    if(vdgpr>0.7)
        x = 'yes';
    end
    fprintf(fid, ',%s,%f,%s,%s\r\n', img, vdgpr,x , x);
end
fclose(fid);