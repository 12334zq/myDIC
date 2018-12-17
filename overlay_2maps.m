function overlay_2maps(a,m1,b,m2)
% This function overlay two plots that uses different color maps
% INPUTS
% a - image matrix 1
% m1 - colormap in string, e.g.: 'jet'
% b - image matrix 2
% m2 - colormap in string, e.g.: 'gray'
% OUTPUTS
% the only output is a plot of overlayed image
f1 = figure;
ax1 = axes('Parent',f1);
ax2 = axes('Parent',f1);
set(ax1,'Visible','off');
set(ax2,'Visible','off');
alpha = 0.5*ones(size(a));
imI = imshow(a,[],'Parent',ax2); 
colormap(ax2, m1);
set(imI,'AlphaData',alpha);
imshow(b,[],'Parent',ax1);
colormap(ax1, m2);