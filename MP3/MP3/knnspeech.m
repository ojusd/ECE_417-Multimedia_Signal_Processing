function [recognizer] = knnspeech(feature, mat ,  k, cdm )

     [height, length] = size(mat);
    
    %Find the distance from the feature we're recognizing to all of the data samples.
    knn_dist_mat = zeros(length,1);
    for i = 1:length
        knn_dist_mat(i) = sqrt(sum((mat(:,i) - feature).^2));
    end
    
    [knn_dist_mat index] = sort(knn_dist_mat,'ascend');
    
    % KNN = 1
    if (k == 1)
         recognizer = cdm(2, index(1));
    end
    if (k==5)
        trial = 0;
        while(trial == 0)
            d2=0;
            d1=d2;
            d3=d2;
            d4=d3;
            d5=d3;
            vec = [d1, d2, d3, d4, d5];
            for x = 1 : k
                rec = cdm(2, index(x));
                if(rec ==1)
                    d1 = d1+1;
                end
                if(rec==2)
                    d2 = d2+1;
                end
                if(rec==3)
                    d3= d3+1;
                end
                if(rec==4)
                    d4 = d4+1;
                end
                if(rec==5)
                    d5 = d5+1;
                end
            end
            if(max(vec) == d1)
                recognizer = 1;
                trial = 1;
            end
            if(max(vec) == d2)
                recognizer = 2;
                trial = 1;
            end
            if(max(vec) == d3)
                recognizer = 3;
                trial = 1;
            end
            if(max(vec) == d4)
                recognizer = 4;
                trial = 1;
            end
            if(max(vec) == d5)
                recognizer = 5;
                trial = 1;
            end
        end
    end
end


        
    
    