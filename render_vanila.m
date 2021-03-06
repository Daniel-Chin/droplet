render_phase = render_phase + dt;
if render_phase >= SPF
  render_phase = render_phase - SPF;

  hold on;
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  contour(xgrid,ygrid,vorticity(1:end/2, :),values);
  plot(X3(:,1),X3(:,2),'k.')
  caxis(valminmax)
  axis equal
  axis manual
  axis([0,L/2,0,L])
  title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
  drawnow
  saveFrame();
  hold off
end
