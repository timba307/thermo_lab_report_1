% returns data_field(:,:,:,1:12) where 
%data_field(:,:,:,1)   gives the x position of the volume in mm
%data_field(:,:,:,2)   gives the y position of the volume in mm
%data_field(:,:,:,3)   gives the z position of the volume in mm
%data_field(:,:,:,4)   gives the velocity in x direction in cm/s
%data_field(:,:,:,5)   gives the velocity in y direction in cm/s
%data_field(:,:,:,6)   gives the velocity in z direction in cm/s
%data_field(:,:,:,7)   gives the standard deviation of the velocity in x
%data_field(:,:,:,8)   gives the standard deviation of the velocity in y
%data_field(:,:,:,9)   gives the standard deviation of the velocity in z
%data_field(:,:,:,10)  returns the reading errors in %
%data_field(1,1,1,11)  returns the distance to bottom of the volume
%data_field(1,1,1,12)  returns the standard deviation of the distance
%data_field(1,1,1,13)  returns the Temperature


function move_Trav(s1,s2,x,y,z,speed,i,j,k,samp)
    
    %-----------------temperature check---------
        
    %read Temperature and check the necessity of update
    global tT;             %temperature measurment timeinterval variable
    global Ts;
    T = Ts;
    if toc(tT) >= 30*60               %Measure Temperature every 30 Minutes
        tT =tic;                       %restart timer
        T = read_Temp();            %Read Temeperatur returns Temperarature in °C
        Ts = T;
        what = 'Temp ';                %provide command for temp update leave blank at the end!!
        write_ADV(s1,what,num2str(T));         %set temperatur
    end
    
    
    %----------------calculate position----------------
    xC=0;
    yC=0;
    zC=0;
    
    pos = [0 0 0];
    
    %--------one time distance to bottom--------------
    if ((i == 1) && (j == 1) && (k == 1))
        disp('One time measurement of the distance to the bottom');
        [vd sdtvd] = bound_Check(s1);
    else
        global data_field;
        vd = data_field(1,1,1,11)-pos(3);
        sdtvd = data_field(1,1,1,12);
    end
    
    %--------Starting data aquisition--------------
    disp(['Starting data aquisition at point x:' int2str(xC) 'mm y:' int2str(yC) 'mm z:' int2str(zC) 'mm !']);
    
    global data_field;
    a = aquire(s1,samp);
    data_field(i,j,k,:) = [pos a vd sdtvd T];
    
    global full_x;
    global full_y;
    global full_z;
    global data_full_x;
    global data_full_y;
    global data_full_z;
    data_full_x(i,j,k,:)=full_x;
    data_full_y(i,j,k,:)=full_y;
    data_full_z(i,j,k,:)=full_z;
    
    
    %---------Show & Save results----------------
    disp(num2str(data_field(i,j,k,4:6)))
    disp(['Successful data aquisition!'])
    
    save('Temp.mat', 'data_field')
    
end
