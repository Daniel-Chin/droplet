plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread_new(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, Nb); % Force at midpoint
YY4 = Y4 + V4 * dt;
[max_X_minus_Y, t] = max(vecnorm((YY4 - XX4)'));
if max_X_minus_Y > h/10
  disp('MAX|X - Y| exceeds h/10!');
  disp(YY4(t, :) - XX4(t, :));
  % display(max_X_minus_Y);
  % display(h);
end
force4 = forcePib(YY4 - XX4, pIB_STIFF);
ff4 = vec_spread_new( ...
  force4, ...
  XX4, Nb4 ...
);
V4 = V4 - force4 * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff4;
mirrored = total_ff .* MIRROR;
total_ff(1, :, :) = total_ff(1, :, :) + mirrored(1, :, :);
total_ff(2:end, :, :) = total_ff(2:end, :, :) + mirrored(end:-1:2, :, :);
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
surfaceResample();
surfaceResample();  % Doing only once may leave 1-node interface
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render;
