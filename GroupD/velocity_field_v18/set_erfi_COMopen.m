function set_erfi_COMopen(s,vol)
    if vol > 10.5         %safety controll
        error('To high volatage level!!! Max 10V!!');
    end
    
    Amp = 0.5;  %set maximum Ampere
    
    %init power supply
    fprintf(s,'#01108250');
    rep = fscanf(s);
    if (rep(5) == 'O' && rep(6) == 'K')
        %disp('Power supply at channel 1 set to remote control!')
    else
        disp('Error!! Try again or write a better programm!')
        error('Ähhh')
    end
    
    %---------------string generetaion----------------
    a = num2str(Amp*1000);
    v = num2str(vol*10);
    
    %a needs to have 5 digits
    while length(a) < 5
        for j=length(a):(-1):1
            a(j+1)=a(j);
        end
        a(1)='0';
    end
       
            
    %v needs to have 4 digits
    while length(v) < 4
        for j=length(v):(-1):1
            v(j+1)=v(j);
        end
        v(1)='0';
    end
    %string without checksum
    str = ['#01102' v a];       %check manual for more details about commands
    
    %Building Checksum
    strCS = erfi_CS(str);
    
    %----------------write erfi----------------
    fprintf(s,strCS);
    rep = fscanf(s);
    if (rep(5) == 'O' && rep(6) == 'K')
        disp(['Power supply at channel 1 set to ' num2str(vol) 'V !'])
    else
        disp('Error!! Try again or write a better programm!')
        error('Ähhh')
    end
    
    %get confirmation
    pause(1);
    fprintf(s,'#01104246')
    rep = fscanf(s);
    vo = str2num(rep(5:8))/10;
    am = str2num(rep(9:13))/1000;
    %disp(['Voltage at Power supply channel 1 is currently ' num2str(vo) 'V !']);
    
end