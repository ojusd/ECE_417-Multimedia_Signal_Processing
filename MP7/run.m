function run(datadir)
    disp("thisfar")
% datadir = '.';
%STEP 1: LOAD PRE-PROCESSED DATA
     %Load data
     data = load(strcat(datadir, filesep, 'ECE417_MP5_AV_Data.mat'));
    % Load mouth animation base image
     mouth_image = imread(strcat(datadir, filesep, 'mouth.jpg'));
    
%STEP 2: TRAIN NEURAL NET
    %Train Neural Net and then map to test data
    % mouth_dimensions =  ECE417_MP5_test ( test_audio, silence_model, ECE417_MP5_train ( train_data, validate_data, silence_model, num_neurons, mapping_file ) );
    load('ANNresults.mat');
    %mouth_dimensions = results; 
    %Read mesh.txt file for mouth animation
    fileID = fopen('mesh.txt','r');
    rm = fscanf(fileID,'%d');%%readmesh
    
%STEP 3: FIND VISUAL FEATURES
    %First half of mesh
    rm = rm(2:end);
    for i = 1:33% actually 35
        rmv(i,1:2) = rm((i-1)*2+1 : i*2);%%vertices
    end
    disp('halfmesh')
    %Second half of mesh
    rm = rm(68:end);
    for i = 1:42
        rmt(i,1:3) = rm((i-1)*3+1:i*3);%%triangles
    end
    disp('fullmesh')
    
%STEP 4: WARP IMAGE
    %% Warp image
    warpfr = uint8(imagewarp(rmv,rmt, ECE417_MP5_test (data.testAudio,data.silenceModel,ECE417_MP5_train (data.av_train,data.av_validate,data.silenceModel,3,'mp7_trained_model')), mouth_image));
    disp('done warping')
    %%warped frames
%STEP 5: CREATE VIDEO
    movie = VideoWriter('mp7.avi');
    movie.FrameRate = 30; 
    %audio is 15.245 seconds long, so we need that x 30 fps to get total frames
    length = 15.2 * 30;
    open(movie)
    for i = 1:length
       writeVideo(movie,squeeze(warpfr(:,:,i)));
    end
    close(movie);
end





