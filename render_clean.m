render_phase = render_phase - 1;
if render_phase <= 0
  render_phase = TIMESTEPS_PER_FRAME;

  hold on;
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  contour(xgrid,ygrid,vorticity(1:end/2, :),values);
  plot(X3(:,1),X3(:,2),'k.')
  plot(X4(:,1),X4(:,2),'g.')
  % plot(X(:,1),X(:,2),'b.')
  for j = 1 : Nb
    if doesLinkWall(j, links, wall_links)
      continue;
    end
    k = links(1, j);
    if k > j
      plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 2);
    end
    k = links(2, j);
    if k > j
      plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 2);
    end
  end
  caxis(valminmax)
  axis equal
  axis manual
  % axis([0,L/2,0,L])
  title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
  drawnow
  saveFrame();
  hold off
end
