clear all
close all
clc

image=double(imread("lighthouse.png"));
Rchannel=image(:,:,1);
Gchannel=image(:,:,2);
Bchannel=image(:,:,3);
sigma_d=input('lotfan meghdar sigma d ra vared konid :   ');
sigma_r=input('lotfan meghdar sigma r ra vared konid :   ');
n=input('lotfan size panjere ra vared konid :   ');

[x y]=meshgrid(-n:n,-n:n);
domain_filter=exp(-(x.^2+y.^2)/(2*sigma_d^2));
[r c]=size(image);
output=zeros(size(image));
for i=1:r
    for j=1:c
        
        imin=max(i-n,1);
        imax=min(i+n,r);
        jmin=max(j-n,1);
        jmax=min(j+n,c);
        I=image(imin:imax,jmin:jmax);
        
      
        range_filter=exp(-(I-image(i,j)).^2/(2*sigma_r^2));
        
       
        BilateralFilter=range_filter.*domain_filter((imin:imax)-i+n+1,(jmin:jmax)-j+n+1);
        
        Fnorm=sum(BilateralFilter(:));
        
        
        Rout(i,j)=sum(sum(BilateralFilter.*I))/Fnorm;
        Gout(i,j)=sum(sum(BilateralFilter.*I))/Fnorm;
        Bout(i,j)=sum(sum(BilateralFilter.*I))/Fnorm;
    end
   
end


fimage(:,:,1)=(Rout);
fimage(:,:,2)=(Gout);
fimage(:,:,3)=(Bout);

subplot (131);
imshow(uint8(image));
title('orginal image');

subplot(132);
imshow(uint8(fimage));
title('noisy image');
