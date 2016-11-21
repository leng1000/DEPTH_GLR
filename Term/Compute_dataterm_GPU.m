function [ defocus_term  correspondence_term Im_center ] = Compute_dataterm_GPU( LF,depth_interval )

u_size                              = size(LF,3)                                                         ;
v_size                              = size(LF,4)                                                         ;
Im_center                           = squeeze(LF(:,:,ceil(u_size/2),ceil(v_size/2),:))                   ;
Im_center_copy                      = gather(Im_center);
gpu=gpuDevice(1);
lnum=0;
for k=1:3
  
  LF_p=gpuArray(LF(:,:,:,:,k)); 
  lnum=0;
  for i=1:size(depth_interval,2)
    
    
    
   tic;
   
    [I_out1 LF_refocus1]             = refocusLightField(LF_p,depth_interval(i))                            ;
   
    I_out(:,:,k,i)                   = gather(I_out1); 
   
   % LF_refocus(:,:,:,:,k)            = gather(LF_refocus1);
    
    i
    
%    defocus_term(:,:,i)         = Defocus_term_generation(I_out,Im_center,3 )                            ; %original floor(u_size/2)
    correspondence_term1(:,:,i,k)  = gather(Correspondence_term_generation_GPU( LF_refocus1,Im_center(:,:,k) )  )       ;
    
    
    lnum=lnum+1;
 %   if (lnum==30)
 %       reset(gpu);
  %      lnum=0;
  %      LF_p=gpuArray(LF(:,:,:,:,k)); 
  %      Im_center=gpuArray(Im_center_copy);
  %  end
    
    toc;
end

  
end

for i=1:size(depth_interval,2)
    defocus_term(:,:,i)         = Defocus_term_generation(squeeze(I_out(:,:,:,i)),Im_center_copy,3 );
    
end
correspondence_term = mean(correspondence_term1,4);
end

