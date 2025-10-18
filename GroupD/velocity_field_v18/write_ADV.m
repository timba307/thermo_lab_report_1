function write_ADV(s,what,val)
    
    serialbreak(s,0.5);
    pause(0.5);
    
    str = [what val];
    fprintf(s,str);
    
    fprintf(s,'savesetup');
    
    wait_to0(s);
 
end