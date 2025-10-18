function reset_COM()

if length (instrfind) > 0       %look for open COM ports
    fclose (instrfind);         %close open COM ports
    delete(instrfind);          %delete serial objects           
    clear instrfind;            %clear serial object from workspace
end
display('All COM ports closed!')
end