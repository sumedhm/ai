I = imread('img8174.jpg');
YCBCR = rgb2ycbcr(I);
Y = YCBCR(:,:,1);
bw = edge(Y,'canny');
count = nnz(bw);
[r, c, x] = size(bw);
EP = count*100/(r*c);
disp(EP);
%T4 = 10
%STIP space time interest point LATp (close up, kind of shots)