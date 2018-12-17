function movingPointsAdjusted = corr_subs(moving, fixed, ar)
% Registering an Image Using Normalized Cross-Correlation
% fixed: reference image in the target orientation, specified as a numeric array of finite values.
% moving: image to be registered, specified as a numeric array of finite values.
% a: radius of the moving region, half the vertice of square
% movingPointsAdjusted: fine tuned moving points

%% Step 1: Do Normalized Cross-Correlation and Find Coordinates of Peak
c = normxcorr2(moving,fixed);
% figure, surf(c), shading flat

%% Step 2: Find the Offset Between the Images
% offset found by correlation 
[ypeak, xpeak] = find(c == max(c(:)));
% [~, imax] = max(abs(c(:)));
% [ypeak, xpeak] = ind2sub(size(c),imax(1));
corr_offset = [(xpeak-size(moving,2)),(ypeak-size(moving,1))];
yoffset = corr_offset(1);
xoffset = corr_offset(2);
% center of small region in the fixed image / search window
ycenter = yoffset + ar;
xcenter = xoffset + ar;
%% Step 3: Fine Tune with cpcorr()
movingPoints = [ycenter xcenter]; % Coordinates of control points in the image to be transformed
fixedPoints = [ar+1 ar+1]; % Coordinates of control points in the reference image
movingPointsAdjusted = cpcorr(movingPoints,fixedPoints,fixed,moving);
