rgbImage = imread('../replay.jpg');
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
numberOfBins = 256;
[counts1, y] = hist(h(:), numberOfBins);
rgbImage = imread('../replay1.jpg');
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
[counts2, y] = hist(h(:), numberOfBins);
rgbImage = imread('../replay2.jpg');
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
[counts3, y] = hist(h(:), numberOfBins);
max_frames = 30000;
c = zeros(0, 1);
c1 = zeros(0, 1);
c2 = zeros(0, 1);
 for i=1:max_frames
      rgbImage = imread(sprintf('../images/img%d.jpg',i));
      hsv = rgb2hsv(rgbImage);
      h = hsv(:,:,1);
      [count, y] = hist(h(:), numberOfBins);
      c = [c, sum(abs(counts1(:) - count(:)))];
      display(sprintf('%d - difference calculated with replay1',i));
 end
 for i=1:max_frames
      rgbImage = imread(sprintf('../images/img%d.jpg',i));
      hsv = rgb2hsv(rgbImage);
      h = hsv(:,:,1);
      [count, y] = hist(h(:), numberOfBins);
      c1 = [c1, sum(abs(counts2(:) - count(:)))];
      display(sprintf('%d - difference calculated with replay2',i));
 end
 for i=1:max_frames
      rgbImage = imread(sprintf('../images/img%d.jpg',i));
      hsv = rgb2hsv(rgbImage);
      h = hsv(:,:,1);
      [count, y] = hist(h(:), numberOfBins);
      c2 = [c2, sum(abs(counts3(:) - count(:)))];
      display(sprintf('%d - difference calculated with replay3',i));
 end
 m = (mean(c)+mean(c1)+mean(c2))/9;
 x = zeros(0,1);
  for i=1:size(c)
      display(sprintf('%d - checking HHD',i));
      if c(i) <= m
          x = [x,i];
      end
  end
  for i=1:size(c1)
      display(sprintf('%d - checking HHD',i));
      if c1(i) <= m
          x = [x,i];
      end
  end
  for i=1:size(c2)
      display(sprintf('%d - checking HHD',i));
      if c2(i) <= m
          x = [x,i];
      end
  end
  
  display(x);