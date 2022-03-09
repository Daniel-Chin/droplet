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
  AnalyticalLine = plot(analytical, his, 'LineWidth', 3, 'color', '#f70');
  axis([-8 15 .6 1.6]);
  hold on;
  line([0 0], ylim(), 'Color', 'k');
  simDots = plot(cvt, his, '.', 'MarkerSize', 5, 'color', 'b');
  if big_G == 600
    set(get(ax, 'YLabel'), 'String', 'Altitude (cm)', 'interpreter', 'latex');
  else
    line(xlim(), [1.2 - .0006 * (big_G - 1200), 1.2 - .0006 * (big_G - 1200)], 'Color', [0 .5 0], 'LineWidth', 2);
    set(ax, 'ytick', []);
  end
  set(get(ax, 'XLabel'), 'String', 'Curvature (1/cm)', 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 18;
  
  % ax = subplot(2, 4, plot_col);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .045, .53, .23, .35]);
  equiRenderOne();
  formatPlot();
  ax.FontSize = 18;
  if big_G > 600
    set(ax, 'ytick', []);
    inflectionLine = line(xlim(), [1.2 - .0006 * (big_G - 1200), 1.2 - .0006 * (big_G - 1200)], 'Color', [0 .5 0], 'LineWidth', 2);
  end
  
  plot_col = plot_col + 1;
end
lgd = legend([simDots, AnalyticalLine, inflectionLine], {'Simulation', 'Analytical', 'Inflection point'}, 'Interpreter','latex');
lgd.FontSize = 14;
set(lgd, 'Position', [.26 .34 0 0], 'Units', 'normalized');
