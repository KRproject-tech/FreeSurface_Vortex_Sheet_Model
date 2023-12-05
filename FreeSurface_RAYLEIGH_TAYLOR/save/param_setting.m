%% parameters


%% 設定
speed_check_flag = 0;                                                       %% 解析時間評価 



%% 解析条件
End_Time = 18;                                                              %% 解析時間 [s]
core_num = 8;                                                               %% CPU数 [-]



time_m = 0:5e-2:End_Time;

N = 2000;                                                                   %% 渦層離散点数 [-]


alpha_vec = linspace( -10, 10, N);                                        	%% 渦層正規化座標 [-]
x_v0 = alpha_vec;                                                        	%% 渦層座標 [m]
% y_v0 = -exp( -alpha_vec.^2);                                          	%% 渦層座標 [m]
y_v0 = 0.2*sin( 2*pi*alpha_vec/5).*exp( -0.05*alpha_vec.^2);               	%% 渦層座標 [m]
% y_v0 = 1./( 1 + exp( -alpha_vec) );                                         %% 渦層座標 [m]


z_v0 = (x_v0 + 1i*y_v0).';


ds_vec = @( z)cent_diff( z);                                                %% 弧長の微小増分 [m]
tau_vec = @( z)( ds_vec( z)./abs( ds_vec( z) ) );                           %% 接線ベクトル [-]

delta_c = 1e-1;                                                             %% 平滑化パラメータ [m]

gamma_v0 = zeros(N,1);


%% 物性

g = 9.80665;                                                               	%% 重力加速度 [m/s^2]
rho_1 = 1.02*1000;                                                                %% 密度1 [kg/m^3]
rho_2 = 1000;                                                               %% 密度2 [kg/m^3]    
A_rho = (rho_1 - rho_2)/(rho_1 + rho_2);                                    %% 密度パラメータ [-]


X_v0 = [    z_v0    ; 
            gamma_v0];


%% global 変数
global var_param


var_param.alpha_vec = alpha_vec;
var_param.delta_c = delta_c;

var_param.ds_vec = ds_vec;
var_param.tau_vec = tau_vec;

var_param.g = g;
var_param.A_rho = A_rho;
