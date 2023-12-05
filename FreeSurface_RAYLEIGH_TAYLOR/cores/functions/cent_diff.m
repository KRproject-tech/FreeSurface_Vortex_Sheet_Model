function out = cent_diff( x)


    
out = [	x(2) - x(1)                 ; 
        ( x(3:end) - x(1:end-2) )/2 ;                                   %% 2Ÿ¸“x
        x(end) - x(end-1)           ];
        
    
% out = [	x(2) - x(1)                 ; 
%         ( x(3) - x(1) )/2           ;
%         ( 8*(x(4:end-1) - x(2:end-3)) - (x(5:end) - x(1:end-4)) )/12;   %% 4Ÿ¸“x
%         ( x(end) - x(end-2) )/2     ; 
%         x(end) - x(end-1)           ];         

end

