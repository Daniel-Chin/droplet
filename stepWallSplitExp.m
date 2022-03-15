plot(0);
hold on;

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread_new(ForceSurface(XX, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF), XX, Nb); % Force at midpoint
[force_wall, X2, force_mcl, place_mcl, n_mcl] = ForceWall(XX2, WALL_STIFFNESS, PERFECT_WALL, u, XX, Nb, Nb2, NO_SLIP_FORCE, X2, h, FRICTION_ADJUST, wall_links, links);
[force_young, place_young] = ForceYoung(u, wall_links, XX, Nb, K, STATIC_CONTACT_ANGLE);
ff2 = vec_spread_new( ...
  force_wall, X2, Nb2 ... 
) + vec_spread_new(force_mcl, place_mcl, n_mcl);
ff5 = vec_spread_new(force_young, place_young, n_mcl);
YY4 = Y4 + V4 * dt;
force4 = forcePib(YY4 - XX4, pIB_STIFF);
force4_g = force4;
for j = 1 : Nb4
  g = MASS_PER_POINT * big_G;
  if YY4(j, 2) > L / 2
    g = - g;
  end
  force4_g(j, 2) = force4_g(j, 2) + g;
end
ff4 = vec_spread( ...
  force4, ...
  XX4, dtheta4, Nb4 ...
);
V4 = V4 - force4_g * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff2 + ff4 + ff5;
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

surface_velocity = vec_interp(uu, XX, Nb);
X = X + dt * surface_velocity; 
X2=X2+dt*vec_interp(uu, X2, Nb2); % full step using midpoint velocity
X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
surfaceResample();
surfaceResample();  % Doing only once may leave 1-node interface
surface_velocity = vec_interp(uu, X, Nb);
surfaceSplice();
warpIndicators;

render;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
