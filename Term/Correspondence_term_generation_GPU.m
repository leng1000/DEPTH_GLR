function correspondence_term = Correspondence_term_generation_GPU( LF_refocus,Im_center )


u_size                          = size(LF_refocus,3)                                    ;
v_size                          = size(LF_refocus,4)                                    ;


pinhole_angular   = repmat(squeeze(Im_center(:,:)),[1 1 u_size v_size] );

angular_diff                    = abs(LF_refocus - pinhole_angular)                     ;
angular_diff_u                  = mean(angular_diff,4)                                  ;
angular_diff_map                = mean(angular_diff_u,3)                                ;
clear angular_diff ;
clear angular_diff_u ;

correspondence_term         = angular_diff_map                                      ;
clear angular_diff_map ;
end

