%1-closeupview
%2-crowdview
CV = [];
fName = 'closeup_crowd_svm.csv';
fid = fopen(fName, 'w');    

TD = []; %test data
x = 0;

for i = 1:size(CV)
   for j = CV(i, 1):CV(i, 2)
        x = x + 1;
   end
end

no_of_training_data = x;
training_data = zeros(no_of_training_data, 256);
labels = zeros(1, no_of_training_data);
x = 1;

for i = 1:size(CV)
   for j = CV(i, 1):CV(i, 2)
       class = CV(i, 3);
       img = sprintf('images/img%d.jpg', j);
       disp(sprintf('training - %d - class - %d', j, class));
       fprintf(fid, ',%s,%d,manual\r\n', img, class);
       I = rgb2hsv(im2double(imread(img)));
       I = imhist(I(:,:,1));
       training_data(x,:) = I;
       labels(x) = class;
       x = x + 1;
   end
end
disp('Training svm');
SVMtrainedcv = svmtrain(training_data, labels);

x = 1;
for i = 1:size(TD)
    for j = TD(i,1):TD(i,2)
        class = TD(i, 3);
        img = sprintf('images/img%d.jpg', j);
        I = rgb2hsv(imread(img));
        test = transp(imhist(I(:,:,1)));
        label = svmclassify(SVMtrainedcv, test);
        disp(sprintf('testing - %d, class - %d', j, label));
        fprintf(fid, ',%s,%d,%d\r\n', img, label, class);       
    end
end

fclose(fid);