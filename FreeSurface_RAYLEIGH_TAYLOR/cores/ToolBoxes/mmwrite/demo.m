clc
clear all
close all hidden

%% delete
delete( '*.asv')


%% generate *.wmv file


% make a movie ourselves...
h_fig = figure(1);
set( h_fig, 'render', 'zbuffer', 'Position', [ 100 100 800 700])

h_ax = axes( 'Parent', h_fig);




%% plot
time_m = linspace( 0, 5, 100);

[ X, Y] = meshgrid( -5:2e-1:5);
h_plot = surf( X, Y, peaks( X, Y));
xlabel( '\itX', 'FontSize', 20, 'FontName', 'Times New Roman')
ylabel( '\itY', 'FontSize', 20, 'FontName', 'Times New Roman')
zlabel( '\itZ', 'FontSize', 20, 'FontName', 'Times New Roman')
axis( h_ax, 'image')
light 
lighting phong



%% animation
i_time = 1;
for time = time_m
    
    set( h_plot, 'FaceColor', [ (sin( 2*pi*time/5) + 1)/2 (-sin( 2*pi*time/5) + 1)/2 (cos( 2*pi*time/5) + 1)/2])
    view( h_ax, [ sin( 2*pi*time/10) cos( 2*pi*time/10) -sin( 2*pi*time/10)])
    v.frames(i_time) = getframe( h_fig);
    v.times(i_time) = i_time/30; % display at 30fps

    i_time = i_time + 1;
end
v.width=size( v.frames(1).cdata, 2);
v.height=size( v.frames(1).cdata, 1);

close( h_fig);




%% save
mmwrite( 'data.wmv', v);
movie2avi( v.frames, 'data.avi', 'fps', 30)

%% Finish
warndlg( 'Finish!')



