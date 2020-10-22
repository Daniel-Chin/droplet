plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, dtheta, Nb); % Force at midpoint
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
ff4 = vec_spread( ...
  force4, ...
  XX4, dtheta4, Nb4 ...
);
V4 = V4 - force4_g * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff4;
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% full step using midpoint velocity
surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
X4 = X4 + dt * vec_interp(uu, XX4, Nb4);
surfaceResample();
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render_clean;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
