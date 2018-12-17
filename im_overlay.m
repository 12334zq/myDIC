function im_out = im_overlay(a,b,p)
% This function overlay image b on image a with a transparent factor p
% Inputs
% a - grayscale image, assumed the largest image, [0 1]
% b - grayscale image, if smaller than a, [0 1]
% p - transparent factor, [0 1]
% Outputs
% im_out - overlay image of a and b
% Author - Jiawei Dong
% Date - 08/26/2018
im_out1 = 2.*a.*b;
im_out1(a>=p)=0;
im_out2 = 1-2.*(1-a).*(1-b);
im_out2(a<p) = 0;
im_out = im_out1+im_out2;
