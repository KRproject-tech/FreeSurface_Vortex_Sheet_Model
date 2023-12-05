clc
clear all
close all

%% delete
delete( '*.asv')

%% path
add_pathes

%% parameter
param_setting

%% multi threading
maxNumCompThreads( core_num);


%% ‰ğÍŠÔ•]‰¿

if speed_check_flag
    profile on;
end


%% exe

[ time, h_X_v] = ode113( @( t, X_v)int_K_func( t, X_v, var_param), [ 0 End_Time], X_v0);

h_X_v_time = interp1( time, h_X_v, time_m);

h_z_v_time = h_X_v_time(:,1:N);

h_x = real( h_z_v_time);
h_y = imag( h_z_v_time);

h_gamma = h_X_v_time(:,N+1:end);


if speed_check_flag
    profile viewer;
end


%% save 

save ./save/NUM_DATA


%% Finish

warndlg( 'Finish!')