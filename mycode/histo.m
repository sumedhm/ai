rgbImage = imread('replay.jpg');
hsv = rgb2hsv(rgbImage);
h = hsv(:,:,1);
numberOfBins = 256;
[counts, y] = hist(h(:), numberOfBins);
max_frames = 37100;
c = zeros(max_frames, 1);
 for i=1:max_frames
      rgbImage = imread(sprintf('../images/img%d.jpg',i));
      hsv = rgb2hsv(rgbImage);
      h = hsv(:,:,1);
      [count, y] = hist(h(:), numberOfBins);
      c(i) = sum(abs(counts(:) - count(:)));
      display(sprintf('%d - difference calculated',i));
 end
 m = mean(c)/3;
 x = zeros(0,1);
  for i=1:max_frames
      display([i, ' checking HHD']);
      if c(i) <= m
          x = [x,i];
      end
  end
  display(x);