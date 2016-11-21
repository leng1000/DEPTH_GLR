function defocus_term = Defocus_term_generation( IM_Refoc_alpha,IM_Pinhole,defocus_radius )

                    


diff_map         = abs(IM_Refoc_alpha - IM_Pinhole);

h                = fspecial('average',[defocus_radius defocus_radius])   ;
diff_avg_map     = imfilter(diff_map,h,'symmetric')                      ;

diff_avg_map     = ((diff_avg_map(:,:,1).^2 ...
                    +diff_avg_map(:,:,2).^2 ...
                    +diff_avg_map(:,:,3).^2)/3).^(1/2)                   ;
                                
defocus_term = diff_avg_map                                          ;                  


end

