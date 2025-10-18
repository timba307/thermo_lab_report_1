function [x,y,z] = grid_Gen(x_start,y_start,z_start,x_end,y_end,z_end,x_step,y_step,z_step)   

delta_x = x_end - x_start;
delta_y = y_end - y_start;
delta_z = z_end - z_start;


x_stN = delta_x/x_step;
y_stN = delta_y/y_step;
z_stN = delta_z/z_step;


x(1)=0;
for i=2:x_stN+1
    x(i)=x(i-1)+x_step;
end

y(1)=0;
for i=2:y_stN+1
    y(i)=y(i-1)+y_step;
end

z(1) = 0;
for i=2:z_stN+1
    z(i)=z(i-1)+z_step;
end

end