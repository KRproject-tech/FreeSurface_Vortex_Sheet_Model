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

%% load
load ./save/NUM_DATA


%% plot


%%[0] animation
i_ax = 1;

h_fig(1) = figure(1);
set( h_fig(1), 'Position', [ 100 100 800 800])
h_ax(i_ax) = axes( 'Parent', h_fig(1), 'FontSize', 15);

h_plot(1) = patch( [ h_x(1,1) h_x(1,:) h_x(1,end) h_x(1,1)], [-1000 h_y(1,:) -1000 -1000], 'b', 'LineWidth', 1, 'Parent', h_ax(i_ax));
axis( h_ax(i_ax), 'equal')
xlabel( h_ax(i_ax), '{\itx} [m]', 'FontSize', 30, 'FontName', 'Times New Roman') 
ylabel( h_ax(i_ax), '{\ity} [m]', 'FontSize', 30, 'FontName', 'Times New Roman')

set( h_ax(i_ax), 'FontName', 'Times New Roman')

h_txt(1) = text( 0, 4.5, [ 'Time: ', num2str( 0, '%0.2f'), ' [s]'], 'BackgroundColor', 'g',...
                      'FontSize', 25, 'FontName', 'Times New Roman');


i_time = 1;
for time = time_m
    
    disp( [ 'Time: ', num2str( time, '%0.2f'), ' [s]'])
    
    set( h_plot(1), 'XData',  [ h_x(1,1) h_x(i_time,:) h_x(1,end) h_x(1,1)], 'YData', [-1000 h_y(i_time,:) -1000 -1000])
    set( h_txt(1), 'String', [ 'Time: ', num2str( time, '%0.2f'), ' [s]'])
    xlim( h_ax(i_ax), [ -10 10])
    ylim( h_ax(i_ax), [ -10 10])
    drawnow
    
    v.frames(i_time) = getframe( h_fig(1));
    v.times(i_time) = time; % display at 30fps
    
    i_time = i_time + 1;
end
v.width=size( v.frames(1).cdata, 2);
v.height=size( v.frames(1).cdata, 1);


i_ax = i_ax + 1;




%%[1] vorticity

norm_ds_v = norm_ds( h_z_v_time(length( time_m),:).');
s_vec = cumsum( norm_ds_v);

h_fig(2) = figure(2);
set( h_fig(2), 'Position', [ 100 100 1000 500])
h_ax(i_ax) = axes( 'Parent', h_fig(2), 'FontSize', 15);

plot( h_ax(i_ax), s_vec, h_gamma(end,:))
xlabel( h_ax(i_ax), '{\its} [m]', 'FontSize', 20, 'FontName', 'Times New Roman') 
ylabel( h_ax(i_ax), '{\it\gamma} [m/s]', 'FontSize', 20, 'FontName', 'Times New Roman')
xlim( h_ax(i_ax), [ 0 s_vec(end)])

i_ax = i_ax + 1;




%%[2] Stream lines

xv = linspace( -10, 10, 100);
yv = linspace( -10, 10, 100);

[ Xmat, Ymat] = meshgrid( xv, yv);
Zmat = Xmat + 1i*Ymat;

z_v = h_X_v_time(end,1:N);
gamma_v = h_X_v_time(end,N+1:end);

W_surf_v = W_surf( Zmat, gamma_v.', z_v.');
W_total_v = W_surf_v;

Phi_v = imag( W_total_v);





h_fig(3) = figure(3);
set( h_fig(3), 'Position', [ 100 100 800 800])
h_ax(i_ax) = axes( 'Parent', h_fig(3), 'FontSize', 15);

patch( [ h_x(end,1) h_x(end,:) h_x(end,end) h_x(end,1)], [-1000 h_y(end,:) -1000 -1000], 'b', 'LineWidth', 1, 'Parent', h_ax(i_ax));
axis( h_ax(i_ax), 'equal')
xlabel( h_ax(i_ax), '{\itx} [m]', 'FontSize', 30, 'FontName', 'Times New Roman') 
ylabel( h_ax(i_ax), '{\ity} [m]', 'FontSize', 30, 'FontName', 'Times New Roman')
xlim( h_ax(i_ax), [ -10 10])
ylim( h_ax(i_ax), [ -10 10])
hold( h_ax(i_ax), 'on')

contour( xv, yv, Phi_v, 50, 'r');
    
set( h_ax(i_ax), 'FontName', 'Times New Roman')



i_ax = i_ax + 1;



%% save

fig_name = { 'behavior', 'vorticity', 'stream_lines'};

for ii = 1:length( h_fig)
   saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.fig']) 
end


mmwrite( './save/data.wmv', v);



%% Finish
warndlg( 'Finish!')
