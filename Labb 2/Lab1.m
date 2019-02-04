

%% 1 

R1 = chips20(1,:);
I1 = CIEA;

e = R1.*I1;
d = Ad'*e';

%% 1.1

wave = 400:5:700;

figure(1)
plot(wave,Ad);
figure(2)
plot(wave,Ad2);

%% 1.2

    RGB_raw_D65 = zeros(20,3);
% Camera 1
for i = 1:20
    RGB_raw_D65(i,:) = Ad'*(chips20(i,:).*CIED65)';
end

    RGB_raw_D65_2 = zeros(20,3);
    
% Camera 2
for i = 1:20
    RGB_raw_D65_2(i,:) = Ad2'*(chips20(i,:).*CIED65)';
end

showRGB(RGB_raw_D65);
showRGB(RGB_raw_D65_2);

%% 2.1
e = ones(1,61);
d = Ad'*e';
d2 = Ad2'*e';

normal_1 = (1./d);
normal_2 = (1./d2); 

%% 2.2 
RGB_cal_D65 = zeros(20,3);
RGB_cal_D65_2 = zeros(20,3);

for i = 1:20
    RGB_cal_D65(i,1) = RGB_raw_D65(i,1)*normal_1(1);
    RGB_cal_D65(i,2) = RGB_raw_D65(i,2)*normal_1(2);
    RGB_cal_D65(i,3) = RGB_raw_D65(i,3)*normal_1(3);

    RGB_cal_D65_2(i,1) = RGB_raw_D65_2(i,1)*normal_2(1);
    RGB_cal_D65_2(i,2) = RGB_raw_D65_2(i,2)*normal_2(2);
    RGB_cal_D65_2(i,3) = RGB_raw_D65_2(i,3)*normal_2(3);
end

showRGB(RGB_raw_D65);
showRGB(RGB_cal_D65);

showRGB(RGB_raw_D65_2);
showRGB(RGB_cal_D65_2);

%% 2.3 
wave = 400:5:700;

figure(1)
plot(wave, CIED65);
figure(2)
plot(wave, CIEA);

%% 2.4 

    RGB_raw_A = zeros(20,3);
% Camera 1
for i = 1:20
    RGB_raw_A(i,:) = Ad'*(chips20(i,:).*CIEA)';
end

RGB_cal_A = zeros(20,3);

for i = 1:20
    RGB_cal_A(i,1) = RGB_raw_A(i,1)*normal_1(1);
    RGB_cal_A(i,2) = RGB_raw_A(i,2)*normal_1(2);
    RGB_cal_A(i,3) = RGB_raw_A(i,3)*normal_1(3);
end

showRGB(RGB_cal_D65);
showRGB(RGB_cal_A);

%% 2.5
R = ones(1,61); 

d_65 = Ad'*(R.*CIED65)';
normal_white_65 = (1./d);

d_A = Ad'*(R.*CIEA)';
normal_white_A = (1./d);


RGB_cal_A_white = zeros(20,3);
RGB_cal_D65_white = zeros(20,3);

for i = 1:20
    RGB_cal_A_white(i,1) = RGB_raw_A(i,1)*normal_white_A(1);
    RGB_cal_A_white(i,2) = RGB_raw_A(i,2)*normal_white_A(2);
    RGB_cal_A_white(i,3) = RGB_raw_A(i,3)*normal_white_A(3);

    RGB_cal_D65_white(i,1) = RGB_raw_D65(i,1)*normal_white_65(1);
    RGB_cal_D65_white(i,2) = RGB_raw_D65(i,2)*normal_white_65(2);
    RGB_cal_D65_white(i,3) = RGB_raw_D65(i,3)*normal_white_65(3);
end

showRGB(RGB_cal_D65_white);
showRGB(RGB_cal_A_white);

%% 3.1
XYZ_D65_ref = zeros(20,3);
for i = 1:20
    XYZ_D65_ref(i,:) = colorsignal2xyz(chips20(i,:), CIED65); 
end

%% 3.2 
Q = inv(M_XYZ2RGB);
XYZ_D65 = Q*RGB_cal_D65';

[max_value,mean_value] = compute_euclidian(XYZ_D65',XYZ_D65_ref);

%% 3.3 
wave = 400:5:700;

figure(1)
plot(wave, Ad);
figure(2)
plot(wave, xyz);

%% 3.4 
D = RGB_cal_D65;
C = XYZ_D65_ref;
A = pinv(D)*C;

XYZ_D65_new_E = RGB_cal_D65 * A;
[max_value2,mean_value2] = compute_euclidian(XYZ_D65_ref,XYZ_D65_new_E);

%% 3.5 
A2 = Optimize_poly(RGB_cal_D65',XYZ_D65_ref');
XYZ_est = Polynomial_regression(RGB_cal_D65',A2);
[max_value3,mean_value3] = compute_euclidian(XYZ_D65_ref,XYZ_est');
