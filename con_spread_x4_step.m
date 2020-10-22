plot(0);
hold on;

XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
ff4 = vec_spread( ...
  force4, ...
  X4, dtheta4, Nb4 ...
);
ff4 = ff4 + ff4(end:-1:1, :, :) .* MIRROR;

% full step using midpoint velocity
[u,uu] = fluid(u, ff4); % Step Fluid Velocity
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
warpIndicators;

render_vanila;
