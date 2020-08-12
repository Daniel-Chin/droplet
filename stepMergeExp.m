hold off
vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
contour(xgrid,ygrid,vorticity(1:end/2, :),values);
hold on

XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint
ff=vec_spread(ForceSurface(XX, links, dtheta, K, wall_links, Nb), XX, dtheta, Nb); % Force at midpoint
YY4 = Y4 + V4 * dt;
force4 = forcePib(YY4 - XX4, pIB_STIFF);
ff4 = vec_spread( ...
  force4, ...
  XX4, dtheta4, Nb4 ...
);
V4 = V4 - force4 * dt / MASS_PER_POINT;
Y4 = Y4 + V4 * dt;
total_ff = ff + ff4;
% total_ff = ff;
total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
[u,uu]=fluid(u,total_ff); % Step Fluid Velocity

X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
X2=X2+dt*vec_interp(uu, X2, Nb2); % full step using midpoint velocity
X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
surfaceResample();
warpIndicators;

plot(X3(:,1),X3(:,2),'k.')
plot(X4(:,1),X4(:,2),'g.')
plot(X(:,1),X(:,2),'b.')
caxis(valminmax)
axis equal
axis manual
title(sprintf('t = %.3f', clock * dt));
drawnow
saveFrame();
