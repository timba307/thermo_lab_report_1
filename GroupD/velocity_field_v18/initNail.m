%-------------------TRAVERSE SETUP---------------------------------------------------------

%Traverse parameter
    %comunication
COM_number_T = 'COM1';      %specifiy where the traverse is plugged in options: COM1, COM2
br_T = 9600;                %boudrate of the Traverse

    %moving
speed = 1000;               %steps per second

mmPst = 0.0125;             %mm/step

%Grid parametrers
x_start =1.25*27;              %mm
y_start =1.25*20.12;               %mm
z_start =1.25*86.16;              %mm

x_end = 0;                %mm
y_end = 300;                %mm
z_end = 289;                %mm


x_step = 10;                 %mm
y_step = 10;                 %mm
z_step = 10;                 %mm

%---------------------INITIALIZE TRAVESE-----------------------------

%Setup the Traverse serial conection

s2 = set_COM(COM_number_T,br_T);           %create serial object

%initialice Traverse
init_Trav(s2);

%set new origin
set0_Trav(s2,x_start/mmPst,y_start/mmPst,z_start/mmPst,3000);


%-----------------moving Traverse & temperature check---------
    sp = int2str(speed);
    xC = int2str(x(i));
    yC = int2str(y(j));
    zC = int2str(z(k));
    
    par = ['@0M ' xC ',' sp ',' yC ',' sp ',' zC ',' sp ',0,' sp];
    fprintf(s2,par);
    
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
    
    %confirm from isel    
    confirm(s2);                %get confirmation from isel