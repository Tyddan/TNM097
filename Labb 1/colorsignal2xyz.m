function [ XYZ ] = colorsignal2xyz( R, I )
% XYZ=colorsignal2xyz(reflectance,illumination)
%
% R = reflectance = Reflektansspektra (1x61)
% I = illumination = Belysningens spektralfördelning (1x61)
% XYZ = CIEXYZ-värden
%
% Reflektansspektra multipliceras med belysningens spektralfördelning
% och översätts sedan med hjälp av CIE:s standardobservatör till
% CIEXYZ-värden. Observatören återfinns i filen "xyz.mat". Glöm inte
% att beräkna k-värdet för belysningen och skala CIEXYZ-värdena med
% erhållet k-värde! (Formler för detta återfinns i laboration 3)
%
% Om CIEXYZ-värden ska beräknas för en belysning så kan
% reflektanspektrat ersättas med ettor (full reflektans i alla
% våglängder).
% Ex: reflectance = ones(1,61);

%x = [0.49 0.31 0.20];
%y = [0.17697 0.81240 0.01063];
%z = [0 0.01 0.99];
%load('H:\MATLAB\TNM059\Lab4\xyz.mat');
load('xyz.mat');
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

k = 100/(sum(I.*y'));

X = k*sum(I.*R.*x');
Y = k*sum(I.*R.*y');
Z = k*sum(I.*R.*z');


XYZ = [X Y Z];


end