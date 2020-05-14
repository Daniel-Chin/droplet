function [uuu, uu] = waterFluid(u, ff, PHASE_PENAL_ITER, ZERO_FORCE, gravity, N, surface_grid, MIRROR)

[uuu, uu] = fluid(u, ff); % Step Fluid Velocity
prescribed = surface_grid .* uu;
unprescribed = 1 - surface_grid;

for j = 1 : PHASE_PENAL_ITER
  uuu = fluid(unprescribed .* uuu + prescribed, ZERO_FORCE);
  % Left wall
  uuu(1, :, :) = 0;
  uuu(2, :, :) = 0;
end
ready = (gravity ~= 0) .* u + (gravity == 0) .* uuu;
ready(N/2+1 : end, :, :) = ready(N/2 :-1: 1, :, :) .* MIRROR;
[uuu, uu] = fluid(ready, ff);
% Left wall
uu (1, :, 1) = 0;
uuu(1, :, 1) = 0;
uu (2, :, 1) = 0;
uuu(2, :, 1) = 0;
