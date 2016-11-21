Add_Path();
%input the data: Stanford Archive
%factor=0.25;
%LF=Load4D4('Data\Track', 1280, 960, 17, 17, factor);
%depth_interval=[1.6:0.05:1.2];
%Im_center=squeeze(LF(:,:,9,9,:));
%input the data: HCI Archive
data=h5read('stillLife_.h5','/LF');
LF(:,:,:,:,1)=squeeze(data(1,:,:,:,:));
LF(:,:,:,:,2)=squeeze(data(2,:,:,:,:));
LF(:,:,:,:,3)=squeeze(data(3,:,:,:,:));
LF=double(LF);
depth_interval=[-1.5:0.05:0.85];
Im_center=squeeze(LF(:,:,5,5,:));
%Using GPU for defocus and correspondence term computation
[ defocus_term  correspondence_term ] = Compute_dataterm_GPU( LF,depth_interval );
%With GPU for defocus and correspondence term computation
[ defocus_term  correspondence_term ] = Compute_dataterm( LF,depth_interval );

%get the data term
defocus_confi = Confidence_Computation(defocus_term,Im_center,0);
corresp_confi = Confidence_Computation(correspondence_term,Im_center,0);
[defocus_confi,corresp_confi] = NORMALIZE_CONFIDENCE(defocus_confi,corresp_confi);
data_term = Combine_Term(defocus_term, correspondence_term, defocus_confi, corresp_confi);
%get the initial depth map
combined_depth = DEPTH_ESTIMATION(combined_response,0);
%get the confidence term
combined_confi = Confidence_Computation(combined_response,Im_center,0);
combined_confi = (combined_confi - min(combined_confi(:)))/(max(combined_confi(:)) - min(combined_confi(:)));
[ combined_confi1  out]= refine_confidence( Im_center,combined_confi,5,0.3,0);
combined_confi2=(combined_confi1 - min(combined_confi1(:)))/(max(combined_confi1(:)) - min(combined_confi1(:)));
%adjacent matrix computation
result=GraphAdjacentMartrix( combined_response,0.4,10,1,1,Im_center);
L= GraphLaplacian( result);
k=combined_confi2(:);
f=-2*combined_depth(:).*k;
k=sparse(k');
T=diag(k);
% determine the parameter for L
 H=T+0.005*L;
% unconstrained quadratic programming (QP) 
r=quadprog(H*2,f);
% get the final result
[a b c d e]=size(LF);
E1=reshape(r,a,b);
E1=E1-min(min(E1));
E1=E1./max(max(E1));
imshow(E1);






