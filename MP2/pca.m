function [features, N] = pca(rawImgMat)

    meanImg = mean(rawImgMat,2);
    pcaImgMat = bsxfun(@minus,rawImgMat,meanImg);
   
    % COMPUTE SCATTER MATRIX
    scatMat = (1/(79))*(pcaImgMat'*pcaImgMat);
    [V,D] = eig(scatMat);
    
    eigvals = diag(D);
    [sorted_eigenvalues,sorted_index] = sort(eigvals,'descend');
    csum = cumsum(sorted_eigenvalues);
    energy = max(csum);
    %disp(energy);
    N = find(csum >= energy*0.95,1);
    
    V1 = zeros(80,N);
     for i=1:N
        V1(:,i) = V(:,sorted_index(i,1));
     end
    
    discLength = 80 - N;
    discarded = zeros(80,discLength);
    x=1;
    for i=N+1:80
        discarded(:,x) = D(:,sorted_index(i,1));
        x=x+1;
    end

    U = (V1'*pcaImgMat'*pcaImgMat)*inv(D.^(1/2));
    %H = pcaImgMat*V1;
    %Y = H'*pcaImgMat;

    features = U;
    
end
