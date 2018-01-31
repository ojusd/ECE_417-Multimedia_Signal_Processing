function [out] = av_helper(visual_prob, cep_prob, weight) 
    out = zeros(1,4);
    for p = 0:3 
        for x = 1:10 
            for y = 1:10 
                av_vals =  visual_prob((p)*10 + y, :) .^ (1-weight) .* cep_prob( (p)*10 + x, :) .^ weight;
               [~, greatest] = sort(av_vals, 'descend');
                if(p+1 == greatest(1))
                out(p+1) = out(p+1) + 1;
                end
            end
        end
    end
    
%    out = out/100;
    
end