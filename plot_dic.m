% This script is intended to overlay strain field on reference image
% imshow( origImg ); hold on;
% h = imagesc( edgeImg ); % show the edge image
% set( h, 'AlphaData', .5 ); % .5 transparency
% colormap gray;
clc;clear;close all;

% Reading images
I0 = imread('cur.tif');
E = dicomread('IM-0054-0001.dcm');
I = zeros(size(E));
I(1:size(I0,1),1:size(I0,2)) = I0;
% normalizing images
E = double(E(:,:,1))./double(max(E(:)));
I = double(I(:,:,1))./double(max(I(:)));

figure, imshow(E), hold on
red = cat(3, ones(size(E)), zeros(size(E)), zeros(size(E)));
h = imshow(red);
set(h, 'AlphaData', I);

%%
Comb = E;
Comb(:,:,1) = (1-I).*E + I; % red
Comb(:,:,2) = (1-I).*E; % green
Comb(:,:,3) = (1-I).*E; % blue

figure, imshow(Comb)

%% Test im_overlay
clear;clc;close all;
a = double(imread('IM-0054-0002.tif'));
b = double(rand(size(a)));
out = im_overlay(a,b,0.5);
imshow(out,[]);
%% Test Two Axes 2 colormaps
f1 = figure;
ax1 = axes('Parent',f1);
ax2 = axes('Parent',f1);
set(ax1,'Visible','off');
set(ax2,'Visible','off');
% [a,map,alpha] = imread('foreground.png');
alpha = 0.5*ones(size(a));
I = imshow(a,[],'Parent',ax2); 
colormap(ax2, 'jet');
set(I,'AlphaData',alpha);
imshow(b,[],'Parent',ax1);
