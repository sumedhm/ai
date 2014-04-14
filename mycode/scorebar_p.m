fName = 'output2.csv';
fid = fopen(fName, 'w');
im1 = rgb2gray(imread('../scorebar.jpg'));
im2 = rgb2gray(imread('../images/img2.jpg'));
[r, c, x] = size(im2);
numberOfBins = 256;
r1 = 6*r/7;
    
for i= 1:37105
    img = sprintf('../images/img%d.jpg', i);
    im2 = rgb2gray(imread(img));
    im2 = im2(r1:r,:,1);
    [counts, y] = imhist(im2, numberOfBins);
    [count, y] = imhist(im1, numberOfBins);
    c = sum(abs(counts(:) - count(:)));
    x = 'no';
    if(c > 8000)
        x = 'yes';
    end
    disp(sprintf('%d,%s,%d,%s,%s\r\n', i, img, c, x ,x));
    fprintf(fid, ',%s,%d,%s,%s\r\n', img, c, x ,x);
end
fclose(fid);