function [myconfi out] = refine_confidence( Ic,confi,wind_size,threshold,side)
%REFINE_CONFIDENCE 此处显示有关此函数的摘要
%   此处显示详细说明

[a, b ,c]=size(Ic);
k=floor(wind_size/2);
mysum=zeros(a-wind_size+1,b-wind_size+1,c);
for i=1:wind_size
    for j=1:wind_size
        mysum=mysum+Ic(i:end-wind_size+i,j:end-wind_size+j,:);
    end
end
avg=mysum/(wind_size*wind_size);
mysum=zeros(a-wind_size+1,b-wind_size+1,c);
for i=1:wind_size
    for j=1:wind_size
        mysum=mysum+abs(Ic(i:end-wind_size+i,j:end-wind_size+j,:)-avg);
    end
end

out=sum(mysum,3);
myconfi=confi;
myconfi(1:k,:)=0.0001;
myconfi(end-k+1:end,:)=0.0001;
myconfi(:,1:k)=0.0001;
myconfi(:,end-k+1:end)=0.0001;
confi1=confi(k+1:end-k,k+1:end-k);
T=find(out<threshold);
confi1(T)=0.000;
confi1=confi1.*out;
myconfi(k+1:end-k,k+1:end-k)=confi1;
myconfi(1:side,:)=0;
myconfi(a-side:a,:)=0;
myconfi(:,1:side)=0;
myconfi(:,b-side:b)=0;

end

