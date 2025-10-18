function set0_Trav(s2,xC,yC,zC,speed)

    sp = int2str(speed);
    xS = int2str(xC);
    yS = int2str(yC);
    zS = int2str(zC);    
    
    disp('Moving to start coordinates!')
    par = ['@0M ' xS ',' sp ',' yS ',' sp ',' zS ',' sp ',0,' sp];
    fprintf(s2,par);
    confirm(s2);
    
    disp('Attempting to set start coordinates as origin!')
    fprintf(s2,'@0n7');
    confirm(s2);
    
    disp('New origin set!')
    
    


end
