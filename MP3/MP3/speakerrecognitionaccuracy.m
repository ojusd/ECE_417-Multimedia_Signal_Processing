function [acc] = speakerrecognitionaccuracy(start, feature_matrix, k, person, instance)

%%%%%%%%%%%%%%%%%%SPEECH RECOGNITION%%%%%%%%%%%%%%%%%%%%%%
count = 0;
for i = start: start  + 19
    A = feature_matrix;
    feat = feature_matrix(:, i);
    if start <=20 
        for x = 1:20
            A(:, x) = [];
        end
        
    end
    if start <=40 &&start > 20
        for x = 21:40
            A(:, x) = [];
        end
        
    end
    if start <=60 && start > 40
        for x = 41:60
            A(:, x) = [];
        end
        
    end
    if start <=80 && start > 60
        for x = 61:80
            A(:, x) = [];
        end
        
    end
    if start > 80
        for x = 81:100
            A(:, x) = [];
        end
        
    end
    
      B = knn(feat, A, k);
           
    if(B == ppl)
        count = count + 1;
    end
    
    percent = (count./20) * 100;
    
    acc = percent;
    
end
end
    
    
    
    
    
    
    
    
    