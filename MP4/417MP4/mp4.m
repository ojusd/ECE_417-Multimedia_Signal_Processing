function mp4(datadir)
% This reads the SPEECH TRAINING data and returns it in a 4 people x 15
% samples matrix.
tracker = 1;
datadir = 'trainspeech';
speechdata = zeros(10000,60);
featurevector = zeros(10000,1);
tracker = 1;

for i = 65:68
    for j = 1:15 %15 files for each person
        FileName = strcat(datadir, filesep, char(i), int2str(j), '.wav');
        [featurevector, Fs] = audioread(FileName);
        featurevector = imresize(featurevector(:, 1), [10000,1]);
        speechdata(:,tracker) = featurevector;
        tracker = tracker + 1;
    end
end


datadir = 'testspeech';
testspeechdata = zeros(10000,40);
testfeaturevector = zeros(10000,1);
testtracker = 1;

for i = 65:68
    for j = 1:10 %15 files for each person
        FileName = strcat(datadir, filesep, char(i), int2str(j), '.wav');
        [testfeaturevector, Fs] = audioread(FileName);
        testfeaturevector = imresize(testfeaturevector(:, 1), [10000,1]);
        testspeechdata(:,testtracker) = testfeaturevector;
        testtracker = testtracker + 1;
    end
end

% Generate CEPSTRUMS for each file.
Nw = 500; % Window size = 500
No = 0.1 * Nw; %10 percent overlap
Ncc = 12; %12 coefficients

csd = cell(1,60); %60 files to loop through
csdtest = cell(1,40);
% csd is a cell array, so each element in this array is it's own
% matrix.  A1 is cell{1}, B15 is cell{30}, etc
% csd stands for cepstrum speech data
for q = 1:60
    csd{q} = cepstrum(speechdata(:, q), Ncc, Nw, No);
end

for r = 1:40
    csdtest{r} = cepstrum(testspeechdata(:, r), Ncc, Nw, No);
end


M = 2;

cepsA = [csd{1} csd{2} csd{3} csd{4} csd{5} csd{6} csd{7} csd{8} csd{9} csd{10} csd{11} csd{12} csd{13} csd{14} csd{15}];
cepsB = [csd{16} csd{17} csd{18} csd{19} csd{20} csd{21} csd{22} csd{23} csd{24} csd{25} csd{26} csd{27} csd{28} csd{29} csd{30}];
cepsC = [csd{31} csd{32} csd{33} csd{34} csd{35} csd{36} csd{37} csd{38} csd{39} csd{40} csd{41} csd{42} csd{43} csd{44} csd{45}];
cepsD = [csd{46} csd{47} csd{48} csd{49} csd{50} csd{51} csd{52} csd{53} csd{54} csd{55} csd{56} csd{57} csd{58} csd{59} csd{60}];

%testcepsA = [csdtest{1} csdtest{2} csdtest{3} csdtest{4} csdtest{5} csdtest{6} csdtest{7} csdtest{8} csdtest{9} csdtest{10}];
%testcepsB = [csdtest{11} csdtest{12} csdtest{13} csdtest{14} csdtest{15} csdtest{16} csdtest{17} csdtest{18} csdtest{19} csdtest{20}];
%testcepsC = [csdtest{21} csdtest{22} csdtest{23} csdtest{24} csdtest{25} csdtest{26} csdtest{27} csdtest{28} csdtest{29} csdtest{30}];
%testcepsD = [csdtest{31} csdtest{32} csdtest{33} csdtest{34} csdtest{35} csdtest{36} csdtest{37} csdtest{38} csdtest{39} csdtest{40}];

GMM(1) = gmm_train (cepsA', M); 
GMM(2) = gmm_train (cepsB', M); 
GMM(3) = gmm_train (cepsC', M); 
GMM(4) = gmm_train (cepsD', M); 

%testGMM(1) = gmm_eval(testcepsA', GMM(1));
%testGMM(2) = gmm_eval(testcepsB', GMM(2));
%testGMM(3) = gmm_eval(testcepsC', GMM(3));
%testGMM(4) = gmm_eval(testcepsD', GMM(4));


cep_acc_vals = zeros(1,4);
cep_prob = zeros(40, 4);
%next = zeros(40,1);
for t = 1 : 40
prob = zeros(1,4);
for c = 1:4

    prob(1,c) = gmm_eval(csdtest{t}', GMM(c));
    cep_prob(t,c) = prob(1,c);
end
   
end  

result = zeros(40, 1);
for q = 1:40
[~, result(q,:)] = max(cep_prob(q, :));
end
true_val = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4];


for j = 1:10
    
    if result(j,1) == true_val(1, j)
        cep_acc_vals(1,1) = cep_acc_vals(1,1) + 1;
    end
end

for j = 11:20
    
    if result(j,1) == true_val(1, j)
        cep_acc_vals(1,2) = cep_acc_vals(1,2) + 1;
    end
end

for j = 21:30
    
    if result(j,1) == true_val(1, j)
        cep_acc_vals(1,3) = cep_acc_vals(1,3) + 1;
    end
end

for j = 31:40
    
    if result(j,1) == true_val(1, j)
        cep_acc_vals(1,4) = cep_acc_vals(1,4) + 1;
    end
end

cep_acc_vals = cep_acc_vals * 10;
%disp(cep_acc_vals)
%id = argmax{testGMM(1), testGMM(2), testGMM(3), testGMM(4)};

%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

% We have to complete the PCA projection onto the subspace here

sizeX = 90;
sizeY = 70;
data_dir = 'trainimg';
rawImgMat = zeros(sizeX*sizeY,40); %40 cuz there's 40 images, A-D, 1-10
three_dim_data = zeros(sizeX,sizeY,40);
tracker = 1;
for i = 65:68 %
    for n = 1:10
        imgName = strcat(data_dir,filesep,char(i),int2str(n),'.jpg');
        curImg = double(rgb2gray(imread(imgName)));
        % STEP 2a: EXTRACT RAW DATA
        three_dim_data(:,:,tracker) = curImg;
        rawImgMat(:,tracker) = reshape(curImg,[sizeX*sizeY,1]);
        tracker = tracker+1;
    end
end

rawImgMat = rawImgMat';
[pca_eigs, N] = pca(rawImgMat);
k_val = 10;
idx_vals = [1, 11, 21, 31];
class_vals = [65,66, 67,68];

sizeX = 90;
sizeY = 70;
data_dir = 'testimg';
testrawImgMat = zeros(sizeX*sizeY,40); %40 cuz there's 40 images, A-D, 1-10
three_dim_data = zeros(sizeX,sizeY,40);
testtracker = 1;
for i = 65:68 %
    for n = 11:20
        imgName = strcat(data_dir,filesep,char(i),int2str(n),'.jpg');
        curImg = double(rgb2gray(imread(imgName)));
        % STEP 2a: EXTRACT RAW DATA
        three_dim_data(:,:,testtracker) = curImg;
        testrawImgMat(:,testtracker) = reshape(curImg,[sizeX*sizeY,1]);
        testtracker = testtracker+1;
    end
end

testrawImgMat = testrawImgMat';



visual_acc_vals = zeros(1,4);
visual_prob = zeros(40, 4);
next = zeros(40,1);
for t = 1 : 40
knn_prob = zeros(1,4);
for c = 1:4

    [~, knn_prob] = get_accuracy(rawImgMat', testrawImgMat(t,:)', 10, char(c+64));
    visual_prob(t,c) = knn_prob(1,c);
end
   
end  

result2 = zeros(40, 1);
for q = 1:40
[~, result2(q,:)] = max(visual_prob(q, :));
end
true_val2 = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4];


for j = 1:10
    
    if result2(j,1) == true_val2(1, j)
        visual_acc_vals(1,1) = visual_acc_vals(1,1) + 1;
    end
end

for j = 11:20
    
    if result2(j,1) == true_val2(1, j)
        visual_acc_vals(1,2) = visual_acc_vals(1,2) + 1;
    end
end

for j = 21:30
    
    if result2(j,1) == true_val2(1, j)
        visual_acc_vals(1,3) = visual_acc_vals(1,3) + 1;
    end
end

for j = 31:40
    
    if result2(j,1) == true_val2(1, j)
        visual_acc_vals(1,4) = visual_acc_vals(1,4) + 1;
    end
end

visual_acc_vals = visual_acc_vals * 10;
%disp(visual_acc_vals)
cep_acc_vals= horzcat(cep_acc_vals, mean(cep_acc_vals(:), 1));
visual_acc_vals = horzcat(visual_acc_vals, mean(visual_acc_vals(:), 1));
w=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

final_av_vals = zeros(4,9);

for j = 1: 9
final_av_vals(:,j) = av_helper(visual_prob, cep_prob, w(j));
end
avg = zeros(1,9);
for j = 1:9
    avg(j) = mean(final_av_vals(:, j), 1);
end

final_av_vals = vertcat(final_av_vals, avg);
visual_acc_vals = reshape(visual_acc_vals, [5,1]);
cep_acc_vals = reshape(cep_acc_vals, [5,1]);

fprintf('\n--------- Person ID Accuracy: Visual Only -----------\n');
array2table(visual_acc_vals, 'VariableNames', {'Acc'}, 'RowNames', {'A','B','C', 'D', 'Avg'})   % Acc = [5 x 9] matrix of accuracies
 fprintf('--------------------\n'); 
 
 fprintf('\n--------- Person ID Accuracy: Audio Only -----------\n');
array2table(cep_acc_vals, 'VariableNames', {'Acc'}, 'RowNames', {'A','B','C', 'D', 'Avg'})   % Acc = [5 x 9] matrix of accuracies
 fprintf('--------------------\n'); 
 
fprintf('\n--------- Person ID Accuracy: Audio + Visual -----------\n');
array2table(final_av_vals, 'VariableNames', {'w_01', 'w_02', 'w_03', 'w_04' , 'w_05', 'w_06', 'w_07', 'w_08', 'w_09'}, 'RowNames', {'A','B','C', 'D', 'Avg'})   % Acc = [5 x 9] matrix of accuracies
 fprintf('--------------------\n'); 
