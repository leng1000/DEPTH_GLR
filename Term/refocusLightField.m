
function [Iout lightFieldOut] = refocusLightField(lightField, pixels) 
    z=size(lightField,5);   
    Iout = zeros([size(lightField,1) size(lightField,2),z]); 
     
     [XX YY] = meshgrid(1:size(lightField,2), 1:size(lightField,1)); 
     
     for ky=1:size(lightField,3) 
     for kx=1:size(lightField,4) 
         t1= XX + pixels*(kx-(floor(size(lightField,4)/2)+1));
         t2= YY - pixels*(ky-(floor(size(lightField,3)/2)+1));
         t3=find(t1<1);
         t1(t3)=1;
         t3=find(t1>size(lightField,2));
         t1(t3)=size(lightField,2);
         t3=find(t2<1);
         t2(t3)=1;
         t3=find(t2>size(lightField,1));
         t2(t3)=size(lightField,1);
         
 
           II = reshape(lightField(:,:,ky,kx,:), [size(lightField,1) size(lightField,2) z] ); 
            for k=1:z 
                 I(:,:,k) = interp2(XX,YY,II(:,:,k),t1, t2, 'linear', 1); 
             end 
             Iout = Iout + (1/(size(lightField,4)*size(lightField,3))) .* I; 
             
            if nargout>1 
                 lightFieldOut(:,:,ky,kx,:) = reshape(I, [ size(lightField,1) size(lightField,2) 1 1 z]); 
             end 
         end 
     end 
      
 end 




