function [vd sdtvd] = bound_Check(s1) %function to measure the distance to the bottom (z Axes)
%wait to zero
wait_to0(s1);

for  i=1:10
    fprintf(s1,'boundary')

    while 8 >= s1.BytesAvailable
    end
    
    d = fread(s1,8);
    d = char(d');

    while 10 >= s1.BytesAvailable
    end
    d = fread(s1,12);
    s(i) = str2num(char(d'));

    while 11 >= s1.BytesAvailable
    end
    d = fread(s1,11);
    v(i) = str2num(char(d'));

    wait_to0(s1);

end

vd = mean(v)/100;
sdtvd = std(v)/100;

disp(['Distance to the bottom: ' num2str(vd) 'm']);

end
