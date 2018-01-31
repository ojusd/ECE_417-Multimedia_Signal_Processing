function[train_data_aud, train_data_vis, train_data_av] = avdataload(digit, datadir)

    train_data_aud = cell(1,10);
    train_data_vis = cell(1,10);
    train_data_av = cell(1,10);


    for i = 1:10
            train_data_aud{i} = importdata(strcat(datadir, filesep, int2str(digit), '.', int2str(i), '.', 'a', '.fea'));
            train_data_vis{i} = importdata(strcat(datadir, filesep, int2str(digit), '.', int2str(i), '.', 'v', '.fea'));
            train_data_av{i} = [train_data_aud{i} train_data_vis{i}];
    end
    
    
end