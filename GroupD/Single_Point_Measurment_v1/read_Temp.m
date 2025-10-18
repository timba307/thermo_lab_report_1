%returns the Temperature in °C

function [T] = read_Temp()

    disp('Reading Temperature')

    global look;
    global s3;
    s = s3;
    
    for i=1:5
        
        wait_to0(s);
        fprintf(s,'@')
        fread(s,2);
        se1 = fread(s,4);
        fread(s,1);
        se2 = fread(s,4);
        fread(s,1);
        se3 = fread(s,4);
        fread(s,1);
        se4 = fread(s,4);
        wait_to0(s);

        raw = hex2dec(char(se1)');
        Temp(i) = look(raw+1);        
        
    end
    T = round(mean(Temp)*10)/10;         %round on 2 decimals
    
    disp(['Current Water temperature: ' num2str(T) '°C']);
end