function [s] = set_COM(COM_number,br)
    s = serial(COM_number,'BaudRate',br);
    s.Terminator = 'CR';
    fopen(s);
    if length(instrfind('status','open')) > 0
        display(['Serial port at ',COM_number,' opened succesfully!']);
    else
        display(['Failed to open serial port at ',COM_number,'!']);
    end
end