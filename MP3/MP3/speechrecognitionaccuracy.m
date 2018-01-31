function [acc] = speechrecognitionaccuracy(digits, feature_matrix, k, instance, start)

count = 0;
%g = 1;
for i = start: start  + 24
    %disp(g);
    %g = g +1;
    A = feature_matrix;
    feat = feature_matrix(:, i);
    
    if start <=25 
        
        for x = 1:25
            A(:, x) = [];
        end
    elseif start <=50 &&start > 25
        for x = 26:50
            A(:, x) = [];
        end
    elseif start <=75 && start > 50
        for x = 51:75
            A(:, x) = [];
        end
    else
        for x = 76:100
            
            A(:, 176-x) = [];
        end
        
    end
    
    B = knnspeech(feat, A, k);
           
    if(B == digits)
        count = count + 1;
    end
end
    percent = (count./20) * 100;
    acc = percent;
    
end

