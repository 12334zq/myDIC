% Simple example of a buildin DIC code
%% Read two images
clear;clc;close all;

%% Image Inputs
ref = double(imread('IM-0054-0001.tif'));
cur = double(imread('IM-0054-0002.tif'));
ref = double(ref)/256;
cur = double(cur)/256;
[row,col] = size(ref);

%% Grid Generator
a = 7; % square grid spacing, use odd integers
sw = 2*a+1; % square window size
ar = (a-1)/2; % square grid radius
swr = (sw-1)/2; % search window radius
% reference grid coordinates
rg = 2*a+1:row-2*a; % grid rows
cg = 2*a+1:col-2*a; % grid columns

[rg0,cg0] = meshgrid(cg,rg);
[rgsw0,cgsw0] = meshgrid(2*a-swr: col - 2*a+swr,2*a-swr+1: row - 2*a + swr);

% % show grid of interest
% figure; 
% A = imshow(ref);
% hold on;
% plot(rg0(:),cg0(:),'xw','Color',[.6 0 0]);
% hold off;
% % show search window range
% figure;
% B = imshow(cur);
% hold on;
% plot(rgsw0(:),cgsw0(:),'+','Color','b');
% hold off;

% deformed grid coordinates
rgs = zeros(size(rg)); % deformed grid rows
cgs = zeros(size(cg)); % deformed grid columns

%% matching each pixel within the grid
for i = 1:length(rg)
    for j = 1:length(cg)
       % subimage in reference
       moving = ref(rg(i)-ar:rg(i)+ar,cg(j)-ar:cg(j)+ar);
       % search window in current
       fixed = cur(rg(i)-swr:rg(i)+swr,cg(j)-swr:cg(j)+swr);
       % cross-correlation
       loc = corr_subs(moving,fixed,ar);
       rgs(i) = loc(1) + rg(i) - swr;
       cgs(j) = loc(2) + cg(j) - swr;
    end
end
% Displacement
rdsp = rgs - rg;
cdsp = cgs - cg;
[x, y] = meshgrid(cdsp,rdsp);
quiver(x,y); 
% %% Output Deformation Map
% figure; imagesc(x); title('horizontal displacement');
% figure; imagesc(y); title('vertical displacement');
%% Deformation Gradient
z = sqrt(x.^2+y.^2);
[dx, dy] = gradient(z,1,1);



