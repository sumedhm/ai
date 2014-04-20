%1-fielders
%2-crowdview
CV = [[20097,20175,1];[20481,20566,1];[128636,128750,1];[138024,138054,1];
	[20255,20396,2];[21861,21926,2];[22333,23000,2];[117496,117627,2];
	[118572,118655,2];[119177,119257,2];[120884,120971,2];[122396,122502,2];
	[124294,124383,2];[124944,125039,2];[128848,128914,2];[132764,132804,2];
	[133176,133362,2];[136137,136197,2];[139592,139652,2];[118016,118177,2]];

fName = 'fielder_crowd_svm.csv';
fid = fopen(fName, 'w');

TD = [[20176,20251,1];[128751,128843,1];[138055,138133,1];[20569,21044,1];
	[22869,22923,2];[23001,23420,2];[142701,142752,2];[142996,143075,2];
	[143632,143738,2];[1499552,149915,2];[150624,150695,2];[151560,151611,2]]; %test data
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
       img = sprintf('../images1/img%d.jpg', j);
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
        img = sprintf('../images1/img%d.jpg', j);
        I = rgb2hsv(imread(img));
        test = transp(imhist(I(:,:,1)));
        label = svmclassify(SVMtrainedcv, test);
        disp(sprintf('testing - %d, class - %d', j, label));
        fprintf(fid, ',%s,%d,%d\r\n', img, label, class);       
    end
end

fclose(fid);