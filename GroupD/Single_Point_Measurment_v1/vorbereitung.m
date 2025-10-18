%Dateiname bearbeiten 
n = 10000;  % oder eine andere Zahl, z. B. 2000, 10000, ...
%filename_x = sprintf('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_XVelo.mat', n);
%filename_y = sprintf('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_YVelo.mat', n);
%filename_z = sprintf('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_ZVelo.mat', n);

%Daten einlesen
data_x = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_XVelo.mat');
val_x = data_x.data_full_x;

data_y = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_YVelo.mat');
val_y = data_y.data_full_y;

data_z = load('2025.10.17_09.44.16_test_10k_Samples5V_10000samp_ZVelo.mat');
val_z = data_z.data_full_z;

%Messwerte filtern
means_x = squeeze(val_x);
means_y = squeeze(val_y);
means_z = squeeze(val_z);

%
std_percent_x = zeros(1, n);
std_percent_y = zeros(1, n);
std_percent_z = zeros(1, n);

mean_x = zeros(1, n);
mean_y = zeros(1, n);
mean_z = zeros(1, n);

for i = 1:n
    current_vals_x = means_x(1:i);
    std_percent_x(i) = std(current_vals_x) / mean(current_vals_x) * 100;
    mean_x(i)= mean(current_vals_x);

    current_vals_y = means_y(1:i);
    std_percent_y(i) = std(current_vals_y) / mean(current_vals_y) * 100;
    mean_y(i)= mean(current_vals_y);

    current_vals_z = means_z(1:i);
    std_percent_z(i) = std(current_vals_z) / mean(current_vals_z) * 100;
    mean_z(i)= mean(current_vals_z);
end

fprintf('Mittlere Geschwindigkeit in x-Richtung: %d\n', mean(current_vals_x))
fprintf('Mittlere Geschwindigkeit in y-Richtung: %d\n', mean(current_vals_y))
fprintf('Mittlere Geschwindigkeit in z-Richtung: %d\n', mean(current_vals_z))

% Plot 
figure('Position', [100 100 1200 800]);

%subplot(6,1,1)   % 3 Zeilen, 1 Spalte, erstes Plotfenster
plot(1:n, std_percent_x, 'r', 'LineWidth', 1.5)
title('x-velocity')
ylabel('std in %')
xlabel('Number of Samples')
grid on

%subplot(6,1,2)   % zweites Plotfenster
plot(1:n, std_percent_y, 'g', 'LineWidth', 1.5)
title('y-velocity')
ylabel('std in %')
xlabel('Number of Samples')
grid on

%subplot(6,1,3)   % drittes Plotfenster
plot(1:n, std_percent_z, 'b', 'LineWidth', 1.5)
title('z-velocity')
ylabel('std in %')
xlabel('Number of Samples')
grid on

%subplot(6,1,4)   % drittes Plotfenster
plot(1:n,mean_x, 'b', 'LineWidth', 1.5)
hold on 
line([1 n],[0.1124 0.1124])
title('x-velocity')
ylabel('mean velocity in m/s')
xlabel('Number of Samples')
grid on

%subplot(6,1,5)   % drittes Plotfenster
plot(1:n, mean_y, 'b', 'LineWidth', 1.5)
title('y-velocity')
ylabel('mean velocity in m/s')
xlabel('Number of Samples')
grid on

%subplot(6,1,6)   % drittes Plotfenster
plot(1:n, mean_z, 'b', 'LineWidth', 1.5)
title('z-velocity')
ylabel('mean velocity in m/s')
xlabel('Number of Samples')
grid on
