plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread_new(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, Nb); % Force at midpoint
[force_wall, X2] = ForceWall(XX2, WALL_STIFFNESS, PERFECT_WALL, u, XX, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h, FRICTION_ADJUST, wall_links, links, SLIP_LENGTH);
max_wall_penalty = max(vecnorm((PERFECT_WALL - XX2)'));
if max_wall_penalty > h*.3
  warning('warn');
  disp('Wall penalty exceeds h*.3!');
  disp(max_wall_penalty / (h*.3));
end
ff2 = vec_spread_new(force_wall, XX2, Nb2); % Force at midpoint
YY4 = Y4 + V4 * dt;
[max_X_minus_Y, t] = max(vecnorm((YY4 - XX4)'));
if max_X_minus_Y > h/10
  warning('warn');
  disp('MAX|X - Y| exceeds h/10!');
  disp(YY4(t, :) - XX4(t, :));
  % display(max_X_minus_Y);
  % display(h);
end
force4 = forcePib(YY4 - XX4, pIB_STIFF);
force4_g = force4;
force4_g(:, 1) = force4_g(:, 1) - MASS_PER_POINT * big_G;
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
if any(isnan(total_ff), 'all')
  error('NAN detected');
end
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% full step using midpoint velocity
surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X2 = X2 + dt * vec_interp(uu, X2, Nb2); % cannot be XX2 because forceWall alters X2
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
X4 = X4 + dt * vec_interp(uu, XX4, Nb4);
surfaceResample();
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
