function[] = deviation(data)

for i=1:length(data)
    mean_data(i) = mean(data(1:i));
    dev(i) = std(data(1:i));
end

figure;
samples = 1:1:length(data);
plot(samples, dev);
hold on;
plot(samples, mean_data);
grid on;
xlabel('Samples');
ylabel('std/mean');
legend('Deviation','Mean Value');
end