plot(0);
hold on;

XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
force_wall = ForceWall_noslip(XX2, WALL_STIFFNESS, PERFECT_WALL);
max_wall_penalty = max(vecnorm((PERFECT_WALL - XX2)'));
if max_wall_penalty > h*.3
  warning('warn');
  disp('Wall penalty exceeds h*.3!');
  disp(max_wall_penalty / (h*.3));
end
ff2 = vec_spread_new(force_wall, X2, Nb2); % Force at midpoint
total_ff = ff2;
mirrored = total_ff .* MIRROR;
total_ff(1, :, :) = total_ff(1, :, :) + mirrored(1, :, :);
total_ff(2:end, :, :) = total_ff(2:end, :, :) + mirrored(end:-1:2, :, :);
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

% full step using midpoint velocity
X2 = X2 + dt * vec_interp(uu, X2, Nb2); % cannot be XX2 because forceWall alters X2

render_wall_only;

% resample_energy_offset_array_size = resample_energy_offset_array_size+1;
% resample_energy_offset_array(resample_energy_offset_array_size) = resample_energy_offset;
