% Laborpraktikum 5 - Fliesswasserkanal
% Maria Thumfart

% start fresh
close all
clc
clear




%% Read Data

% general properties of measurement 
fdate='2012.11.22';
ftime='17.20.10';  % new black wing profile
ftitle='Wing_profile';
fconVolt='4V';
nrSamples=1000;

fdate3='2012.11.22';
ftime3='17.02.44';  % triangle wing
ftitle3='Wing';
fconVolt3='4V';
nrSamples3=1000;


% Filenames of different velocity components 3 cm behind wing
fileX3=horzcat(fdate3,'_',ftime3,'_',ftitle3,'_',fconVolt3,'_',mat2str(nrSamples3),'samp_XVelo.mat');
fileY3=horzcat(fdate3,'_',ftime3,'_',ftitle3,'_',fconVolt3,'_',mat2str(nrSamples3),'samp_YVelo.mat');
fileZ3=horzcat(fdate3,'_',ftime3,'_',ftitle3,'_',fconVolt3,'_',mat2str(nrSamples3),'samp_ZVelo.mat');

% load the data
load(fileX3);    % data_full_x
load(fileY3);    % data_full_y
load(fileZ3);    % data_full_z

% get the velocity data
ut3 = data_full_x(:,:,1,:);
vt3 = data_full_y(:,:,1,:);
wt3 = data_full_z(:,:,1,:);


% Filenames of different velocity components 3 cm behind wing
fileX=horzcat(fdate,'_',ftime,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_XVelo.mat');
fileY=horzcat(fdate,'_',ftime,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_YVelo.mat');
fileZ=horzcat(fdate,'_',ftime,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_ZVelo.mat');

% load the data
load(fileX);    % data_full_x
load(fileY);    % data_full_y
load(fileZ);    % data_full_z

% get the velocity data
ut = data_full_x(:,:,1,:);
vt = data_full_y(:,:,1,:);
wt = data_full_z(:,:,1,:);


%% calculate mean and standard deviation

% mean
um3 = mean(ut3,4);
vm3 = mean(vt3,4);
wm3 = mean(wt3,4);

% standard deviation
us3 = std(ut3,0,4);
vs3 = std(vt3,0,4);
ws3 = std(wt3,0,4);


% turbulent fluctuations:
umM3 = um3'*ones(1,nrSamples3);
vmM3 = um3'*ones(1,nrSamples3);
wmM3 = um3'*ones(1,nrSamples3);

Uf3 = sqrt(( (squeeze(ut3)-umM3).^2 + (squeeze(vt3)-vmM3).^2 + (squeeze(wt3)-wmM3).^2 )./3);
U3 = sqrt((um3.^2 + vm3.^2 + wm3.^2));


Int3 = mean(Uf3,2)'./U3;


% mean
um = mean(ut,4);
vm = mean(vt,4);
wm = mean(wt,4);

% standard deviation
us = std(ut,0,4);
vs = std(vt,0,4);
ws = std(wt,0,4);


% turbulent fluctuations:
umM = um'*ones(1,nrSamples);
vmM = um'*ones(1,nrSamples);
wmM = um'*ones(1,nrSamples);

Uf = sqrt(( (squeeze(ut)-umM).^2 + (squeeze(vt)-vmM).^2 + (squeeze(wt)-wmM).^2 )./3);
U = sqrt((um.^2 + vm.^2 + wm.^2));


Int = mean(Uf,2)'./U;



%% Plot the data

x = -0.03:0.01:0.17;

x3 = -0.03:0.01:0.07;

papSize = [15 12]; 

% mean velocities
figure(1);
plot(x3,um3,x3,vm3,x3,wm3);
grid on;
legend('u','v','w');
title('triangle wing');
xlabel('x in m');
ylabel('vel in m/s');
set(gcf,'PaperSize',papSize);

figure(2);
plot(x,um,x,vm,x,wm);
grid on;
legend('u','v','w');
title('new wing');
xlabel('x in m');
ylabel('vel in m/s');
set(gcf,'PaperSize',papSize);


figure(3)
quiver(x3,zeros(size(x3)),vm3,wm3);
hold on;
quiver(x,zeros(size(x)),vm,wm);
hold off;
legend('triangle', 'black, new')
grid on;
title('velocity vectores in x-y-plane')
set(gcf,'PaperSize',papSize);


% components
figure(11);
errorbar(x3,um3,us3);
hold on;
errorbar(x,um,us);
hold off;
grid on
legend('triangle', 'black, new')
title('Mean with standard deviation');
xlabel('x in m');
ylabel('u in m/s');
set(gcf,'PaperSize',papSize);


figure(12);
errorbar(x3,vm3,vs3);
hold on;
errorbar(x,vm,vs);
hold off;
grid on
legend('triangle', 'black, new')
title('Mean with standard deviation');
xlabel('x in m');
ylabel('v in m/s');
set(gcf,'PaperSize',papSize);


figure(13);
errorbar(x3,wm3,ws3);
hold on;
errorbar(x,wm,ws);
hold off;
legend('triangle', 'black, new')
grid on
title('Mean with standard deviation');
xlabel('x in m');
ylabel('w in m/s');
set(gcf,'PaperSize',papSize);




% standard deviation
figure(21)
plot(x3,us3,x3,vs3,x3,ws3);
grid on;
legend('u','v','w');
title('standard deviation, triangle');
xlabel('x in m');
ylabel('standard deviation in m/s');
set(gcf,'PaperSize',papSize);

figure(22)
plot(x,us,x,vs,x,ws);
grid on;
legend('u','v','w');
title('standard deviation, new, black wing');
xlabel('x in m');
ylabel('standard deviation in m/s');
set(gcf,'PaperSize',papSize);




% turbulence intensity:
figure(31)
plot(x3,Int3,x,Int);
legend('triangle', 'black, new')
grid on;
title('turbulence intensity');
xlabel('x in m');
ylabel('turbulence intensity mean(u´/U)');
set(gcf,'PaperSize',papSize);








