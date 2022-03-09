close all;
hold off;

X_SPACE = .24;
big_G = 1000;

equiDefineConstants();
plot_col = 1;
for ndt = [24 48 96 192; 0.0004 0.0002 0.0001 0.00005]
  N = ndt(1);
  dt = ndt(2);
  % ax = subplot(2, 4, plot_col + 4);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .07, .13, .18, .3]);
  load(sprintf('results/equilibrium_conv/%d_%d.mat', big_G, N));
  equiDoIt_exclude_too_close;
  his = curvature_pairs(3:end-2, 1);
  cvt = - curvature_pairs(3:end-2, 2);
  ana_slope = big_G / K;
  ana_interc = mean(cvt);
  m_h = mean(his);
  analytical = (m_h - his) * ana_slope + ana_interc;
  AnalyticalLine = plot(analytical, his, 'LineWidth', 3, 'color', '#f70');
  axis([-20 20 .6 1.6]);
  hold on;
  fprintf("dt=%f N=%3d std=%f\n", dt, N, std(cvt - analytical));
  line([0 0], ylim(), 'Color', 'k');
  simDots = plot(cvt, his, '.', 'MarkerSize', 5, 'color', 'b');
  if N == 24
    set(get(ax, 'YLabel'), 'String', 'Altitude (cm)', 'interpreter', 'latex');
  else
    set(ax, 'ytick', []);
  end
  line(xlim(), [1.2 - .0006 * (big_G - 1200), 1.2 - .0006 * (big_G - 1200)], 'Color', [0 .5 0], 'LineWidth', 2);
  set(get(ax, 'XLabel'), 'String', 'Curvature (1/cm)', 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 18;
  
  % ax = subplot(2, 4, plot_col);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .045, .49, .23, .34]);
  if N == 24
    nbins = 4;
    rep = 8;
  elseif N == 48
    nbins = 5;
    rep = 4;
  elseif N == 96
    nbins = 6;
    rep = 2;
  elseif N == 192
    nbins = 15;
    rep = 1;
  end
  hist3(repmat([cvt his], rep, 1), "Nbins", [nbins 12]);
  title(sprintf('$dt$ = %.5f s \n$N$ = %d \n', dt, N), 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 18;
  % if N > 24
  %   set(ax, 'xtick', []);
  %   set(ax, 'ytick', []);
  %   set(ax, 'ztick', []);
  % end
  axis([-20 20 .6 1.6 0 50]);
  inflectionLine = line(xlim(), [1.2 - .0006 * (big_G - 1200), 1.2 - .0006 * (big_G - 1200)], 'Color', [0 .5 0], 'LineWidth', 2);
  
  plot_col = plot_col + 1;
end
lgd = legend([simDots, AnalyticalLine, inflectionLine], {'Simulation', 'Analytical', 'Inflection point'}, 'Interpreter','latex');
lgd.FontSize = 14;
set(lgd, 'Position', [.28 .34 0 0], 'Units', 'normalized');
