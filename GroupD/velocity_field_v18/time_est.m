function [over_all_time] = time_est(x,y,z,samp,speed,x_end,y_end,z_end)

    %convert to steps
    global mmPst;

    x = x/mmPst;    %mm to steps
    y = y/mmPst;    %mm to steps 
    z = z/mmPst;    %mm to steps
    x_end = x_end/mmPst;    %mm to steps
    y_end = y_end/mmPst;    %mm to steps
    z_end = z_end/mmPst;    %mm to steps
    
    % Time for Setup
    time_set_end = (x_end + y_end + z_end)*1/(speed);
    time_set_start = (x(length(x)) + y(length(y)) + z(length(z)))*1/(speed);
    time_set = time_set_end + time_set_start;

    % Time estimation
    time_pos = 0.02022*samp;   % time per position
    if (length(x) > 1)
        time_move_x = x(length(x))*1/(speed);
    else
        time_move_x = 0;
    end
    if (length(y) > 1)
        time_move_y = length(x)*y(length(y))*1/(speed);
        
    else
        time_move_y = 0;
    end
    if (length(z) > 1)
        time_move_z = length(x)*length(y)*z(length(z))*1/(speed);
    else
        time_move_z = 0;
    end
    
    points = length(x)*length(y)*length(z);     %# of Points
    engTime = 1;    %time till Traverse is engaged in s
    time_move = (time_move_x+time_move_y+time_move_z)+points*engTime+time_set;
    positions = length(x)*length(y)*length(z);
    over_all_time = (time_pos)*positions + time_move + 6.85;
    over_all_time_num = secs2hms(over_all_time);
    
    disp(['Over all time Approx: ' over_all_time_num])
    
end