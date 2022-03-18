close all;

tiledlayout(2, 3, 'Padding', 'compact', 'TileSpacing', 'compact'); 
for plot_i = (1:6)
  ax = nexttile;
  col = mod(plot_i, 3);
  if col == 1
    N = 128;
  elseif col == 2
    N = 192;
    set(ax, 'ytick', []);
  elseif col == 0
    N = 256;
    set(ax, 'ytick', []);
  end
  if plot_i <= 3
    dt     =  0.00001;
    str_dt = '0.000010';
    display_dt = '{1}\times10^{-5}';
    set(ax, 'xtick', []);
  else
    dt     =  0.00002;
    str_dt = '0.000020';
    display_dt = '{2}\times10^{-5}';
  end
  % defineConstants();
  % initialize();
  load(sprintf( ...
    strrep(getenv('h'), '\', '/') + "/d/IBM_Space/slide/convergence_static_54/record_%s_%d/107.mat", str_dt, N ...
  ));

  hold on;
  plot(X4(:,1),X4(:,2),'c.','MarkerSize',1);
  plot(X2(:,1),X2(:,2),'k.','MarkerSize',1);
  for j = 1 : Nb
    if doesLinkWall(j, links, wall_links)
      continue;
    end
    k = links(1, j);
    if k > j
      plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 1);
    end
    k = links(2, j);
    if k > j
      plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 1);
    end
  end
  axis equal
  axis manual
  axis([0, L/2, 0, L])
  for x = linspace(0, 1, 7)
    line([x x], ylim(), 'Color', [.5 .5 .5]);
  end
  for y = linspace(0, 2, 13)
    line(xlim(), [y y], 'Color', [.5 .5 .5]);
  end
    drawnow
  hold off
  % annotation('textbox', [0.6, 0.7, 0.3, 0.2], 'String', sprintf('$dt = %s$\n$N = %d$', display_dt, N));
  rectangle('Position', [.14 1.5 .82 .43], 'FaceColor', [1 1 1]);
  text(.19, 1.7, sprintf('$dt = %s$\n$N = %d$', display_dt, N), 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 12;
end
preprint();
