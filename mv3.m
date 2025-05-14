close all
clear all
clc

se = strel('disk',5);               %ایجاد عنصر ساختار مورفولوژیکی

i=imread("circles.png");
i0 = imerode(i,se);                 %فرسایش تصویر
i1 = imdilate(i,se);                %گشاد کردن تصویر
i2 = imopen(i,se);                  %عملیات اوپن
i3 = imclose(i,se);                 %عملیات کلوز
i4 = bwskel(i);
i5 = bwperim(i,8);                  %یافتن محیط تصویر باینری

[l,num]=bwlabel(i);
  num
area = bwarea(i)                    %اندازه محیط تصویر

subplot (331);
imshow(i);
title('orginal image');
subplot (332);
imshow(i0);
title('Erode image');

subplot (333);
imshow(i1,[]);
title('	Dilate image');

subplot (334);
imshow(i2);
title('Morphologically open image');

subplot (335);
imshow(i3);
title('Morphologically close image');

subplot (336);
imshow(i4);
title('skelet of image');

subplot (337);
imshow(i5);
title('the perimeter pixels of objects in the input image');