function [std, m] = std_prog(data_full_x, data_full_y, data_full_z)
    % mean and std will be calculated over a window

    len = length(data_full_x);
    mx = zeros(len, 1);
    my = zeros(len, 1);
    mz = zeros(len, 1);
    std = zeros(len, 1);
    for i = 1:len
        window_size = i;

        mx(i) = mean(data_full_x(1:i));
        my(i) = mean(data_full_y(1:i));
        mz(i) = mean(data_full_z(1:i));

        % standard deviation
        %tmp = (data_full(:, :, :, lower:upper) - m(i)).^2;
        %std(i) = sqrt(sum(tmp)/(window_size));
    end

    A = 0.4*0.22; %m^2
    cap = 33 / 3600; %m^3/s
    vx = cap/A;
    %plot(std, 'blue')
    hold on
    plot(data_full_x, 'k')
    plot(mx, 'red')
    plot(my, 'blue')
    plot(mz, 'green')
    plot([0, len], [vx, vx])
    hold off
end