% Inches:
% 0.1 0.2 10 6
% 10.1 6.4

close all;
hold off;

X_SPACE = .24;
% X_SPACE = .19;
big_G = 1000;

equiDefineConstants();
plot_col = 1;
fprintf("N & dt & curvature error & order of accuracy \n");
first = true;
for N = [24 48 96 192]
  dt = 0.00005;
  % ax = subplot(2, 4, plot_col + 4);
  ax = subplot('Position', [(plot_col-1) * X_SPACE + .07, .13, .18, .3]);
  % ax = subplot('Position', [(plot_col-1) * X_SPACE + .07, .13, .15, .3]);
  load(sprintf('results/equilibrium_conv/%d_%d_%f.mat', big_G, N, dt));
  curavture_estimation_radius = round(N / 24);
  equiDoIt_normalized();
  alt = curvature_pairs(3:end-2, 1);
  cvt = - curvature_pairs(3:end-2, 2);
  fit_result = polyfit(alt, cvt, 1);
  ana_slope = - big_G / K * (rho_heavy - rho);
  slope_err = fit_result(1) - ana_slope;
  ana_interc = mean(cvt);
  m_a = mean(alt);
  analytical = (alt - m_a) * ana_slope + ana_interc;
  AnalyticalLine = plot(analytical, alt, 'LineWidth', 3, 'color', '#f70');
  axis([-8 15 .6 1.6]);
  hold on;
  l2_err = std(cvt - analytical);
  fprintf("%f & %3d & %f & ", dt, N, l2_err);
  if first
    first = false;
    fprintf("NA \\\\ \n");
  else
    order_acc = (log(l2_err) - last_log_l2_e) / (log(1 / N) - last_log_N);
    fprintf("%f \\\\ \n", order_acc);
  end
  last_log_N = log(1 / N);
  last_log_l2_e = log(l2_err);
  line([0 0], ylim(), 'Color', 'k');
  simDots = plot(cvt, alt, '.', 'MarkerSize', 5, 'color', 'b');
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
  % ax = subplot('Position', [(plot_col-1) * X_SPACE + .045, .49, .18, .34]);
  % if N == 24
  %   nbins = 4;
  %   rep = 8;
  % elseif N == 48
  %   nbins = 5;
  %   rep = 4;
  % elseif N == 96
  %   nbins = 6;
  %   rep = 2;
  % elseif N == 192
  %   nbins = 15;
  %   rep = 1;
  % end
  % hist3(repmat([cvt alt], rep, 1), "Nbins", [nbins 12]);
  equiRenderOne();
  title(sprintf('$dt$ = %.5f s \n$N$ = %d \n', dt, N), 'interpreter', 'latex');
  formatPlot();
  ax.FontSize = 18;
  % if N > 24
  %   set(ax, 'xtick', []);
  %   set(ax, 'ytick', []);
  %   set(ax, 'ztick', []);
  % end
  % axis([-20 20 .6 1.6 0 50]);
  inflectionLine = line(xlim(), [1.2 - .0006 * (big_G - 1200), 1.2 - .0006 * (big_G - 1200)], 'Color', [0 .5 0], 'LineWidth', 2);
  
  plot_col = plot_col + 1;
end
lgd = legend([simDots, AnalyticalLine, inflectionLine], {'Simulation', 'Analytical', 'Inflection point'}, 'Interpreter','latex');
lgd.FontSize = 14;
set(lgd, 'Position', [.28 .34 0 0], 'Units', 'normalized');
