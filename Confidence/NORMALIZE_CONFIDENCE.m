function [defocus_confi_n,corresp_confi_n] = NORMALIZE_CONFIDENCE(defocus_confi,corresp_confi)


combined        = [defocus_confi corresp_confi]                           ;
combined        = combined(isfinite(combined))                            ;
defocus_confi_n = defocus_confi/max(max(combined))                        ;
corresp_confi_n = corresp_confi/max(max(combined))                        ;

end

