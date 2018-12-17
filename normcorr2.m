 function [x,y,z]=normcorr2(I1,I2) 
% I1,I2 are single layer image matrix
% I1 is template 
% I2 is the region where match pairs are searched 
[m1,n1]=size(I1); 
[m2,n2]=size(I2); 
z=conv2(I2,rot90(I1,2),'valid'); 
im2=cumsum(I2.^2,1); 
im2=cumsum(im2,2); 
sum1=sum(sum(I1.^2,1),2); 
% nz=zeros(m2-m1+1,n2-n1+1); 
wrapIm2=zeros(1+m2,1+n2); 
wrapIm2(2:end,2:end)=im2; 
nz=(wrapIm2(m1+1:m2+1,n1+1:n2+1)+wrapIm2(1:m2-m1+1,1:n2-n1+1)-wrapIm2(1:m2-m1+1,n1+1:n2+1)-wrapIm2(m1+1:m2+1,1:n2-n1+1))*sum1; 
nz=sqrt(nz); 
z=z./nz; 
[x,y]=meshgrid(1:n2-n1+1,1:m2-m1+1); 
end