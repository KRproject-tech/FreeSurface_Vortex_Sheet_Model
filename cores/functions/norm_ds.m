function out = norm_ds( z)


d_s =  diff( z);

out = [	abs( d_s(1) )                               	;
      	abs( d_s(1:end-1) )/2 + abs( d_s(2:end) )/2     ;
        abs( d_s(end) )                                 ];

end

