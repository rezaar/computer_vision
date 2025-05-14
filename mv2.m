clear all
close all
clc

image=imread("cameraman.tif"); %فراخانی تصویر
 
sigma=input('lotfan meghdar sigma ra vared konid :   ');%وارد کردن سیکما نویز
sigma_d=input('lotfan meghdar sigma d ra vared konid :   ');%وارد کردن سیکما فاصله
sigma_r=input('lotfan meghdar sigma r ra vared konid :   ');%وارد کردن سیکما اندازه
n=input('lotfan size panjere ra vared konid :   ');%وارد کردن اندازه پنجره

gaussian_noise=sigma*randn(size(image)); %تشکیل نویز گوسین

noisy_image=double(image)+gaussian_noise;% اضافه کردن نویز گوسین به تصویر


[x,y]=meshgrid(-n:n,-n:n);% تبدیل میکند x و y  دامنه مشخص شده توسط سایز پنجره را به آرایه های
domain_filter=exp(-(x.^2+y.^2)/(2*sigma_d^2));  % کرنر فاصله
[r,c]=size(noisy_image); %سایز تصویر نویزی
output=zeros(size(noisy_image));



for i=1:r
    for j=1:c
        
        %تنظیم اندازه پنجره
        imin=max(i-n,1);
        imax=min(i+n,r);
        jmin=max(j-n,1);
        jmax=min(j+n,c);
        I=noisy_image(imin:imax,jmin:jmax);
        
        range_filter=exp(-double(I-noisy_image(i,j)).^2/(2*sigma_r^2)); % کرنر اندازه
        
        %اعمال فیلتر 
        BilateralFilter=range_filter.*domain_filter((imin:imax)-i+n+1,(jmin:jmax)-j+n+1);
        
        Fnorm=sum(BilateralFilter(:));
        output(i,j)=sum(sum(BilateralFilter.*double(I)))/Fnorm; %نرمال کردن خروجی
    end
     
end





subplot (131);
imshow(image);
title('orginal image');

subplot(132);
imshow(noisy_image,[]);
title('noisy image');

subplot (133);
imshow(output,[]);
title('Filtered image');