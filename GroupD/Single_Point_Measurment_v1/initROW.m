clc;
clear all;
reset_COM()

%open for erfi power supply
COM_number = 'COM3';                %specifiy where the erfi Power Supply is plugged in
br = 9600;                        %boudrate of Power Supply
s = set_COM(COM_number,br);

samp =  [10000];
Volt =  [5];

VR =    [2];
if length(Volt) ~= length(VR) && length(Volt) ~= length(samp)
    error('Unequal length of settings!')
end

for i=1:length(Volt)
%     set_erfi_COMopen(s,10);       %Wirl up seeding
%     disp('Whirling up the seeding for 30sec!')
%     pause(30);%30
    set_erfi_COMopen(s,Volt(i));
    disp('Wait until system is engaged 60sec!')
    %pause(60);
    init_ADVonly(VR(i),samp(i),['test_10k_Samples' num2str(Volt(i)) 'V']);   %Change Name of File here!
end

disp('Shuting down pump!')
set_erfi_COMopen(s,0);       %Shutdown Pump

disp('Sequence finished!')

reset_COM()
