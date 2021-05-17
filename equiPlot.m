close all;
hold off;

X_SPACE = .24;

equiDefineConstants();
plot_col = 1;
for big_G = [600 800 1000 1200]
  % ax = subplot(2, 4, plot_col + 4);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .07, .13, .18, .3]);
  load(sprintf('results/equilibrium/%d.mat', big_G));
  his = curvature_pairs(3:end-2, 1);
  cvt = - curvature_pairs(3:end-2, 2);
  analytical = (mean(his) - his) * (big_G / K) + mean(cvt);
  plot(his, analytical, 'LineWidth', 1);
  % if big_G == 600
  %   axis([.75 1.6 -10 15]);
  % end
  % if big_G == 800
  %   axis([.7 1.6 -10 15]);
  % end
  % if big_G == 1000
  %   axis([.7 1.6 -10 15]);
  % end
  % if big_G == 1200
  %   axis([.6 1.6 -10 15]);
  % end
  axis([.6 1.6 -10 15]);
  hold on;
  line(xlim(), [0 0], 'Color', 'k');
  plot(his, cvt, 'x', 'MarkerSize', 7);
  if big_G == 600
    set(get(ax, 'YLabel'), 'String', 'Curvature (1/cm)', 'interpreter', 'latex');
  else
    set(ax, 'ytick', []);
  end
  set(get(ax, 'XLabel'), 'String', 'Altitude (cm)', 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 18;
  
  % ax = subplot(2, 4, plot_col);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .045, .53, .23, .35]);
  equiRenderOne();
  formatPlot();
  ax.FontSize = 18;
  if big_G > 600
    set(ax, 'ytick', []);
  end

  plot_col = plot_col + 1;
end
