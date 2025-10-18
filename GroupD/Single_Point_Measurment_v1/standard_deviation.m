clear;
close all;
clc;


% X_DATA
x_mat = load('2022.11.28_10.03.21_test_10k_Samples4V_10000samp_XVelo.mat')
x_data = x_mat.data_full_x(:,:,:,:)

n =0;
mean = 0;
old_mean = 0 ;
squared_diff = 0;
sigma_squared = 0;
sigma = 0;


s = zeros(1,length(x_data));
running_mean = zeros(1,length(x_data));
for i = 1:length(x_data)
    [mean,sigma,n,squared_diff,sigma_squared] = add_func(x_data(i),n,mean,squared_diff);
    s(i)=sigma;
    running_mean(i) = mean;
end
    
figure()
grid on;
plot(s);
hold on;
plot(running_mean);
legend('sigma', 'mean');
title('velocity x');
xlabel('samples');

% Y_DATA
y_mat = load('2022.11.28_10.03.21_test_10k_Samples4V_10000samp_YVelo.mat')
y_data = y_mat.data_full_y(:,:,:,:)

n =0;
mean = 0;
old_mean = 0 ;
squared_diff = 0;
sigma_squared = 0;
sigma = 0;


s = zeros(1,length(y_data));
running_mean = zeros(1,length(y_data));
for i = 1:length(x_data)
    [mean,sigma,n,squared_diff,sigma_squared] = add_func(y_data(i),n,mean,squared_diff);
    s(i)=sigma;
    running_mean(i) = mean;
end
    
figure()
grid on;
plot(s);
hold on;
plot(running_mean);
legend('sigma', 'mean');
title('velocity y');
xlabel('samples');

% Z_DATA
z_mat = load('2022.11.28_10.03.21_test_10k_Samples4V_10000samp_ZVelo.mat')
z_data = z_mat.data_full_z(:,:,:,:)

n =0;
mean = 0;
old_mean = 0 ;
squared_diff = 0;
sigma_squared = 0;
sigma = 0;


s = zeros(1,length(z_data));
running_mean = zeros(1,length(z_data));
for i = 1:length(z_data)
    [mean,sigma,n,squared_diff,sigma_squared] = add_func(z_data(i),n,mean,squared_diff);
    s(i)=sigma;
    running_mean(i) = mean;
end
    
figure()
grid on;
plot(s);
hold on;
plot(running_mean);
legend('sigma', 'mean');
title('velocity z');
xlabel('samples');


