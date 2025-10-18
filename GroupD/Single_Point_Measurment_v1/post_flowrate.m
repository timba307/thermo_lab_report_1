%returns the flowrate in m^3/s

function [flowrate] = post_flowrate(data,pla)
    dy = data(1,2,1,2)-data(1,1,1,2);
    dz = data(1,1,2,3)-data(1,1,1,3);
    flowrate= 0 ;
    
    maxi = max(max(data(:,:,:,4)));
    
    for j=1:length(data(1,:,1,1))
        for k=1:length(data(1,1,:,1))
            if data(pla,j,k,4) > 0.01*maxi;
                flowrate = flowrate + dy*dz*data(pla,j,k,4);
            end
        end
    end
end