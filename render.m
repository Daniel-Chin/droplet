hold off
vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
contour(xgrid,ygrid,vorticity(1:end/2, :),values);
hold on
% plot([0 0], [0 L], 'r');
plot([0 0], [0 L], 'r');
plot([h h], [0 L], 'r');
plot([h*2 h*2], [0 L], 'r');
plot(X3(:,1),X3(:,2),'k.')
plot(X4(:,1),X4(:,2),'g.')
plot(X2(:,1),X2(:,2),'k.')
plot(X(:,1),X(:,2),'b.')
% axis([-L/100,L/2,0,L])
caxis(valminmax)
axis equal
axis manual
title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
drawnow
saveFrame();
