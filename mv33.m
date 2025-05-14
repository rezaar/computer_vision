clear all
close all
clc

i=imread("rice.png");

BW = imbinarize(i); 
CC = bwconncomp(BW);
[L,num] = bwlabel(BW);
num

imshow(i)
imshow(BW)