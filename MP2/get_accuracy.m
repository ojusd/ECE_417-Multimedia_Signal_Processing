function [accuracy] = get_accuracy(startidx, featureMat, k, class)
    X=0;
    
    for i =startidx:startidx+19
        fMat = featureMat;
        %[o,j] = size(fMat);
        %disp(o);
        %disp(j);
        feature = featureMat(:,i);
        fMat(:,i)=[];
        %[o,j] = size(feature);
        %disp('O:');
        %disp(o);
        %disp('J:');
        %disp(j);
        C = knn(feature,fMat,k);
        if(C==class)
            X = X+1;
        end
        
    end
    X = X/20;
    X = 100*X;
    accuracy = X;
end