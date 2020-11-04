render_phase = render_phase + dt;
if render_phase >= SPF
  render_phase = render_phase - SPF;

  hold on;
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  contour(xgrid,ygrid,vorticity(1:end/2, :),values);
  % plot([0 0], [0 L], 'r');
  plot([0 0], [0 L], 'r');
  plot([h h], [0 L], 'r');
  plot([h*2 h*2], [0 L], 'r');
  plot(X2(:,1),X2(:,2),'k.')
  % axis([-L/100,L/2,0,L])
  caxis(valminmax)
  axis equal
  axis manual
  title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
  drawnow
  saveFrame();
  hold off
end
