function post_3dplot(data,pla)
    Y = data(1,:,1,2); 
    Z = reshape(data(1,1,:,3),1,length(data(1,1,:,3)))';
    X = flipud(rot90(reshape(data(pla,:,:,4),length(data(1,:,1,4)),length(data(1,1,:,4))),1));
    figure()
    surf(Y,Z,X)
    colorbar()
    set(gca,'YDir','normal');
    grid on;
    xlabel('y - position in m');
    ylabel('z - position in m');
end