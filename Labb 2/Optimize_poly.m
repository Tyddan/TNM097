function A = Optimize_poly(RGB,XYZ)
% function A = Optimize_poly(RGB,XYZ)
% Returns the 11x3-matrix A, containing weights for polynomial regression
% using a second order mixed polynomial + RGB-term
%
% RGB is trainang data for T samples in the format 3xT
% XYZ is the correspoding XYZ-data for the same T samples, in the format 3xT
%
%--------------------------------------------------------------------------

R=0;G=0;B=0;
v = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R*G*B];   % 
RGB_training=RGB';
XYZ_train=XYZ';
Pt=zeros(length(RGB_training),length(v));

for r=1:length(RGB_training)
    R=RGB_training(r,1);
    G=RGB_training(r,2);
    B=RGB_training(r,3);
    Pt(r,:) = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R*G*B];   
end

A = pinv(Pt)*XYZ_train;

