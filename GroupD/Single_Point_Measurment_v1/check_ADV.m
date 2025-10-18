function check_ADV(s1)

    serialbreak(s1,0.5);
    pause(0.5);

    fprintf(s1,'outformat ascii');
    
    fprintf(s1,'show system');
    disp('Please be patient...');    
    fprintf(s1,'show setup');
    pause(0.1);
    
    o1 = fread(s1);
    o2 = char(o1)';
    o1 = fread(s1);
    o3 = char(o1)';
    
    [o2 o3]
    
    inp = 'a'; %= input('Type "a" if you agree with the settings. Type "d" if you disagree.','s');
    if inp == 'a';
        disp('Settings accepted!');
        fprintf(s1,'SaveSetup');
        wait_to0(s1);             %wait till no more bytes to read
        return
    else inp == 'd';
        disp('Please change settings with Sontek utilitys!');
        reset_COM();
        error('ADV Setup settings not approoved!');           
    end
         

end