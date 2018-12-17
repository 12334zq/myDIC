% Basic assumption for this matching method is that the movement of object
% is slow and still within the neighborhood searching box.
clc;clear;close all;
%% load images
% Reference and current image are assumed to be same size
% TIF 
%
ref = imread('ref.tif'); % reference image
cur = imread('cur.tif'); % current image
%}

% DICOM
%{
path = uigetdir(pwd,'Locate reference image');
ref_file = uigetfile(fullfile(path,'*.dcm'));
ref = dicomread(fullfile(path,ref_file));
cur_file = uigetfile(fullfile(path,'*.dcm'));
cur = dicomread(fullfile(path,cur_file));
%}
[xmax,ymax] = size(ref);

%% resolution setup
% Window sizes or grid spacing
w_width = 8;
w_height = 8;
wsize = [w_width,w_height];

% Center points grid
xmin = w_width/2;
ymin = w_height/2;

% Grid points selected inside the image, not too close to the border
xgrid = 2*w_width:w_width:xmax-w_width;
ygrid = 2*w_height:w_height:ymax-w_height;

% Number of windows in total
w_x = length(xgrid);
w_y = length(ygrid);

% Ranges for "search" windows in image B
x_disp = w_width/2;
y_disp = w_height/2;


% For every window, first we create the test matrix in image A. Then image
% B, we have to correlate this test window around its original position in
% image A, the range is pre-determined. The point of max correlation
% corresponds to the final avg. displacement of that window
test_ima(w_width,w_height) = 0; 
test_imb(w_width+2*x_disp,w_height+2*y_disp) = 0;
dispx(w_x, w_y) = 0;
dispy(w_x, w_y) = 0;
xpeak1 = 0;
ypeak1 = 0;

%% Match for window around each grid point
% i,j are for the windows
% test_i and test_j are for the test window to be extracted from image A
for i = 1:w_x
    for j = 1:w_y
        max_correlation = 0;
        grid_xmin = xgrid(i) - w_width/2;
        grid_xmax = xgrid(i) + w_width/2;
        grid_ymin = ygrid(j) - w_height/2;
        grid_ymax = ygrid(j) + w_height/2;
        x_disp = 0;
        y_disp = 0;
        test_ima = ref(grid_xmin:grid_xmax,grid_ymin:grid_ymax);
        test_imb = cur(grid_xmin-x_disp:grid_xmax+x_disp,...
            grid_ymin-y_disp:grid_ymax+ y_disp);
        correlation = normxcorr2(test_ima,test_imb);
        [xpeak, ypeak] = find(correlation == max(correlation(:)));
        
        % Location in the reference configuration
        xpeak1 = grid_xmin + xpeak - w_width/2 - x_disp;
        ypeak1 = grid_ymin + ypeak - w_height/2 - y_disp;
        dispx(i,j) = xpeak1 - xgrid(i);
        dispy(i,j) = ypeak1 - ygrid(j);
    end
end

%% Displacement Vector Overlay
quiver(dispy,-dispx);

