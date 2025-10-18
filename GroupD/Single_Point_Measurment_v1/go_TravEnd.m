function go_TravEnd(s2,xC,yC,zC,speed)

    sp = int2str(speed);
    xS = int2str(xC);
    yS = int2str(yC);
    zS = int2str(zC);    
    
    disp('Moving to stop coordinates!')
    par = ['@0M ' xS ',' sp ',' yS ',' sp ',' zS ',' sp ',0,' sp];
    fprintf(s2,par);
    confirm(s2);
    
    disp('End point reached!')
    
end
