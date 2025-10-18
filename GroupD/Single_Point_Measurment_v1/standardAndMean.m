% read the velocity data and evaluate the mean and standard deviation and
% plot the change with the samplenumber

clear;
clc;

close all;

% load the data
load('2017.12.07_15.58.21_Wing1_20cm_4V_5000samp_XVelo.mat');
load('2017.12.07_15.58.21_Wing1_20cm_4V_5000samp_YVelo.mat');
load('2017.12.07_15.58.21_Wing1_20cm_4V_5000samp_ZVelo.mat');

% initialize
nD=length(data_full_x);

mX = zeros(1,nD);
mY = zeros(1,nD);
mZ = zeros(1,nD);

sX = zeros(1,nD);
sY = zeros(1,nD);
sZ = zeros(1,nD);


for n=1:nD
    % mean velocities
    mX(n)=mean(data_full_x(1:n));
    mY(n)=mean(data_full_y(1:n));
    mZ(n)=mean(data_full_z(1:n));
    
    % standard deviation
    sX(n)=std(data_full_x(1:n));
    sY(n)=std(data_full_y(1:n));
    sZ(n)=std(data_full_z(1:n));
end

% Papersize
papSize = [15 12]; 

figure(1)
plot(1:nD,sX./sX(end).*100,1:nD,mX./mX(end).*100)
title('x-velocity')
xlabel('Samples')
ylabel('Std/mean [%]')
grid on;
legend('standard deviation','mean');
set(gcf,'PaperSize',papSize);

figure(2)
plot(1:nD,sY./sY(end).*100,1:nD,mY./mY(end).*100)
title('Y-velocity')
xlabel('Samples')
ylabel('Std/mean [%]')
grid on;
legend('standard deviation','mean');
set(gcf,'PaperSize',papSize);

figure(3)
plot(1:nD,sZ./sZ(end).*100,1:nD,mZ./mZ(end).*100)
title('Z-velocity')
xlabel('Samples')
ylabel('Std/mean [%]')
grid on;
legend('standard deviation','mean');
set(gcf,'PaperSize',papSize);



figure(11)
plot(1:nD,squeeze(data_full_x),1:nD,squeeze(data_full_y),1:nD,squeeze(data_full_z))
grid on;
title('velocities');
legend('x','y','z');
set(gcf,'PaperSize',papSize);
xlabel('sample number');
ylabel('velocity in m/s');


