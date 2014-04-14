template = rgb2gray(imread('../replay.jpg'));
max_frames = 37105;
c = zeros(0, 1);
 for i=1:max_frames
      rgbImage = rgb2gray(imread(sprintf('../images/img%d.jpg', i)));
      r = corr2(template, rgbImage);
      disp(sprintf('seen - ../images/img%d.jpg', i));
      disp(r);
      if r >= 0.65
        c = [c, i];
      end
 end
 disp(c);