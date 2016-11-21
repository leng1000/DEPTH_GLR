function confidence = Confidence_Computation(term,IM_Pinhole,minmax)



[y_size x_size cc]=size(IM_Pinhole);

luminance = rgb2ycbcr(IM_Pinhole);
luminance = luminance(:,:,1);

std_alm = 0.2;

if(minmax == 1)
    %Defocus
    for x = 1:x_size
        for y = 1:y_size
            term_squeeze = squeeze(term(y,x,:));
            C_1 = max(term_squeeze);
            confidence(y,x) = (1/(sum(exp(-((term_squeeze-C_1).^2/(2*(std_alm^2))))))) * (max(term_squeeze)-min(term_squeeze));
        end
    end
    
else
    %Correspondence
    for x = 1:x_size
        for y = 1:y_size
            term_squeeze = squeeze(term(y,x,:));
            C_1 = min(term_squeeze);
            confidence(y,x) = (1/(sum(exp(-((term_squeeze-C_1).^2/(2*(std_alm^2))))))) * (max(term_squeeze)-min(term_squeeze));
        end
    end
end

end
