function [ defocus_term  correspondence_term Im_center ] = Compute_dataterm( LF,depth_interval )

u_size                              = size(LF,3)                                                         ;
v_size                              = size(LF,4)                                                         ;
Im_center                           = squeeze(LF(:,:,ceil(u_size/2),ceil(v_size/2),:))                   ;
for i=1:size(depth_interval,2)
    [I_out LF_refocus]              = refocusLightField(LF,depth_interval(i))                            ;
    i
    defocus_term(:,:,i)         = Defocus_term_generation(I_out,Im_center,3 )                    ; %original floor(u_size/2)
    correspondence_term(:,:,i)  = Correspondence_term_generation( LF_refocus,Im_center )         ;
end

  
end

