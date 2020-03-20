% ib2D.m
% This script is the main program.
% Original Code by Charlie Peskin:
% https://www.math.nyu.edu/faculty/peskin/ib_lecture_notes/index.html
% Vectorized and commented by Tristan Goodwill,2019.4
%% Initialize simulation
clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NAIL_STIFF NAILS;
initialize
init_a

%% Run simulation
for clock=1:clockmax
  XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
  XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
  XX3=X3+(dt/2)*vec_interp(u, X3, Nb3); % Euler step to midpoint
  ff=vec_spread(ForceSurface(XX, kp, km, dtheta, K, NAILS, NAIL_STIFF), XX, dtheta, Nb); % Force at midpoint
  ff2=vec_spread(ForceWall(XX2, WALL_STIFFNESS, PERFECT_WALL), XX2, dtheta2, Nb2); % Force at midpoint
  ff3=vec_spread(ForceGravel(Nb3), XX3, dtheta3, Nb3); % Force at midpoint
  [u,uu]=fluid(u,ff + ff2 + ff3); % Step Fluid Velocity
  X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
  X2=X2+dt*vec_interp(uu, XX2, Nb2); % full step using midpoint velocity
  X3=X3+dt*vec_interp(uu, XX3, Nb3); % full step using midpoint velocity
  
  %animation:
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  contour(xgrid,ygrid,vorticity,values)
  hold on
  plot(X(:,1),X(:,2),'ko')
  plot(X2(:,1),X2(:,2),'bo')
  plot(X3(:,1),X3(:,2),'ro')
  axis([0,L,0,L])
  caxis(valminmax)
  axis equal
  axis manual
  drawnow
  hold off
  % pause(.1)
end
