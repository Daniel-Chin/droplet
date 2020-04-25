% ib2D.m
% This script is the main program.
% Original Code by Charlie Peskin:
% https://www.math.nyu.edu/faculty/peskin/ib_lecture_notes/index.html
% Vectorized and commented by Tristan Goodwill,2019.4
%% Initialize simulation
clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
initialize
init_a

%% Run simulation
for clock=1:clockmax
  XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
  XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
  XX3 = X3+(dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
  ff=vec_spread(ForceSurface(XX, kp, km, dtheta, K), XX, dtheta, Nb); % Force at midpoint
  [force_wall, X2] = ForceWall(XX2, WALL_STIFFNESS, PERFECT_WALL, u, XX, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF);
  ff2 = vec_spread(force_wall, XX2, dtheta2, Nb2); % Force at midpoint
  total_ff = ff + ff2;
  computeGravity();
  total_ff(:, :, 2) = total_ff(:, :, 2) + gravity;
  total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
  [u,uu]=fluid(u,total_ff); % Step Fluid Velocity
  % vertical flow
  % u(end, 1) = VERTICAL_FLOW;
  % uu(end, 1) = VERTICAL_FLOW;
  X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
  X2=X2+dt*vec_interp(uu, XX2, Nb2); % full step using midpoint velocity
  X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
  [X, Nb, kp, km] = surfaceResample(X, Nb, dtheta);

  %animation:
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  % dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
  % values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
  % if any(values)
  %   valminmax=[min(values),max(values)];
  % else
  %   valminmax = [-69 69];
  % end
  contour(xgrid,ygrid,vorticity(1:end/2, :),values)
  hold on
  % plot([0 0], [0 L], 'r');
  plot([h h], [0 L], 'r');
  plot([h*2 h*2], [0 L], 'r');
  plot(X(:,1),X(:,2),'k.')
  plot(X2(:,1),X2(:,2),'b.')
  plot(X3(:,1),X3(:,2),'g.')
  plot(gravity_soul(1) * h, gravity_soul(2) * h, 'ro')
  % axis([-L/100,L/2,0,L])
  caxis(valminmax)
  axis equal
  axis manual
  title(clock * dt);
  drawnow
  saveFrame();
  hold off

  if clock == 333
    gravity_per_cell = - 100000 * h^2;
  end
end
