function grid_walker(s1,s2,x,y,z,speed,samp)

    global mmPst;
    
    x = x/mmPst;    %mm to steps
    y = y/mmPst;    %mm to steps 
    z = z/mmPst;    %mm to steps
        
    %Walk the Grid Grid
    disp('Starting sequence!');

    for i=1:length(x)
        if mod(i,2) == 0    %i is even
            for j=length(y):(-1):1
                if mod(j,2) == 0    %j is even
                    for k=1:length(z)
                        move_Trav(s1,s2,x,y,z,speed,i,j,k,samp);
                        
                    end
                else                %j is odd
                    for k=length(z):(-1):1
                        move_Trav(s1,s2,x,y,z,speed,i,j,k,samp);
                        
                    end
                end
            end
        else                %i is odd
            for j=1:length(y)
                if mod(j,2) == 0    %j is even
                    for k=length(z):(-1):1
                        move_Trav(s1,s2,x,y,z,speed,i,j,k,samp);
                        
                    end
                else                %j is odd
                    for k=1:length(z)
                        move_Trav(s1,s2,x,y,z,speed,i,j,k,samp);
                        
                    end
                end
            end    
        end
    end
    
    fprintf(s1,'PowerOff');
    fprintf(s2,'@0R7');             %Moves Traverse to initial position
    disp('Grid finished to walk!')
end
