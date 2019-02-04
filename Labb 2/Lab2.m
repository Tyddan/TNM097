%% Calibration of Output devices
% 1.1
load TRC_display.mat

t = 0:0.01:1;

figure(1);
plot(t,TRCr, 'r');
hold on 
plot(t,TRCg, 'g');
hold on
plot(t, TRCb, 'b');
hold off

%% 1.2
figure(2)
imshow(Ramp_display);
figure(3)
imshow(Ramp_linear);

x = 0:0.01:1;

nyRamp(:,:,1) = interp1(TRCr,x,Ramp_display(:,:,1),'pchip');
nyRamp(:,:,2) = interp1(TRCg,x,Ramp_display(:,:,2),'pchip');
nyRamp(:,:,3) = interp1(TRCb,x,Ramp_display(:,:,3),'pchip');

figure(4)
imshow(nyRamp);

%% 1.3
yr = 2.1;
yg = 2.4;
yb = 1.8;

Dr = Ramp_display(:,:,1);
Dg = Ramp_display(:,:,2);
Db = Ramp_display(:,:,3);

DR = Dr.^(1/yr);
DG = Dg.^(1/yg);
DB = Db.^(1/yb);

nyRamp2(:,:,1) = DR;
nyRamp2(:,:,2) = DG;
nyRamp2(:,:,3) = DB;

figure(5)
imshow(nyRamp2);

%% 2 Spectral forward model of the output device
% 2.1
wave = 400:5:700;
figure(6)
plot(wave, DLP);

%% 2.2
XYZ_raw = zeros(20,3);

for i = 1:20
    SRGB(:,i) = DLP*RGB_raw(:,i);
    XYZ_raw(i,:) = RGB2xyz(SRGB(:,i)', CIED65);
end

[max_value_raw,mean_value_raw] = compute_euclidian(XYZ_raw,XYZ_ref');


%% 2.3


XYZ_cal = zeros(20,3);

for i = 1:20
    SRGB(:,i) = DLP*RGB_cal(:,i);
    XYZ_cal(i,:) = RGB2xyz(SRGB(:,i)', CIED65);
end


[max_value_cal,mean_value_cal] = compute_euclidian(XYZ_cal,XYZ_ref');


%% 3 Inverse characterization of the output device
% 3.1

for i = 1:3
     XYZ_DLP(i,:) = RGB2xyz(DLP(:,i)', CIED65);
end

ACRT = XYZ_DLP';

%% 3.2
RGB_est = inv(ACRT)*XYZ_est;


XYZ_esti = zeros(20,3);
for i = 1:20
    SRGB(:,i) = DLP*RGB_est(:,i);
    XYZ_esti(i,:) = RGB2xyz(SRGB(:,i)', CIED65);
end



[max_value_est,mean_value_est] = compute_euclidian(XYZ_esti,XYZ_ref');

%% 3.3
    imshow(RGB_est)
    
%% 3.4 

norm_RGB_est = max(RGB_est,0);


XYZ_esti2 = zeros(20,3);
for i = 1:20
    SRGB(:,i) = DLP*norm_RGB_est(:,i);
    XYZ_esti2(i,:) = RGB2xyz(SRGB(:,i)', CIED65);
end

[max_value_est_norm,mean_value_est_norm] = compute_euclidian(XYZ_esti2,XYZ_ref');

%% 3.5
plot_chrom_sRGB(ACRT)

%% 3.6
figure(7)
plot(CIED65.*chips20(1,:))
figure(8)
plot(SRGB(:,1))

