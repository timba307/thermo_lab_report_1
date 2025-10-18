function [strCS] = erfi_CS(str)
    cs = 0;
    for i=2:length(str)
        cs = cs + double(str(i));
    end
    Cs = num2str(cs); %Limit to 3 digits
    if length(Cs) > 3
        CS(3) =  strS(length(Cs));
        CS(2) =  strS(length(Cs)-1);
        CS(1) =  strS(length(Cs)-2);
    else
        CS=Cs;
    end
        
    %string
    strCS = [str CS];
end