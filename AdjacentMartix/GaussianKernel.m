function r = GaussianKernel( Cost,minCost,threshold,p1,p2,p3,x1,y1,winsize,Im_center )
%GAUSSIANKERNAL 此处显示有关此函数的摘要
%   此处显示详细说明
[a1 b1 labels]=size(Cost);
row_left=x1-winsize;
col_left=y1-winsize;
row_right=x1+winsize;
col_right=y1+winsize;
if (row_left <1)
    row_left=1;
end
if (col_left<1)
    col_left=1;
end
if (row_right>a1)
    row_right=a1;
end
if (col_right>b1)
    col_right=b1;
end
v1=squeeze(Cost(x1,y1,:));
Cost1=Cost(row_left:row_right,col_left:col_right,:);
%minCost1=minCost(row_left:row_right,col_left:col_right,:);
Im=Im_center(row_left:row_right,col_left:col_right,:);

for i=1:labels
    v2(:,:,i)=ones(row_right-row_left+1,col_right-col_left+1)*v1(i);
    Cost1(:,:,i)=Cost1(:,:,i);
end

c_r=ones(row_right-row_left+1,col_right-col_left+1)*Im_center(x1,y1,1);
c_g=ones(row_right-row_left+1,col_right-col_left+1)*Im_center(x1,y1,2);
c_b=ones(row_right-row_left+1,col_right-col_left+1)*Im_center(x1,y1,3);


d=sum((Cost1-v2).^2,3);
b=col_right-col_left+1;
a=row_right-row_left+1;
[x y]=meshgrid(1:b,1:a);
x2=ones(a,b)*(x1-row_left+1);
y2=ones(a,b)*(y1-col_left+1);
d1=(x-y2).^2+(y-x2).^2;

d2=abs(Im(:,:,1)-c_r)+abs(Im(:,:,2)-c_g)+abs(Im(:,:,3)-c_b);

result=zeros(a,b);


r=exp(-1*d*0.5/(p1*p1)).*exp(-1*d1*0.5/(p2*p2)).*exp(-1*d2*0.5/(p3*p3));
j=find(r>threshold);
result(j)=r(j);
res=zeros(a1,b1);
res(row_left:row_right,col_left:col_right)=result;

r=res(:);


end

