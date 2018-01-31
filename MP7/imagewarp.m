function out = imagewarp(vert,tri_pts,lip_pts,input)

length = size(lip_pts,2);
[h, w] = size(input);
out = zeros(h, w, length);
xdim = vert(:,1);
ydim = vert(:,2);

for fr = 1:length % iterate through each of the image's frames
   [xwarp, ywarp] = interpVert(xdim, ydim, 0, 0, 0, lip_pts(1,fr), lip_pts(2,fr), lip_pts(3,fr), 1)
    for tri = 1:42 
        vert1init = [xdim(tri_pts(tri,1)) ydim(tri_pts(tri,1))];
        vert2init = [xdim(tri_pts(tri,2)) ydim(tri_pts(tri,2))];
        vert3init = [xdim(tri_pts(tri,3)) ydim(tri_pts(tri,3))];
        vert1warp = [xwarp(tri_pts(tri,1)) ywarp(tri_pts(tri,1))];
        vert2warp = [xwarp(tri_pts(tri,2)) ywarp(tri_pts(tri,2))];
        vert3warp = [xwarp(tri_pts(tri,3)) ywarp(tri_pts(tri,3))];
        imgwarp = [vert1warp, 1; vert2warp, 1; vert3warp, 1]';
        for i = 1:h
            for hor = 1:w
                l = inv(imgwarp) * [hor i 1]';
                if max(l) <= 1 && min(l) >= 0
                    imginit = [vert1init, 1; vert2init, 1; vert3init, 1]' * l;
                    out(i, hor, fr) = (imginit(2) - floor(imginit(2))) * ((imginit(1) - floor(imginit(1))) * input(ceil(imginit(2)),ceil(imginit(1))) + (1 - (imginit(1) - floor(imginit(1)))) * input(ceil(imginit(2)),floor(imginit(1)))) + (1 - (imginit(2) - floor(imginit(2)))) * ((imginit(1) - floor(imginit(1))) * input(floor(imginit(2)),ceil(imginit(1))) + (1 - (imginit(1) - floor(imginit(1)))) * input(floor(imginit(2)),floor(imginit(1))));                   
                end 
            end 
        end
    end 
end 













