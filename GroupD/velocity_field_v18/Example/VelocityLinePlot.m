% Laborpraktikum 5 - Fliesswasserkanal
% Maria Thumfart

% start fresh
close all
clc
clear




%% Read Data

% general properties of measurement 
fdate='2012.02.01';
ftime3='17.19.14';  % 3 cm behind wing
ftime6='17.29.32';  % 6 cm behind wing
ftitle='InletProfil';
fconVolt='h111_4V';
nrSamples=1000;


% Filenames of different velocity components 3 cm behind wing
fileX3=horzcat(fdate,'_',ftime3,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_XVelo.mat');
fileY3=horzcat(fdate,'_',ftime3,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_YVelo.mat');
fileZ3=horzcat(fdate,'_',ftime3,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_ZVelo.mat');

% load the data
load(fileX3);    % data_full_x
load(fileY3);    % data_full_y
load(fileZ3);    % data_full_z

% get the velocity data
ut3 = data_full_x(:,:,1,:);
vt3 = data_full_y(:,:,1,:);
wt3 = data_full_z(:,:,1,:);


% Filenames of different velocity components 6 cm behind wing
fileX6=horzcat(fdate,'_',ftime6,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_XVelo.mat');
fileY6=horzcat(fdate,'_',ftime6,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_YVelo.mat');
fileZ6=horzcat(fdate,'_',ftime6,'_',ftitle,'_',fconVolt,'_',mat2str(nrSamples),'samp_ZVelo.mat');

% load the data
load(fileX6);    % data_full_x
load(fileY6);    % data_full_y
load(fileZ6);    % data_full_z

% get the velocity data
ut6 = data_full_x(:,:,1,:);
vt6 = data_full_y(:,:,1,:);
wt6 = data_full_z(:,:,1,:);



%% calculate mean and standard deviation

% mean
um3 = mean(ut3,4);
vm3 = mean(vt3,4);
wm3 = mean(wt3,4);

um6 = mean(ut6,4);
vm6 = mean(vt6,4);
wm6 = mean(wt6,4);

% standard deviation
us3 = std(ut3,0,4);
vs3 = std(vt3,0,4);
ws3 = std(wt3,0,4);

us6 = std(ut6,0,4);
vs6 = std(vt6,0,4);
ws6 = std(wt6,0,4);


% turbulent fluctuations:
umM3 = um3'*ones(1,nrSamples);
vmM3 = um3'*ones(1,nrSamples);
wmM3 = um3'*ones(1,nrSamples);

umM6 = um6'*ones(1,nrSamples);
vmM6 = um6'*ones(1,nrSamples);
wmM6 = um6'*ones(1,nrSamples);

Uf3 = sqrt(( (squeeze(ut3)-umM3).^2 + (squeeze(vt3)-vmM3).^2 + (squeeze(wt3)-wmM3).^2 )./3);
U3 = sqrt((um3.^2 + vm3.^2 + wm3.^2));

Uf6 = sqrt(( (squeeze(ut6)-umM6).^2 + (squeeze(vt6)-vmM6).^2 + (squeeze(wt6)-wmM6).^2 )./3);
U6 = sqrt((um6.^2 + vm6.^2 + wm6.^2));

Int3 = mean(Uf3,2)'./U3;

Int6 = mean(Uf6,2)'./U6;

%% Plot the data

x = -0.02:0.01:0.16;

papSize = [15 12]; 

% mean velocities
figure(1);
plot(x,um3,x,vm3,x,wm3);
grid on;
legend('u','v','w');
title('Mean 3 cm behind wing');
xlabel('x in m');
ylabel('vel in m/s');
set(gcf,'PaperSize',papSize);

figure(2);
plot(x,um6,x,vm6,x,wm6);
grid on;
legend('u','v','w');
title('Mean 6 cm behind wing');
xlabel('x in m');
ylabel('vel in m/s');
set(gcf,'PaperSize',papSize);

figure(3)
quiver(x,zeros(size(x)),vm3,wm3);
hold on;
quiver(x,zeros(size(x)),vm6,wm6);
hold off;
legend('3 cm', '6 cm')
grid on;
title('velocity vectores in x-y-plane')
set(gcf,'PaperSize',papSize);


% components
figure(11);
errorbar(x,um3,us3);
hold on;
errorbar(x,um6,us6,'Color',[0 0.5 0]);
hold off;
grid on
legend('3 cm', '6 cm')
title('Mean with standard deviation');
xlabel('x in m');
ylabel('u in m/s');
set(gcf,'PaperSize',papSize);


figure(12);
errorbar(x,vm3,vs3);
hold on;
errorbar(x,vm6,vs6,'Color',[0 0.5 0]);
hold off;
grid on
legend('3 cm', '6 cm')
title('Mean with standard deviation');
xlabel('x in m');
ylabel('v in m/s');
set(gcf,'PaperSize',papSize);


figure(13);
errorbar(x,wm3,ws3);
hold on;
errorbar(x,wm6,ws6,'Color',[0 0.5 0]);
hold off;
legend('3 cm', '6 cm')
grid on
title('Mean with standard deviation');
xlabel('x in m');
ylabel('w in m/s');
set(gcf,'PaperSize',papSize);




% standard deviation
figure(21)
plot(x,us3,x,vs3,x,ws3);
grid on;
legend('u','v','w');
title('standard deviation, 3 cm behind wing');
xlabel('x in m');
ylabel('standard deviation in m/s');
set(gcf,'PaperSize',papSize);


figure(22)
plot(x,us6,x,vs6,x,ws6);
grid on;
legend('u','v','w');
title('standard deviation, 6 cm behind wing');
xlabel('x in m');
ylabel('standard deviation in m/s');
set(gcf,'PaperSize',papSize);





% turbulence intensity:
figure(31)
plot(x,Int3,x,Int6);
legend('3 cm', '6 cm')
grid on;
title('turbulence intensity');
xlabel('x in m');
ylabel('turbulence intensity mean(u´/U)');
set(gcf,'PaperSize',papSize);












