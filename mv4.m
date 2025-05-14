clear all
close all
clc

alfa = 0.04;
Threshold = 90000;
sigma = 1;
halfwid = sigma * 3;

[xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);


Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

I = imread('cow.png');
I = rgb2gray(I);

numOfRows = size(I, 1);
numOfColumns = size(I, 2);

%  مشتقات x و y تصویر را محاسبه کنید
Ix = conv2(Gx, I);
Iy = conv2(Gy, I);

size(Ix);

%  IX2 و IY2 و IXY را محاسبه میکنیم
Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;

% مجموع حاصل از مشتقات را در هر پیکسل محاسبه کنید(کانوالو پنجره)
Sx2 = conv2(Gxy, Ix2);
Sy2 = conv2(Gxy, Iy2);
Sxy = conv2(Gxy, Ixy);

im = zeros(numOfRows, numOfColumns);
for x=1:numOfRows
   for y=1:numOfColumns
       x;y;
       % در هر پیکسل (x,y) ماتریس H را تعریف کنید
       M = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)];
       
       
       R = det(M) - alfa * (trace(M) ^ 2);
       
       
       if (R > Threshold)
          im(x, y) = R; 
       end
   end
end


output = im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);

subplot (131);
imshow(I);
title('orginal image');

subplot (132);
imshow(im);
title('Find points with large corner response: R>threshold');

subplot (133);
imshow(output);
title('Take only the points of local maxima of R');


