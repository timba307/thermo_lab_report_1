function [result_rel_dev_n] = relative_std_N(raw_full_vx,raw_full_vy,...
    raw_full_vz)
%RELATIVE_STD_N Calculating the mean uncorrected relative Standarddeviation
%               of the velocity vector
%   raw_full_vx... 4D-Double of all vx_samples (no Knowledge of primary
%              Data-Structure) 
%   raw_full_vy... 4D-Double of all vy_samples (no Knowledge of primary
%              Data-Structure) 
%   raw_full_vz... 4D-Double of all vz_samples (no Knowledge of primary
%              Data-Structure)


%size raw dat
dim_values = size(raw_full_vx);
number_testvolumes = dim_values(1)*dim_values(2)*dim_values(3);

%create a vector with all velocities in each test volume
velocities = zeros(number_testvolumes,dim_values(4));
rel_std_devs = zeros(number_testvolumes,dim_values(4));
%%
linecounter=0;
%%
for i = 1:dim_values(1)
    %%
    for j = 1:dim_values(2)
        %%
        for k = 1:dim_values(3)
            linecounter = linecounter + 1;
            for l = 1:dim_values(4)
                velocity = sqrt(raw_full_vx(i,j,k,l)^2 +...
                    raw_full_vy(i,j,k,l)^2 + raw_full_vz(i,j,k,l)^2);
                velocities(linecounter,l) = velocity;
            end
        end
    end
end
%%
%calculate relative standard deviations

for m = 1:number_testvolumes
    sum_velocity_volume = 0;
    sum_deviation = 0;
    for n = 1:dim_values(4)
        sum_velocity_volume = sum_velocity_volume + velocities(m,n);
        mean_velocity_volume = sum_velocity_volume/n;
        sum_deviation = sum_deviation + ...
            (velocities(m,n)-mean_velocity_volume)^2;
        rel_std_devs(m,n) = (sqrt(sum_deviation/n))/mean_velocity_volume;
    end
end
%%
%create mean relative standard devitions dependent on samples

result_rel_dev_n = sum(rel_std_devs,1);
result_rel_dev_n = result_rel_dev_n/dim_values(4);
samples = 1:1:dim_values(4);
%%
figure();
plot(samples,mean_velocity_volume);
xlim([2 dim_values(4)]);
grid on;
end

