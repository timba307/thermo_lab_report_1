function init_COMB(VRnum,samp,save_title,x_start,y_start,z_start,x_end,y_end,z_end,x_step,y_step,z_step)
%Programm by Leopold Götsch
%31.01.2011

clear global data_field;
clear global mmPst;
clear global s3;
clear global look;
clear global Ts;
clear global full_x;
clear global full_y;
clear global full_z;
clear global data_full_x;
clear global data_full_y;
clear global data_full_z;
global data_field;
global mmPst;
global s3;
global look;            
global Ts;              %Start Temperature
global tT;              %temperature measurment timeinterval variable
global full_x;
global full_y;
global full_z;
global data_full_x;
global data_full_y;
global data_full_z;

%initialisation file for the ADV & the isel 3 axis
%this file is intened to initialize the isel 3D and messure
%with the ADV

%set counter
start_time = clock;
disp (['Start time: ' datestr(start_time)])

%--------------------------General Settings-----------------------
%save_title = input('Please provide a title for the file to be saved:','s');

%reset COM
%reset_COM();

%--------------Thermometer Setup-------------------------
%Thermometer Parameter
COM_number_T = 'COM8';              %specifiy where the Thermometer is plugged in options: COM1, COM2, COM..
br_T = 9600;                        %boudrate of Thermometer

%initialize Thermometer
s3 = set_COM(COM_number_T,br_T);    %create serial object
look = look_up();                   %Lookup Table for conversion from raw data to temperatur

%-------------------ADV SETUP---------------------------------------------------------

%ADV parameters
COM_number_A = 'COM5';                %specifiy where the ADV is plugged in options: COM1, COM2
br_A = 115200;                        %boudrate of ADV

VR = num2str(VRnum);% = '4';                             % set Veolcity Range
SR = '50.0';                           % set Sampling Rate

%samp=100;                           %samples per position minimum 2

%-------------------INITIALIZE ADV---------------------------------------------------------
%Setup the ADV serial conection
s1 = set_COM(COM_number_A,br_A);    %create serial object

%update Temperature
Ts = read_Temp();                   %Read Temeperatur returns Temperaratur in °C
tT = tic;                           %Start Timeer for temperature measure interval
what = 'Temp ';                     %provide command for temp update leave blank at the end!!
write_ADV(s1,'TempMode ','user');   %change to user defined temp
write_ADV(s1,what,num2str(Ts));     %set temperatur

%update Velocity Range
what = 'VR ';                     %provide command for Velocity Range update leave blank at the end!!
write_ADV(s1,what,VR);            %set Velocity Range

%update Sampling Rate
what = 'SR ';                     %provide command for Sampling Rate update leave blank at the end!!
write_ADV(s1,what,SR);            %set Velocity Range

%update Sampling Rate
what = 'outmode ';                     %provide command for Sampling Rate update leave blank at the end!!
write_ADV(s1,what,'AUTO');            %set Velocity Range


%Check ADV System & Setup

check_ADV(s1);                      %show ADV Settings and allow programm termination


%-------------------TRAVERSE SETUP---------------------------------------------------------

%Traverse parameter
    %comunication
COM_number_T = 'COM6';      %specifiy where the traverse is plugged in options: COM1, COM2
br_T = 9600;                %boudrate of the Traverse

    %moving
speed = 1000;               %steps per second

mmPst = 0.0125;             %mm/step

%---------------------INITIALIZE TRAVESE-----------------------------

%Grid generation
[x,y,z] = grid_Gen(x_start,y_start,z_start,x_end,y_end,z_end,x_step,y_step,z_step); %returns coordinates in mm

%Time issues
time_esti = time_est(x,y,z,samp,speed,x_end,y_end,z_end);     %Time estimation
t1=tic;                         %Start time counter

%Setup the Traverse serial conection

s2 = set_COM(COM_number_T,br_T);           %create serial object

%initialice Traverse
init_Trav(s2);

%Move to End Point for Security
go_TravEnd(s2,x_end/mmPst,y_end/mmPst,z_end/mmPst,1600);

%set new origin
set0_Trav(s2,x_start/mmPst,y_start/mmPst,z_start/mmPst,1600);

%--------------------START------------------------------
%move along grid and take values
grid_walker(s1,s2,x,y,z,speed,samp);

%returns data_field(:,:,:,1:12) where 
%data_field(:,:,:,1)   gives the x position of the volume in m
%data_field(:,:,:,2)   gives the y position of the volume in m
%data_field(:,:,:,3)   gives the z position of the volume in m
%data_field(:,:,:,4)   gives the velocity in x direction in m/s
%data_field(:,:,:,5)   gives the velocity in y direction in m/s
%data_field(:,:,:,6)   gives the velocity in z direction in m/s
%data_field(:,:,:,7)   gives the standard deviation of the velocity in x
%data_field(:,:,:,8)   gives the standard deviation of the velocity in y
%data_field(:,:,:,9)   gives the standard deviation of the velocity in z
%data_field(:,:,:,10)  returns the reading errors in %
%data_field(1,1,1,11)  returns the distance to bottom of the volume
%data_field(1,1,1,12)  returns the standard deviation of the distance
%data_field(1,1,1,13)  returns the Water Temperature


%-----------------Ending Programm-----------------------------


%Store data_field
end_time = clock;
destination = [datestr(end_time, 'yyyy.mm.dd_HH.MM.SS') '_' save_title  '_' num2str(samp) 'samp.mat'];
save(destination, 'data_field')
destination_x = [datestr(end_time, 'yyyy.mm.dd_HH.MM.SS') '_' save_title  '_' num2str(samp) 'samp_XVelo.mat'];
save(destination_x, 'data_full_x')
destination_y = [datestr(end_time, 'yyyy.mm.dd_HH.MM.SS') '_' save_title  '_' num2str(samp) 'samp_YVelo.mat'];
save(destination_y, 'data_full_y')
destination_z = [datestr(end_time, 'yyyy.mm.dd_HH.MM.SS') '_' save_title  '_' num2str(samp) 'samp_ZVelo.mat'];
save(destination_z, 'data_full_z')




%Show time
elapsed_time = toc(t1);
time_array = [start_time time_esti clock elapsed_time];
disp (['End time: ' datestr(end_time)])
disp (['Elapsed time: ' secs2hms(elapsed_time)]) % secs2hms is a mat file from http://www.mathworks.com/matlabcentral/fileexchange/22817-seconds-to-hours-minutes-seconds
save([datestr(end_time, 'yyyy.mm.dd_HH.MM.SS') '_timestamp_' num2str(samp) '.mat'], 'time_array');

%Close all serial conections
confirm(s2);
kill_COM(s1);
kill_COM(s2);
kill_COM(s3);
end