function [log] = confirm(s2)

    
    while s2.BytesAvailable == 0;
    end
    
    a = char(fread(s2,s2.BytesAvailable));
    disp(['Response: ' a])
    
    if a == '0'
        log = 1;
    else
        log = 0;
        error('Error in isel Traverse!');
    end
    
    

end