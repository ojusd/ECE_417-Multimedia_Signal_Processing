function [image] = resize_image(input,sizex,sizey)
    image = zeros(80,sizex*sizey);
    for i=1:80
        resized = imresize(input(:,:,i),[sizex,sizey]);
        image(i,:) = reshape(resized,[sizex*sizey,1]);
    end
end