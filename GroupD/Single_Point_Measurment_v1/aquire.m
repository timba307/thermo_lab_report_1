function [ret] = aquire(s1,samp)
    
    SNR = 15;
    COR = 60;

    fprintf(s1,'Start');
    
    while ~s1.BytesAvailable
    end
    
    good = 0;
    bad = 0;
    i=1;
    
    while i <= samp
        
        idn = fscanf(s1);
        val = str2num(idn);
        
        if length(val)==12
                    
            if  (val(8) > COR) && (val(9) > COR) && (val(10) > COR)
                r(i,:) = val;
                good=good+1;
                i=i+1;
            else
            bad=bad+1;
            end
        end
        
        % [r(i,1) r(i,2) r(i,3)]  % For live view of data
    end
    
    
    
    %Real SNR calculation
    SNR1 = (mean(r(:,5)) - 64)*0.43;
    SNR2 = (mean(r(:,6)) - 64)*0.43;
    SNR3 = (mean(r(:,7)) - 64)*0.43;
    
   
    serialbreak(s1,0.5);
    
    %full
    global full_x;
    global full_y;
    global full_z;
    full_x = r(:,2)/10000;
    full_y = -r(:,3)/10000;              %- due to coordinate transformation!
    full_z = -r(:,4)/10000;             %- due to coordinate transformation!
    
    %veolcity mean
    vx = mean(r(:,2))/10000;              %mean velocity in x direction m/s
    vy = -mean(r(:,3))/10000;              %mean velocity in y direction m/s Add - due to coordinate transformation!
    vz = -mean(r(:,4))/10000;              %mean velocity in z direction m/s Add - due to coordinate transformation!
    
    %velocity standarddeviation
    std_x =std(r(:,2))/10000;             %standarddeviation in x direction in m
    std_y =std(r(:,3))/10000;             %standarddeviation in y direction in m
    std_z =std(r(:,4))/10000;             %standarddeviation in z direction in m
    
    read_error=bad/good*100;        %reading errors in %
    
    ret = [vx,vy,vz,std_x,std_y,std_z,read_error];
    
    wait_to0(s1);           %wait till no more bytes to read
    
end
