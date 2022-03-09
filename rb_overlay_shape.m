close all;

lw = .5;

for snap_i = [1:12]
  load(sprintf('rising_bubble/10to10/wall_stiff_8000/shape/%d.mat', snap_i));
  h = [0 0];
  bm_triag = stlread(sprintf("RB_10to10Vis/_vtk/surf_000%02d.stl", snap_i));
  X = X + [-.5 -.5];
  sz = size(bm_triag.Points);

  % hold off;
  hi = trimesh(bm_triag.ConnectivityList, bm_triag.Points(:, 1), bm_triag.Points(:, 2), 'Color', 'k');
  h(1) = hi(1);
  % , 'DisplayName', 'Benchmark'
  hold on;
  for j = 1 : Nb
    if doesLinkWall(j, links, wall_links)
      continue;
    end
    k = links(1, j);
    if k > j && X(k, 1) > 0
      hi = plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'r', 'LineWidth', lw);
      h(2) = hi(1);
      % , 'DisplayName', 'Ours'
    end
    k = links(2, j);
    if k > j && X(k, 1) > 0
      plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'r', 'LineWidth', lw);
    end
  end

  % axis equal;
  % view(0, 90);
  % set(gca,'visible','off')
  % if snap_i == 12
  %   legend();
  % else
  %   % legend('off');
  %   legend(h, {"Benchmark", "Ours"});
  % end
  drawnow;
  % saveas(gcf, sprintf('rising_bubble/10to10/wall_stiff_8000/shape/%d.pdf', snap_i));
  % saveas(gcf, sprintf('rising_bubble/10to10/wall_stiff_8000/shape/%d.png', snap_i));
end
view(0, 90);
axis equal;
axis([0 0.55 -.25 .8]);
legend(h, {"Featflow", "IB"}, 'Location', 'se', 'interpreter', 'latex', 'AutoUpdate', 'off');
set(gca, 'FontSize', 20);

drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );
drawArrow([.37 .37], [0 .5], 'linewidth', 1, 'color', 'k');

formatPlot();
text(.38, .25, sprintf('Time \nincreasing'));
preprint();
