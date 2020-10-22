plot(0);
hold on;

XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint

% full step using midpoint velocity
[u,uu] = fluid(u, zeros(N, N, 2)); % Step Fluid Velocity
X3 = X3 + dt * vec_interp(uu, XX3, Nb3);
warpIndicators;

render_vanila;
