plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread(ForceSurface(XX, links, dtheta, K, wall_links, Nb), XX, dtheta, Nb); % Force at midpoint
[force_wall, X2] = ForceWall(XX2, WALL_STIFFNESS, PERFECT_WALL, u, XX, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h, FRICTION_ADJUST, wall_links, links, SLIP_LENGTH);
ff2 = vec_spread(force_wall, XX2, dtheta2, Nb2); % Force at midpoint
YY4 = Y4 + V4 * dt;
force4 = forcePib(YY4 - XX4, pIB_STIFF);
force4_g = force4;
force4_g(:, 2) = force4_g(:, 2) + MASS_PER_POINT * big_G;
ff4 = vec_spread( ...
  force4, ...
  XX4, dtheta4, Nb4 ...
);
V4 = V4 - force4_g * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff2 + ff4;
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity
% vertical flow
u (2:N/2,          end  , 2) = VERTICAL_FLOW_ROW;
uu(2:N/2,          end  , 2) = VERTICAL_FLOW_ROW;
u (2:N/2,          end-1, 2) = VERTICAL_FLOW_ROW;
uu(2:N/2,          end-1, 2) = VERTICAL_FLOW_ROW;
u (end-1:-1:N/2+1, end  , 2) = VERTICAL_FLOW_ROW;
uu(end-1:-1:N/2+1, end  , 2) = VERTICAL_FLOW_ROW;
u (end-1:-1:N/2+1, end-1, 2) = VERTICAL_FLOW_ROW;
uu(end-1:-1:N/2+1, end-1, 2) = VERTICAL_FLOW_ROW;

X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
X2=X2+dt*vec_interp(uu, X2, Nb2); % full step using midpoint velocity
X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
surfaceResample();
warpIndicators;

render;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
