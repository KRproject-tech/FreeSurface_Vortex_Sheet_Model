function out = W_surf( Zmat, gamma, z_surf)

N_Y = size( Zmat, 1);
Zv = reshape( Zmat, [], 1);


Zvmat = Zv*ones(1,length( z_surf));

norm_ds_v = norm_ds( z_surf);


gamma_ds_mat = ones(length( Zv), 1)*(gamma.*norm_ds_v).';
z_surf_mat = ones(length( Zv), 1)*z_surf.';

W_surf_mat = 1/(1i*2*pi)*gamma_ds_mat.*log( Zvmat - z_surf_mat);
W_surf_mat = sum( W_surf_mat, 2);


out = reshape( W_surf_mat, N_Y, []); 

end
