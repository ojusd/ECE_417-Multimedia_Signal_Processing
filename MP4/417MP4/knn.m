function [classification, count65, count66, count67, count68] = knn(current_feature, feature_matrix ,  k )
        count65=0;
        count66=0;
        count67=0;
        count68=0;
    % get the size of data
    [feature_height, feature_length] = size(feature_matrix);
    % find the distance from object data to the each samples_data
    knn_distances = zeros(feature_length,1);
    for i = 1:feature_length
        knn_distances(i) = sqrt(sum((feature_matrix(:,i)-current_feature).^2)) ;
    end
    % sort the distance matrix in ascending order
    [knn_distances_sorted idx] = sort(knn_distances,'ascend');
    if (k == 10)
        done = false;
        while(~done)
            c65=0;
            c66=0;
            c67=0;
            c68=0;
            class = zeros(k);
            for i =1:k
                 neighbor_idx(i) = idx(i);
                 if    (neighbor_idx(i) <=10)
                     class(i) = 65;
                     c65 = c65+1;
                 elseif(neighbor_idx(i) <=20)
                     class(i) = 66;
                     c66 = c66+1;
                 elseif(neighbor_idx(i) <=30)
                     class(i) = 67;
                     c67 = c67+1;
                 elseif(neighbor_idx(i) <=40)
                     class(i) = 68;
                     c68 = c68+1;
                 end
                 %Check if there is winner
                 if    (c65>c66 && c65>c67 && c65>c68)
                     count65 = c65;
                     classification = 65;
                     done = true;
                 elseif(c66>c65 && c66>c67 && c66>c68)
                     count66 = c66;
                     classification = 66;
                     done = true;
                 elseif(c67>c65 && c67>c66 && c67>c68)
                     count67 = c67;
                     classification = 67;
                     done = true;
                 elseif(c68>c65 && c68>c66 && c68>c67)
                     count68 = c68;
                     classification = 68;
                     done = true;
                 else 
                     k = k+1;
                 end
            end   
        end          
    end
end
