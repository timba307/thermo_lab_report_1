function [convT] = look_up()

convT(1) = - 50;
for i=1:2047
    
    convT(i+1)=convT(i)+200/2047;
    
end
