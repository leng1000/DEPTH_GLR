function correspondence_term = Correspondence_term_generation( LF_refocus,Im_center )


u_size                          = size(LF_refocus,3)                                    ;
v_size                          = size(LF_refocus,4)                                    ;
x_size                          = size(LF_refocus,1)                                    ;
for i=1:3
  pinhole_angular(:,:,:,:,i)    = repmat(squeeze(Im_center(:,:,i)),[1 1 u_size v_size] );
end
angular_diff                    = mean(abs(LF_refocus - pinhole_angular),5)             ;
angular_diff_u                  = mean(angular_diff,4)                                  ;
angular_diff_map                = mean(angular_diff_u,3)                                ;
correspondence_term         = angular_diff_map                                      ;

end

