function [accuracy, count] = get_accuracy( featureMat, testMat, k, class)
    X=0;
    %PP = zeros(1, 4);
    %for i =startidx:startidx+9
        fMat = featureMat;
        feature = testMat;
        %fMat(:,i)=[];
        [C, Acount, Bcount, Ccount, Dcount] = knn(feature,fMat,k);
        if(C==class)
            X = X+1;
        end
        
        count = zeros(1,4);
        count(1) = Acount;
        count(2) = Bcount;
        count(3) = Ccount;
        count(4) = Dcount;
        count = count/10;
        
        %end
    
    %num = num/10;
    %prob = num;
    X = X/20;
    X = 100*X;
    accuracy = X;
end