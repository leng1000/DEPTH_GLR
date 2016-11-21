function [depth] = DEPTH_ESTIMATION(dataterm,minmax)


if(minmax == 1)
    [garbage depth] = max(dataterm,[],3)  ;
else
    [garbage depth] = min(dataterm,[],3)  ;
end



end

