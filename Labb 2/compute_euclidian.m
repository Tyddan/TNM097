function [max_value,mean_value] = compute_euclidian(XYZ_D65_ref,XYZ_D65)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    [L1, a1, b1] = xyz2lab(XYZ_D65_ref(:,1), XYZ_D65_ref(:,2), XYZ_D65_ref(:,3));
    [L2, a2, b2] = xyz2lab(XYZ_D65(:,1), XYZ_D65(:,2), XYZ_D65(:,3));
    
    euclidian = sqrt(((L1-L2).^2) + ((a1-a2).^2) + ((b1-b2).^2)); 
    
    max_value = max(euclidian);
    mean_value = mean(euclidian); 
end

