% Load X velocity data
load('2025.10.10_10.58.19_test_10k_Samples5V_10000samp_XVelo.mat');
%load('2024.10.25_14.06.10_test_10k_Samples5V_10000samp_XVelo.mat');

xvelo = squeeze(data_full_x);

N = length(xvelo);

% Progressive mean
prog_mean = cumsum(xvelo) ./ (1:N)';

% Progressive standard deviation
prog_std = zeros(N,1);
for i = 1:N
    prog_std(i) = std(xvelo(1:i));
end

% Plot
figure;
plot(xvelo, 'Color', [0.2 0.6 0.8], 'DisplayName', 'X Velocity');
hold on;
plot(prog_mean, 'r', 'LineWidth', 1.5, 'DisplayName', 'Progressive Mean');
plot(prog_std, 'g', 'LineWidth', 1.5, 'DisplayName', 'Progressive Std Dev');
xlabel('Sample Index');
ylabel('Velocity');
title('X Velocity: Progressive Mean and Std Dev');
legend('show');
grid on;
