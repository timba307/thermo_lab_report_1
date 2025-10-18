clear all;
close all;
clc;

data = load('2017.12.19_09.32.33_test_10k_Samples4V_10000samp_XVelo.mat');
deviation(data.data_full_x);

data = load('2017.12.19_09.32.33_test_10k_Samples4V_10000samp_YVelo.mat');
deviation(data.data_full_y);

data = load('2017.12.19_09.32.33_test_10k_Samples4V_10000samp_ZVelo.mat');
deviation(data.data_full_z);