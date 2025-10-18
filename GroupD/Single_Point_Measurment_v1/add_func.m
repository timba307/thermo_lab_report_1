function [mean,sigma,n,squared_diff,sigma_squared] = add_func(x_n,n,mean,squared_diff)
    n = n+ 1;
    old_mean = mean;
    mean = mean+(x_n - mean)/n;
    squared_diff = squared_diff+ (x_n - old_mean).*(x_n - mean);
    sigma_squared = squared_diff/(n);
    sigma = sigma_squared^0.5;
end

