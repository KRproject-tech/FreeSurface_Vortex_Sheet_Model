function dt_X = int_K_func( t, X_v, var_param)

disp( t)




%% parameters

delta_c = var_param.delta_c;

tau_vec = var_param.tau_vec;

g = var_param.g;
A_rho = var_param.A_rho;


N = length( X_v)/2;


z_v = X_v(1:N);
gamma_v = X_v(N+1:end);



%% compute kernel

norm_ds_v = norm_ds( z_v).';
tau_vec_v = tau_vec( z_v).';


z_v = z_v.';

z_mat = z_v(ones(1,N),:).';
dz_mat = z_mat - z_mat.';
abs_dz_h2_mat = abs( dz_mat).^2; 


K_delta = -1i/(2*pi)./dz_mat;
K_delta( logical( eye(N)) ) = 0;
K_delta = K_delta.*( abs_dz_h2_mat./(abs_dz_h2_mat + delta_c^2) );



gamma_ds_mat = ones(N,1)*( gamma_v.'.*norm_ds_v );
K_dGamma_ds_mat = K_delta.*gamma_ds_mat;


%% dt_z_i = u_f = É∞_j^N K(z_i - z'_j)ÅEÉ¡_jÅEÉ¢s_j

dt_z = conj( sum( K_dGamma_ds_mat, 2));



%% ds_uf_É—

ds_uf_tau = cent_diff( dt_z).*conj( tau_vec_v.')./norm_ds_v.';
          

%% dt_uf_É— = Re( {ÅÁconj(dt_K)É¡ds + ÅÁconj(K)dt_É¡ds + ÅÁconj(K)É¡dt_ds}*conj(É—) ) 

%%[0] Re(ÅÁconj(dt_K)É¡ds*conj(É—))
dt_z_mat = dt_z(:,ones(1,N));
dt_dz_mat = dt_z_mat - dt_z_mat.';

dt_K_delta = 1i/(2*pi).*dt_dz_mat./dz_mat.^2;
dt_K_delta( logical( eye(N)) ) = 0;


dt_uf1 = conj( sum( dt_K_delta.*gamma_ds_mat, 2) );
dt_uf1_tau = real( dt_uf1.*conj( tau_vec_v.') );


%%[1] Re(ÅÁconj(K)dt_É¡ds*conj(É—))
ds_tau_mat = ones(N,1)*( norm_ds_v.*conj( tau_vec_v) );
real_K_ds_tau_mat = real( conj( K_delta).*ds_tau_mat );


%%[2] Re(ÅÁconj(K)É¡dt_ds*conj(É—))
dz_vec = cent_diff( z_v.').';
dt_z_vec = cent_diff( dt_z).';
%%[2-1] dt_É¢s = Re( dt_É¢z*conj(É¢z) )/É¢s^2
dt_ds_vec = real( dt_z_vec.*conj( dz_vec) )./( norm_ds_v.^2 );

gamma_dtds_mat = ones(N,1)*( gamma_v.'.*dt_ds_vec );
K_dGamma_dtds_mat = K_delta.*gamma_dtds_mat;
dt_uf2 = conj( sum( K_dGamma_dtds_mat, 2) );

dt_uf2_tau = real( dt_uf2.*conj( tau_vec_v.') );




%% ds(É¡^2)

ds_gamma_h2 = cent_diff( gamma_v.^2)./norm_ds_v.';


dt_gamma = (eye(N) - 2*A_rho*real_K_ds_tau_mat)\(   -gamma_v.*real( ds_uf_tau)...
                                                     + 2*A_rho*( dt_uf1_tau + dt_uf2_tau + 1/8*ds_gamma_h2 )...
                                                     + 2*A_rho*g*imag( tau_vec_v).' );

dt_X = [    dt_z    ; 
            dt_gamma];

end



