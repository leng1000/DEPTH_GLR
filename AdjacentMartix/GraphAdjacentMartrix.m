function result = GraphAdjacentMartrix( Cost,threshold,p1,p2,p3,Im_center)

[x y z]=size(Cost);
l=x*y;

for i=1:x
   for j=1:y
      k=squeeze(Cost(i,j,:));
      minCost(i,j)=min(k);
end
end

result1=sparse(1,l);
parfor i=1:x
    for j=1:y
       tic
         result1=GaussianKernel( Cost,minCost,threshold,p1,p2,p3,i,j,2,Im_center);
         result{i,j}=sparse(result1);
       toc
    end
    i
end





end

