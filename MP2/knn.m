function [classification] = knn(current_feature, feature_matrix ,  k )
        
    % get the size of data
    [feature_height, feature_length] = size(feature_matrix);

    % find the distance from object data to the each samples_data
    knn_distances = zeros(feature_length,1);
    for i = 1:feature_length
        knn_distances(i) = sqrt(sum((feature_matrix(:,i)-current_feature).^2)) ;
    end
    % sort the distance matrix in ascending order
    [knn_distances_sorted idx] = sort(knn_distances,'ascend');
    % KNN = 1
    if (k == 1)
         neighbor_idx = idx(1);
         if    (neighbor_idx <=20)
             classification = 65;
         elseif(neighbor_idx <=40)
             classification = 66;
         elseif(neighbor_idx <=60)
             classification = 67;
         elseif(neighbor_idx <=80)
             classification = 68;
         end
    end
    if (k ~= 1)
        done = false;
        while(~done)
            c65=0;
            c66=0;
            c67=0;
            c68=0;
            class = zeros(k);
            for i =1:k
                 neighbor_idx(i) = idx(i);
                 if    (neighbor_idx(i) <=20)
                     class(i) = 65;
                     c65 = c65+1;
                 elseif(neighbor_idx(i) <=40)
                     class(i) = 66;
                     c66 = c66+1;
                 elseif(neighbor_idx(i) <=60)
                     class(i) = 67;
                     c67 = c67+1;
                 elseif(neighbor_idx(i) <=80)
                     class(i) = 68;
                     c68 = c68+1;
                 end
                 %Check if there is winner
                 if    (c65>c66 && c65>c67 && c65>c68)
                     classification = 65;
                     done = true;
                 elseif(c66>c65 && c66>c67 && c66>c68)
                     classification = 66;
                     done = true;
                 elseif(c67>c65 && c67>c66 && c67>c68)
                     classification = 67;
                     done = true;
                 elseif(c68>c65 && c68>c66 && c68>c67)
                     classification = 68;
                     done = true;
                 else 
                     k = k+1;
                 end
            end   
        end          
    end
end
