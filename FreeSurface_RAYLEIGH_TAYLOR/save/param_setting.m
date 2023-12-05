%% parameters


%% �ݒ�
speed_check_flag = 0;                                                       %% ��͎��ԕ]�� 



%% ��͏���
End_Time = 18;                                                              %% ��͎��� [s]
core_num = 8;                                                               %% CPU�� [-]



time_m = 0:5e-2:End_Time;

N = 2000;                                                                   %% �Q�w���U�_�� [-]


alpha_vec = linspace( -10, 10, N);                                        	%% �Q�w���K�����W [-]
x_v0 = alpha_vec;                                                        	%% �Q�w���W [m]
% y_v0 = -exp( -alpha_vec.^2);                                          	%% �Q�w���W [m]
y_v0 = 0.2*sin( 2*pi*alpha_vec/5).*exp( -0.05*alpha_vec.^2);               	%% �Q�w���W [m]
% y_v0 = 1./( 1 + exp( -alpha_vec) );                                         %% �Q�w���W [m]


z_v0 = (x_v0 + 1i*y_v0).';


ds_vec = @( z)cent_diff( z);                                                %% �ʒ��̔������� [m]
tau_vec = @( z)( ds_vec( z)./abs( ds_vec( z) ) );                           %% �ڐ��x�N�g�� [-]

delta_c = 1e-1;                                                             %% �������p�����[�^ [m]

gamma_v0 = zeros(N,1);


%% ����

g = 9.80665;                                                               	%% �d�͉����x [m/s^2]
rho_1 = 1.02*1000;                                                                %% ���x1 [kg/m^3]
rho_2 = 1000;                                                               %% ���x2 [kg/m^3]    
A_rho = (rho_1 - rho_2)/(rho_1 + rho_2);                                    %% ���x�p�����[�^ [-]


X_v0 = [    z_v0    ; 
            gamma_v0];


%% global �ϐ�
global var_param


var_param.alpha_vec = alpha_vec;
var_param.delta_c = delta_c;

var_param.ds_vec = ds_vec;
var_param.tau_vec = tau_vec;

var_param.g = g;
var_param.A_rho = A_rho;
