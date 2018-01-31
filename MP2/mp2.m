%STEP 1:  READ DATA
function mp2(data_dir)
tic
sizeX = 90;
sizeY = 70;
%datadir = 'newimdata';
rawImgMat = zeros(sizeX*sizeY,80);
three_dim_data = zeros(sizeX,sizeY,80);
x = 1;
for i = 65:68 % --- Loop for building rawImgMat --- RAW IMAGE DATA
    for n = 1:20
        imgName = strcat(data_dir,filesep,char(i),int2str(n),'.jpg');
        curImg = double(rgb2gray(imread(imgName)));
        % STEP 2a: EXTRACT RAW DATA
        three_dim_data(:,:,x) = curImg;
        rawImgMat(:,x) = reshape(curImg,[sizeX*sizeY,1]);
        x = x+1;
    end
end
meanImg = mean(rawImgMat,2);
pcaImgMat = bsxfun(@minus,rawImgMat,meanImg);

[pca_features, N] =  pca(pcaImgMat);

% STEP 2c:
rand_eig = randn(6300,N);
rand_projection= rand_eig'*rawImgMat;

k_vals = [1,5];
idx_vals = [1,21,41,61];
class_vals = [65,66,67,68];
%---------------------------RAW 90x70 IMAGE FEATURES--------------------%
raw90_acc_vals = [0,0,0,0;0,0,0,0];
for i=1:2
    for x=1:4
        raw90_acc_vals(i,x) = get_accuracy(idx_vals(x), rawImgMat, k_vals(i),class_vals(x));
        %disp(raw90_acc_vals(x));
    end
end
%---------------------------RAW 45x35 IMAGE FEATURES--------------------%
raw45_acc_vals = [0,0,0,0;0,0,0,0];
raw45Mat = resize_image(three_dim_data,45,35);
for i=1:2
    for x=1:4
        raw45_acc_vals(i,x) = get_accuracy(idx_vals(x), raw45Mat', k_vals(i),class_vals(x));
        %disp(raw45_acc_vals(x));
    end
end
%---------------------------RAW 22x17 IMAGE FEATURES--------------------%
raw22_acc_vals = [0,0,0,0;0,0,0,0];
raw22Mat = resize_image(three_dim_data,22,17);
for i=1:2
    for x=1:4
        raw22_acc_vals(i,x) = get_accuracy(idx_vals(x), raw22Mat', k_vals(i),class_vals(x));
        %disp(raw22_acc_vals(x));
    end
end
%---------------------------RAW 9x7 IMAGE FEATURES--------------------%
raw9_acc_vals = [0,0,0,0;0,0,0,0];
raw9Mat = resize_image(three_dim_data,9,7);
for i=1:2
    for x=1:4
        raw9_acc_vals(i,x) = get_accuracy(idx_vals(x), raw9Mat', k_vals(i),class_vals(x));
        %disp(raw9_acc_vals(x));
    end
end
%---------------------------PCA IMAGE FEATURES--------------------------%
pca_acc_vals = [0,0,0,0;0,0,0,0];
for i=1:2
    for x=1:4
        pca_acc_vals(i,x) = get_accuracy(idx_vals(x), pca_features, k_vals(i),class_vals(x));
        %disp(pca_acc_vals(x));
    end
end
%--------------------------RAND IMAGE FEATURES--------------------------%
rand_acc_vals = [0,0,0,0;0,0,0,0];
for i=1:2
    for x=1:4
        rand_acc_vals(i,x) = get_accuracy(idx_vals(x), rand_projection, k_vals(i),class_vals(x));
        %disp(rand_acc_vals(x));
    end
end
%-----------------------------------------------------------------------%
% K==1
overall90_1 = mean(double(raw90_acc_vals(1,:)));
overall45_1 = mean(double(raw45_acc_vals(1,:)));
overall22_1 = mean(double(raw22_acc_vals(1,:)));
overall09_1 = mean(double(raw9_acc_vals(1,:)));
overallpca_1 = mean(double(pca_acc_vals(1,:)));
overallrand_1 = mean(double(rand_acc_vals(1,:)));
% K==2
overall90_2 = mean(double(raw90_acc_vals(2,:)));
overall45_2 = mean(double(raw45_acc_vals(2,:)));
overall22_2 = mean(double(raw22_acc_vals(2,:)));
overall09_2 = mean(double(raw9_acc_vals(2,:)));
overallpca_2 = mean(double(pca_acc_vals(2,:)));
overallrand_2 = mean(double(rand_acc_vals(2,:)));

disp('Feat = Raw, Input Dims = [90,70],  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([raw90_acc_vals,[overall90_1;overall90_2] ]);
disp('Feat = Raw, Input Dims = [45,35],  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([raw45_acc_vals,[overall45_1;overall45_2] ]);
disp('Feat = Raw, Input Dims = [22,17],  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([raw22_acc_vals,[overall22_1;overall22_2] ]);
disp('Feat = Raw, Input Dims = [ 9, 7],  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([raw9_acc_vals,[overall09_1;overall09_2] ]);
disp('Feat = PCA, Input Dims =  6300  ,  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([pca_acc_vals,[overallpca_1;overallpca_2] ]);
disp('Feat = Rand, Input Dims = 6300  ,  (row 1: kNN = 1) (row 2: kNN = 5)');
disp('A:         B:        C:        D:         Overall:');
disp([rand_acc_vals,[overallrand_1;overallrand_2] ]);


%disp(toc);

end