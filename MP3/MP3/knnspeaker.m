function [recognizer] = knnspeaker(feature, mat ,  k, cdm )

     [height, length] = size(mat);
    
    %Find the distance from the feature we're recognizing to all of the data samples.
    knn_dist_mat = zeros(length,1);
    for i = 1:length
        knn_dist_mat(i) = sqrt(sum((mat(:,i) - feature).^2));
    end
    
    [knn_dist_mat index] = sort(knn_dist_mat,'ascend');
    
    % KNN = 1
    if (k == 1)
         recognizer = cdm(1, index(1));
    end
    if (k==5)
        trial = 0;
        while(trial == 0)
            s1=0;
            s2=s1;
            s3=s2;
            s4=s3;
            vec = [s1, s2, s3, s4];
            for x = 1 : k
                rec = cdm(1, index(x));
                if(rec == char(65))
                    s1 = s1+1;
                end
                if(rec==char(66))
                    s2 = s2+1;
                end
                if(rec==char(67))
                    s3= s3+1;
                end
                if(rec==char(68))
                    s4 = s4+1;
                end
            end
            if(max(vec) == s1)
                recognizer = char(65);
                trial = 1;
            end
            if(max(vec) == s2)
                recognizer = char(66);
                trial = 1;
            end
            if(max(vec) == s3)
                recognizer = char(67);
                trial = 1;
            end
            if(max(vec) == s4)
                recognizer = char(68);
                trial = 1;
            end
        end
    end
end

