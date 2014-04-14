im01 = imread('replay.jpg');
im02 = imread('../replay1.jpg');
im1 = rgb2gray(im01);
im2 = rgb2gray(im02);
F1 = fftshift(fft2(im1));
F2 = fftshift(fft2(im2));
[r1, c1, d1] = size(im1);
[r2, c2, d2] = size(im2);
F = F1.*conj(F2);
F = F./abs(F);
mag = (ifft2(F));
[X, Y] = find((mag == (max(max(mag)))));
if im1(1,1)==im2(end-X,end-Y)
    img = zeros(r2-X+r1,c2-Y+c1,3);
	img = cast(img,'uint8');
	img(1:r2,1:c2,:)=im02;
	img(r2-X:r2-X+r1-1,c2-Y:c2-Y+c1-1,:)=im01;
else
    img = zeros(X+r2,Y+c2,3);
	img = cast(img,'uint8');
	img(1:r1,1:c1,:)=im01;
	img(X:X+r2-1,Y:Y+c2-1,:)=im02;
end
img=cast(img,'uint8');
imshow(img);
imout = imcrop(img);