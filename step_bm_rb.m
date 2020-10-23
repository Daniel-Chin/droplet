plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
XX5 = X5 + (dt/2) * vec_interp(u, X5, Nb5); % Euler step to midpoint
ff=vec_spread_new(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, Nb); % Force at midpoint
force_wall = ForceWall_noslip(XX2, WALL_STIFFNESS, PERFECT_WALL);
ff2 = vec_spread_new(force_wall, XX2, Nb2); % Force at midpoint
YY4 = Y4;
YY4 = Y4 + V4 * dt;
[max_X_minus_Y, t] = max(vecnorm((YY4 - XX4)'));
if max_X_minus_Y > h/10
  display(YY4(t, :) - XX4(t, :));
  % display(max_X_minus_Y);
  % display(h);
  warning('MAX|X - Y| exceeds h/10!');
end
force4 = forcePib(YY4 - XX4, pIB_STIFF);
force4_g = force4;
force4_g(:, 2) = force4_g(:, 2) + MASS_PER_POINT * big_G;
ff4 = vec_spread_new( ...
  force4, ...
  XX4, Nb4 ...
);
V4 = V4 - force4_g * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff2 + ff4;
mirrored = total_ff .* MIRROR;
total_ff(1, :, :) = total_ff(1, :, :) + mirrored(1, :, :);
total_ff(2:end, :, :) = total_ff(2:end, :, :) + mirrored(end:-1:2, :, :);
% disp('syme');
% left_ff = total_ff(1 : N/2+1, :, :);
% syme = left_ff - left_ff(end:-1:1, :, :) .* MIRROR;
% disp(sum(abs(syme), 'all'));
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% u (1,   2:N-1, 1) = 0;
% uu(1,   2:N-1, 1) = 0;
% u (N/2, 2:N-1, 1) = 0;
% uu(N/2, 2:N-1, 1) = 0;

% full step using midpoint velocity
surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X2 = X2 + dt * vec_interp(uu, X2, Nb2); % cannot be XX2 because forceWall alters X2
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
X4 = X4 + dt * vec_interp(uu, XX4, Nb4);
X5 = X5 + dt * vec_interp(uu, XX5, Nb5);
surfaceResample();
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

if mod(clock, 50) == 0
  disp('t');
  disp(clock * dt);
  disp('CM');
  disp(CM_his(end));
  disp('circularity');
  disp(circularity_his(end));
end
% return;
render_bm_rb;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
