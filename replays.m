workingDir = '.';
mkdir(workingDir);
mkdir(workingDir, 'images');
matchVideo = VideoReader('video2.mp4');
for i = 1:matchVideo.NumberOfFrames
    img = read(matchVideo, i);
    imwrite(img, fullfile(workingDir,'images',sprintf('img%d.jpg',i)));
end