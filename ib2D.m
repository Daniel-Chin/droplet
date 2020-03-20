% ib2D.m
% This script is the main program.
% Original Code by Charlie Peskin:
% https://www.math.nyu.edu/faculty/peskin/ib_lecture_notes/index.html
% Vectorized and commented by Tristan Goodwill,2019.4
%% Initialize simulation
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
initialize
init_a

%% Run simulation
for clock=1:clockmax
  XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
  XX2=X2+(dt/2)*vec_interp(u, X2, Nb2); % Euler step to midpoint
  ff=vec_spread(Force(XX, kp, km, dtheta, K), XX, dtheta, Nb); % Force at midpoint
  ff2=vec_spread(ForceWall(XX2), XX2, dtheta2, Nb2); % Force at midpoint
  [u,uu]=fluid(u,ff + ff2); % Step Fluid Velocity
  X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
  X2=X2+dt*vec_interp(uu, XX2, Nb2); % full step using midpoint velocity
  
  %animation:
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  contour(xgrid,ygrid,vorticity,values)
  hold on
  plot(X(:,1),X(:,2),'ko')
  plot(X2(:,1),X2(:,2),'ko')
  axis([0,L,0,L])
  caxis(valminmax)
  axis equal
  axis manual
  drawnow
  hold off
end
