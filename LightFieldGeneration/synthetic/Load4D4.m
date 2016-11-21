
function [ im_4D ] = Load4D4 ( folder, width ,height, view_u, view_v,factor)

w = ceil(width*factor);
h = ceil(height*factor);


im_4D = zeros( h, w,view_u, view_v,3 );

list = dir(folder);

num=1;

dims = size(im_4D);

for v = 1:view_v
    for u = 1:view_u
        na= list(num+2).name;
        name = [folder '\' na(1:end)];
        fprintf('%s\n', name);
        im=imread(name);
        im=im2double(im);
        % im=rgb2gray(im);
        im=imresize(im, factor, 'bilinear');
        
        im_4D(:,:,v,u,:)=im;
          
        num=num+1;
    end
end

end