plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
XX2(1, :) = NAILS(1, :);
XX2(end, :) = NAILS(2, :);
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
[force_tension, wall_pull] = ForceSurface(XX, links, dtheta, K, wall_links, Nb, XX2, WALL_LINK_STIFF, Nb2);
ff = vec_spread_new(force_tension, XX, Nb); % Force at midpoint
[force_wall, X2] = ForceWall(XX2, WALL_STIFFNESS, u, XX, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h, FRICTION_ADJUST, wall_links, links, SLIP_LENGTH, kp, km, dtheta2);
ff2 = vec_spread_new(force_wall + wall_pull, X2, Nb2); % Force at midpoint
YY4 = Y4 + V4 * dt;
[max_X_minus_Y, t] = max(vecnorm((YY4 - XX4)'));
if max_X_minus_Y > h/6
  disp('MAX|X - Y| exceeds h/6!');
  disp(YY4(t, :) - XX4(t, :));
  % display(max_X_minus_Y);
  % display(h);
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

% damping_mask = exp(min(0, dot(ff2, u, 3) * MEMBRANE_DAMP));
% dp = dot(ff2, u, 3);
% ttt = sort(dp(:));
% tttt = sort(ttt(1:end*.01));
% hold off;
% histogram(tttt(end*.1:end), 20);
% image(damping_mask * 255);
% drawnow;
% fprintf("t=%f\n",clock * dt);
% ff2 = ff2 .* damping_mask;
total_ff = ff + ff2 + ff4;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% full step using midpoint velocity
surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X2 = X2 + dt * vec_interp(uu, X2, Nb2); % cannot be XX2 because forceWall alters X2
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
X4 = X4 + dt * vec_interp(uu, XX4, Nb4);
X2(1, :) = NAILS(1, :);
X2(end, :) = NAILS(2, :);
surfaceResample();
surfaceResample();  % Doing only once may leave 1-node interface
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
