%1-longview
%2-non-longview
LV = [[590,624,1];[1173,1199,1];[1229,1287,1];[1555,1647,1];
    [3325,3332,1];[4341,4436,1];[6229,6259,1];[7517,7548,1];
    [9034,9065,1];[9990,10024,1];[11749,11776,1];[13781,13850,1];
    [15029,15108,1];[15341,15572,1];[19489,19500,1];[26018,26029,1];
    [26619,26633,1];[26950,26996,1];[28363,28387,1];
    [30135,30142,1];[30363,30380,1];[31374,31395,1];
    [30406,30437,1];
    [1653,1760,2];[3256,3316,2];[3385,3447,2];[6853,6884,2];
    [8957,9008,2];[9305,9328,2];[9401,9448,2];[9720,9772,2];
    [9941,9964,2];[10413,10428,2];[16138,16172,2];
    [16461,16470,2];[19375,19409,2];[22965,23000,2];
    [24525,24548,2];[29514,29530,2];[29502,29513,2];
    [625,713,2];[1141,1166,2];[1205,1222,2];[1288,1393,2];
    [2117,2136,2];[2149,2172,2];[2199,2223,2];[2645,2732,2];
    [2741,2812,2];[3340,3363,2];[4094,4152,2];[4457,4544,2];
    [4667,4717,2];[5262,5328,2];[5333,5453,2];[5927,6048,2];
    [6178,6213,2];[6788,6828,2];[6925,7038,2];[7377,7469,2];
    [10370,10381,2];[10542,10582,2];[10961,11020,2];
    [13953,13980,2];[20008,20028,2];[28978,29002,2];
    [29456,29480,2];[20035,20067,2];[20108,20138,2];
    [20548,20606,2];[21308,21365,2];[21890,21943,2];
    [22507,22571,2];[28877,28906,2];[27620,27647,2];
    [24030,24070,2];[28315,28359,2];
    [30386,30405,2];[30438,30446,2];[26940,26944,2];
    ];
fName = 'longview_svm.csv';
fid = fopen(fName, 'w');    

TD = [[15165,15197,1];[16081,16119,1];[16174,16216,1];
    [23197,23213,1];[23509,23557,1];[24637,24711,1];
    [24993,25020,1];[26025,26055,1];[23193,23213,1];
    [26949,26968,1];[23490,23557,1];[28388,28396,1];
    [28925,28976,1];[30339,30353,1];[31396,31406,1];
    [28363,28396,1];[31736,31779,1];
    [8947,8965,2];[9400,9448,2];[9720,9777,2];
    [12313,12378,2];[19410,19452,2];[20721,20736,2];
    [23001,23088,2];[24525,24547,2];[24965,24980,2];
    [26581,26604,2];[26643,26658,2];[26649,26658,2];
    [537,578,2];[897,996,2];[2115,2223,2];[2733,2812,2];
    [3340,3355,2];[3448,3555,2];[4737,4772,2];[7360,7377,2];
    [7470,7503,2];[8074,8098,2];[8105,8151,2];[8339,8377,2];
    [8909,8943,2];[9881,9914,2];[10382,10390,2];[11700,11728,2];
    [12260,12282,2];[12379,12413,2];[12791,12807,2];[12825,12853,2];
    [13341,13360,2];
    ]; %test data
x = 0;

for i = 1:size(LV)
   for j = LV(i, 1):LV(i, 2)
        x = x + 1;
   end
end

no_of_training_data = x;
training_data = zeros(no_of_training_data, 256);
labels = zeros(1, no_of_training_data);
x = 1;
for i = 1:size(LV)
   for j = LV(i, 1):LV(i, 2)
       class = LV(i, 3);
       img = sprintf('../images/img%d.jpg', j);
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
SVMtrainedlv = svmtrain(training_data, labels);

x = 1;
for i = 1:size(TD)
    for j = TD(i,1):TD(i,2)
        class = TD(i, 3);
        img = sprintf('../images/img%d.jpg', j);
        I = rgb2hsv(imread(img));
        test = transp(imhist(I(:,:,1)));
        label = svmclassify(SVMtrainedlv, test);
        disp(sprintf('testing - %d, class - %d', j, label));
        fprintf(fid, ',%s,%d,%d\r\n', img, label, class);       
    end
end

fclose(fid);