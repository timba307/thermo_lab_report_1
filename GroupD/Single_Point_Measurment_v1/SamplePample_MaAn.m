% Laborpraktikum 5 - Fliesswasserkanal
% Andreas Loederer, Martin Barna
% Date: 25.10.2011

% start fresh
close all
clc
clear

test_run=0

if test_run
    nrSamples=100;    
    Vx=10+rand(nrSamples,1);
    Vy=1+5*rand(nrSamples,1);
    Vz=10+5*rand(nrSamples,1);
else
    % Einlesen der Daten
    %2011.02.24_16.27.29_Section1_15cm_8V_10000samp_XVelo.mat
%     2011.10.25_16.39.22_Wing1_20cm_4V_5000samp
    fdate='2011.10.25';
    ftime='16.39.22';
    ftitle='Wing1';
    fconVolt='20cm_4V';
    fsamp='5000samp';
    fVel='ZVelo';

    file=horzcat(fdate,'_',ftime,'_',ftitle,'_',fconVolt,'_',fsamp,'_',fVel,'.mat');

    load(file);

    posX=1;
    posY=1;
    posZ=1;
    nrSamples=5000;
end

% Einlesen der einzelnen Samples

for i=1:nrSamples
    if ~(test_run)
        Vx=data_full_z(posX,posY,posZ,1:i);
%         Vy=data_full_y(posX,posY,posZ,1:i);
%         Vz=data_full_z(posX,posY,posZ,1:i);

        % Berechnung des Mittelwerts und Standardabweichung
        Vxm(i)=mean(Vx);
%         Vym(i)=mean(Vy);
%         Vzm(i)=mean(Vz);

        Vxs(i)=std(Vx);
%         Vys(i)=std(Vy);
%         Vzs(i)=std(Vz);

    else    
        % Berechnung des Mittelwerts und Standardabweichung
        Vxm(i)=mean(Vx(1:i));
        Vym(i)=mean(Vy(1:i));
        Vzm(i)=mean(Vz(1:i));

        Vxs(i)=std(Vx(1:i));
        Vys(i)=std(Vy(1:i));
        Vzs(i)=std(Vz(1:i));
    end
end

figure(1)
% subplot(3,1,1)
errorbar(1:nrSamples,Vxm,Vxs);
xlabel('Nr Samples Vx');
ylabel('Mittelwert und Standardabweichung Vx');
grid;
% 
% subplot(3,1,2)
% errorbar(1:nrSamples,Vym,Vys);
% xlabel('Nr Samples Vy');
% ylabel('Mittelwert und Standardabweichung Vy');
% grid;
% 
% subplot(3,1,3)
% errorbar(1:nrSamples,Vzm,Vzs);
% xlabel('Nr Samples Vz');
% ylabel('Mittelwert und Standardabweichung Vz');
% grid;


figure(2)
% subplot(3,1,1)
plot(1:nrSamples,Vxm);
% xlabel('Nr Samples Vx');
% ylabel('Mittelwert und Standardabweichung Vx');
grid;

figure(3)
% subplot(3,1,1)
plot(1:nrSamples,Vxs);
% xlabel('Nr Samples Vx');
% ylabel('Mittelwert und Standardabweichung Vx');
grid;

% subplot(3,1,2)
% plot(1:nrSamples,Vys);
% % xlabel('Nr Samples Vy');
% % ylabel('Mittelwert und Standardabweichung Vy');
% grid;
% 
% subplot(3,1,3)
% plot(1:nrSamples,Vzs);
% % xlabel('Nr Samples Vz');
% % ylabel('Mittelwert und Standardabweichung Vz');
% grid;
    
    
    