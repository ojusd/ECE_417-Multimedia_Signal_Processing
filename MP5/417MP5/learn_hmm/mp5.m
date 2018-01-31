function mp5(datadir)
tic;
datadir = 'AV_DATA';

%Read Data
    % Our data will be in 2 cell arrays.  
    % {1} will be digit 2, {2} will be digit 5.
    % avdata is just a concatenation of audiodata and visualdata.
    
    audiodata = cell(1,2);
    visualdata = cell(1,2);
    avdata = cell(1,2);
     N = 5;%N is the # of states
     
    %Reads the 2
    [audiodata{1}, visualdata{1}, avdata{1}]= avdataload(2,datadir);
    
    %Reads the 5
     [audiodata{2}, visualdata{2}, avdata{2}]= avdataload(5,datadir);
    
    %A_init forces desired flow through states
    A_init = [0.8,0.2,0,0,0;0,0.8,0.2,0,0;0,0,0.8,0.2,0;0,0,0,0.8,0.2;0,0,0,0,1]';
    A_init = A_init';
    audioaccuracy = [0,0];
    visualaccuracy = [0,0];
    avaccuracy = [0,0];
    split1 = cvpartition(10, 'LeaveOut');

    index=[1,2,3,4,5,6,7,8,9,10];
    digits = [2,5];

    for z = 1:2
        curr = z;
        if(curr ==1)
            next = 2;
        else
            next = 1;
        end

    currdata = audiodata{curr};
    
    
    nextdata = audiodata{next};
    
    %disp(nextdata)
    
    [Po_nextdata, A_nextdata, mu_nextdata, sigma_nextdata] = ghmm_learn(nextdata, N, A_init);
    for i = 1:10
         datatrain = cell(1,9);
        indextrain = index(training(split1, i));
        indextest = index(test(split1, i));

        datatest = currdata{indextest};
        for n = 1:9
            datatrain{n} = currdata{indextrain(n)};
        end

        [Po_currdata, A_currdata, mu_currdata, sigma_currdata] = ghmm_learn(datatrain, N, A_init);

        [alpha_currdata, scale_currdata] = ghmm_fwd(datatest, A_currdata, Po_currdata, mu_currdata, sigma_currdata);
        [alpha_nextdata, scale_nextdata] = ghmm_fwd(datatest, A_nextdata, Po_nextdata, mu_nextdata, sigma_nextdata);

        if(sum(scale_currdata) > sum(scale_nextdata))
            audioaccuracy(curr) = audioaccuracy(curr) + 1;
        end
    end
    end
    audioaccuracy = audioaccuracy*10;
   
    
    split2 = cvpartition(10, 'LeaveOut');

    for z = 1:2
        curr = z;
        if(curr ==1)
            next = 2;
        else
            next = 1;
        end

    currdata = visualdata{curr};
    
    
    nextdata = visualdata{next};
    
    %disp(nextdata)
    
    [Po_nextdata, A_nextdata, mu_nextdata, sigma_nextdata] = ghmm_learn(nextdata, N, A_init);
    for i = 1:10
        datatrain = cell(1,9);
        indextrain = index(training(split2, i));
        indextest = index(test(split2, i));

        
        datatest = currdata{indextest};
        for n = 1:9
            datatrain{n} = currdata{indextrain(n)};
        end

        [Po_currdata, A_currdata, mu_currdata, sigma_currdata] = ghmm_learn(datatrain, N, A_init);

        [alpha_currdata, scale_currdata] = ghmm_fwd(datatest, A_currdata, Po_currdata, mu_currdata, sigma_currdata);
        [alpha_nextdata, scale_nextdata] = ghmm_fwd(datatest, A_nextdata, Po_nextdata, mu_nextdata, sigma_nextdata);

        if(sum(scale_currdata) > sum(scale_nextdata))
            visualaccuracy(curr) = visualaccuracy(curr) + 1;
        end
    end
    end
    visualaccuracy = visualaccuracy*10;
    
    
    split3 = cvpartition(10, 'LeaveOut');

    for z = 1:2
        curr = z;
        if(curr ==1)
            next = 2;
        else
            next = 1;
        end

    currdata = avdata{curr};
    
    
    nextdata = avdata{next};
    
    %disp(nextdata)
    
    [Po_nextdata, A_nextdata, mu_nextdata, sigma_nextdata] = ghmm_learn(nextdata, N, A_init);
    for i = 1:10
        datatrain = cell(1,9);
        indextrain = index(training(split3, i));
        indextest = index(test(split3, i));
        datatest = currdata{indextest};
        for n = 1:9
            datatrain{n} = currdata{indextrain(n)};
        end

        [Po_currdata, A_currdata, mu_currdata, sigma_currdata] = ghmm_learn(datatrain, N, A_init);

        [alpha_currdata, scale_currdata] = ghmm_fwd(datatest, A_currdata, Po_currdata, mu_currdata, sigma_currdata);
        [alpha_nextdata, scale_nextdata] = ghmm_fwd(datatest, A_nextdata, Po_nextdata, mu_nextdata, sigma_nextdata);

        if(sum(scale_currdata) > sum(scale_nextdata))
            avaccuracy(curr) = avaccuracy(curr) + 1;
        end
    end
    end
    avaccuracy = avaccuracy*10;
    
    audioavg = mean(audioaccuracy,2);
    audioaccuracy = horzcat(audioaccuracy, audioavg);
    visualavg = mean(visualaccuracy,2);
    visualaccuracy = horzcat(visualaccuracy, visualavg);
    avavg = mean(avaccuracy,2);
    avaccuracy = horzcat(avaccuracy, avavg);
    fprintf('\n-------Audio Accuracy-----\n');
    formatSpec = '2: %2.2f \n 5: %2.2f \n Overall Average: %2.2f \n';
    fprintf(formatSpec, audioaccuracy);
    fprintf('\n-------Visual Accuracy-----\n');
    fprintf(formatSpec, visualaccuracy);
    fprintf('\n------AudioVisual Recognition-----\n');
    fprintf(formatSpec, avaccuracy);
    %fprintf(avaccuracy);
    
    
toc;
end   