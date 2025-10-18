function [std, m] = std_n(data_full, window_dist)
    % mean and std will be calculated over a window

    len = length(data_full(1,1,1,:));
    m = zeros(len, 1);
    std = zeros(len, 1);
    for i = 1:len
        lower = max(1, i-window_dist);
        upper = min(len, i+window_dist);

        window_size = upper-lower +1;

        m(i) = sum(data_full(:, :, :, lower:upper));
        m(i) = m(i) / (window_size);

        % standard deviation
        tmp = (data_full(:, :, :, lower:upper) - m(i)).^2;
        std(i) = sqrt(sum(tmp)/(window_size));
    end


    plot(std, 'blue')
    hold on
    plot(m, 'red')
    hold off
end