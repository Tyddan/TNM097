function [ XYZ ] = RGB2xyz( SRGB, I )

load('xyz.mat');
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

k = 100/(sum(I.*y'));

X = k*sum(SRGB.*x');
Y = k*sum(SRGB.*y');
Z = k*sum(SRGB.*z');


XYZ = [X Y Z];


end