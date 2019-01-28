function XYZ_est = Polynomial_regression(RGB,A)
% function XYZ_est = Polynomial_regression(RGB,A)
% Returns the 3xT matrix XYZ_est with estimated XYZ-values for T samples,
% computed from  RGB using a second order mixed polynomial + RGB-term 
% and the weight in the matrix A
% 
% RGB is device data for T samples, in the format 3xT
% A is the 11x3-matrix containing weights for the polynomial regression
%
%--------------------------------------------------------------------------

R=0;G=0;B=0;
v = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R*G*B];   % Second order +RGB-term
RGB_training=RGB';

Pv=zeros(length(RGB_training),length(v));
for r=1:length(RGB_training)
    R=RGB_training(r,1);
    G=RGB_training(r,2);
    B=RGB_training(r,3);
    Pv(r,:) = [1 R G B R.^2 R*G R*B G.^2 G*B B.^2 R*G*B];   % Second order +RGB-term
end

XYZ_est = (Pv*A)';
