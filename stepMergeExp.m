plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, dtheta, Nb); % Force at midpoint
YY4 = Y4 + V4 * dt;
force4 = forcePib(YY4 - XX4, pIB_STIFF);
ff4 = vec_spread( ...
  force4, ...
  XX4, dtheta4, Nb4 ...
);
V4 = V4 - force4 * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff4;
% total_ff = ff;
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
surfaceResample();
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render;
