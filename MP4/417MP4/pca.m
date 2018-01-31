function [features, N] = pca(rawImgMat)

    meanImg = mean(rawImgMat,2);
    pcaImgMat = bsxfun(@minus,rawImgMat,meanImg); % REPLACEE [] WITH MATRIX
    
    % COMPUTE SCATTER MATRIX
    scatMat = (1/(79))*(pcaImgMat*pcaImgMat');
    [V,D] = eig(scatMat);
    eigvals = diag(D);
    [sorted_eigenvalues,sorted_index] = sort(eigvals,'descend');
    csum = cumsum(sorted_eigenvalues);
    energy = max(csum);
    N = find(csum >= energy*0.95,1);
    %V1 = zeros(80,N);
    
     %for i=1:N
        V1 = V(:,sorted_index(1:N));
     %end

    
    
    U = (V1'*inv(D.^(1/2)))*pcaImgMat;
    features = U;
   
end