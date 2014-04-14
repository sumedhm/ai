fName = 'output1.csv';
fid = fopen(fName, 'w');    
for i= 1:20:37105
    img = sprintf('images/img%d.jpg', i);
    I = imread(img);
    YCBCR = rgb2ycbcr(I);
    Y = YCBCR(:,:,1);
    bw = edge(Y,'canny');
    count = nnz(bw);
    [r, c, x] = size(bw);
    EP = count*100/(r*c);
    x = 'closeup';
    if(EP>10)
        x = 'crowd';
    end
    fprintf(fid, ',%s,%f,%s,%s\r\n', img, EP, x, x);
end
fclose(fid);