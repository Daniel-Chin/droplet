render_phase = render_phase + dt;
if render_phase >= SPF
  render_phase = render_phase - SPF;

  hold on;
  if RENDER_DEBUG == 1
    vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
    contour(xgrid,ygrid,vorticity(1:end/2, :),values);
  end
  % plot([0 0], [0 L], 'r');
  plot([0 0], [0 L], 'r');
  plot([h h], [0 L], 'r');
  plot([h*2 h*2], [0 L], 'r');
  plot(X3(:,1),X3(:,2),'*','color',[.6 .6 .6]);
  plot(X4(:,1),X4(:,2),'g.')
  plot(X2(:,1),X2(:,2),'k.')
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
  if RENDER_DEBUG ~= 1
    axis([-h, L/2, 0, L]);
  end
  title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
  drawnow;
  saveFrame();
  hold off
end
