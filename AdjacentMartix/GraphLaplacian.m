function result1 = GraphLaplacian( Adjacent )


r=Adjacent(:);
r1=r';
result=cell2mat(r1);


d=diag(result);
d1=diag(d');
temp=result-d1; 
temp1=sum(temp');
temp2=diag(temp1);
result1=temp2-temp;



end

