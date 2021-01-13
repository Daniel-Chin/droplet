close all;

for big_G = [600 800 1000 1200]
  load(sprintf('results/equilibrium/%d.mat', big_G));
  h = curvature_pairs(3:end-2, 1);
  cvt = - curvature_pairs(3:end-2, 2);
  analytical = (mean(h) - h) * (big_G / K) + mean(cvt);
  hold off;
  plot(h, analytical);
  hold on;
  line(xlim(), [0 0], 'Color', 'k');
  plot(h, cvt, 'x');
  set(get(gca, 'YLabel'), 'String', 'Curvature (1/cm)');
  set(get(gca, 'XLabel'), 'String', 'Altitude (cm)');
  pause
end
