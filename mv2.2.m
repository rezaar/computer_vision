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

[Rout]=bilateral_each_channel(n,sigma_r,sigma_d,Rchannel);
[Gout]=bilateral_each_channel(n,sigma_r,sigma_d,Gchannel);
[Bout]=bilateral_each_channel(n,sigma_r,sigma_d,Bchannel);
fimage(:,:,1)=(Rout);
fimage(:,:,2)=(Gout);
fimage(:,:,3)=(Bout);

subplot (131);
imshow(image);
title('orginal image');

subplot(132);
imshow(fimage);
title('noisy image');
