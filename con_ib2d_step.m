plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
total_ff=vec_spread(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, dtheta, Nb); % Force at midpoint
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% full step using midpoint velocity
surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
surfaceResample();
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render_clean;
