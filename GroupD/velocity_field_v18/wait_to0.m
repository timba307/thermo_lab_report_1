function wait_to0(s1)
    
    pause(0.5)
    while s1.BytesAvailable
        fread(s1,s1.BytesAvailable);
        pause(0.5)
    end
    
end