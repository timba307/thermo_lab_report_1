clear;
clc;
close all;

n = 10000; 

%Daten einlesen
data_x = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_XVelo.mat');
val_x = data_x.data_full_x;

data_y = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_YVelo.mat');
val_y = data_y.data_full_y;

data_z = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_ZVelo.mat');
val_z = data_z.data_full_z;

%Messwerte filtern
velocity_x = squeeze(val_x);
velocity_y = squeeze(val_y);
velocity_z = squeeze(val_z);

mean_x = zeros(1, n/1000);
mean_y = zeros(1, n/1000);
mean_z = zeros(1, n/1000);


% Mittelwert der Geschwindigkeiten für jeden der 10 Messpunkte
for i = 1:10
    mean_x(i) = mean(velocity_x((i-1)*1000 + 1 : i*1000));
    mean_y(i) = mean(velocity_y((i-1)*1000 + 1 : i*1000));
    mean_z(i) = mean(velocity_z((i-1)*1000 + 1 : i*1000));
end

% Plot X-Geschwindigkeit
points = 1:10;

figure('Name', 'Mean Velocity Profile X');

plot(points, mean_x, 'LineWidth', 1.5, 'Marker', 'o', 'DisplayName', 'Mean X-Velocity');
ylim([0.09 0.13]);
title('Mean Velocity Profile Across 10 Measurement Points');
xlabel('Measurement Point Number');
ylabel('Mean Velocity (m/s)');
legend('show', 'Location', 'best');
grid on;
box on;
xticks(points);

% Plot x-Geschwindigkeit
figure('Name', 'Mean Velocity Profile Y');

plot(points, mean_y, 'LineWidth', 1.5, 'Marker', 's', 'DisplayName', 'Mean Y-Velocity');
ylim([0 0.009]);
title('Mean Velocity Profile Across 10 Measurement Points');
xlabel('Measurement Point Number');
ylabel('Mean Velocity (m/s)');
legend('show', 'Location', 'best');
grid on;
box on;
xticks(points);

%Plot Z-Geschwindigkeit
figure('Name', 'Mean Velocity Profile Z');

plot(points, mean_z, 'LineWidth', 1.5, 'Marker', '^', 'DisplayName', 'Mean Z-Velocity');
ylim([-0.003 0.003]);
title('Mean Velocity Profile Across 10 Measurement Points');
xlabel('Measurement Point Number');
ylabel('Mean Velocity (m/s)');
legend('show', 'Location', 'best');
grid on;
box on;
xticks(points);

% 3D-Plot
%Skalierungsfaktor um die Werte anzugleichen
exaggeration_factor = 25;

x_origins = zeros(1, 10);
y_origins = 1:10;  % 10 Punkte in y richtung
z_origins = zeros(1, 10);

u_components = mean_x;
v_components = mean_y * exaggeration_factor; 
w_components = mean_z * exaggeration_factor;

figure('Name', '3D Velocity Vector Plot (Scaled)');

quiver3(x_origins, y_origins, z_origins, ...
        u_components, v_components, w_components, ...
        'LineWidth', 2, ...         
        'Color', [0 0.4 0.8], ...  
        'MaxHeadSize', 0.1);      

title_str = sprintf('3D Velocity Vectors (Y & Z scaled %dx)', exaggeration_factor);
title(title_str);
xlabel('X-Position');
ylabel('Y-Position (Measurement Point)');
zlabel('Z-Position');

yticks(1:10);
yticklabels({'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'P9', 'P10'});

grid on;
axis vis3d;

