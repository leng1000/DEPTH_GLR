function combined_term = Combine_Term(defocus_term, corresp_term, defocus_confidence, corresp_confidence)

radius = 1;

combined_term = zeros(size(defocus_term));

for y = 1:size(defocus_term,1)
  
    for x = 1:size(defocus_term,2)
        weight_sum = 0;
        for j = -radius:radius
            for i = -radius:radius
                y_cord = y+j;
                x_cord = x+i;
                if (y_cord < 1)
                    y_cord = 1;
                elseif (y_cord > size(defocus_term,1))
                    y_cord = size(defocus_term,1);
                end
                if (x_cord < 1)
                    x_cord = 1;
                elseif (x_cord > size(defocus_term,2))
                    x_cord = size(defocus_term,2);
                end
                defocus_term_squeeze = squeeze(defocus_term(y_cord,x_cord,:));
                corresp_term_squeeze = squeeze(corresp_term(y_cord,x_cord,:));
                combined_term(y,x,:) = squeeze(combined_term(y,x,:)) + ...
                    (defocus_confidence(y_cord, x_cord) * defocus_term_squeeze) + ...
                    (corresp_confidence(y_cord, x_cord) * corresp_term_squeeze);
                weight_sum = weight_sum + defocus_confidence(y_cord, x_cord) + corresp_confidence(y_cord, x_cord);
            end
        end
        combined_term(y,x,:) = combined_term(y,x,:)/weight_sum;
    end
end

end