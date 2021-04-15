close all;

equiDefineConstants();
for big_G = [600 800 1000 1200]
  load(sprintf('results/equilibrium/%d.mat', big_G));
  h = curvature_pairs(3:end-2, 1);
  cvt = - curvature_pairs(3:end-2, 2);
  analytical = (mean(h) - h) * (big_G / K) + mean(cvt);
  hold off;
  plot(h, analytical);
  if big_G == 600
    axis([.75 1.6 -10 15]);
  end
  if big_G == 800
    axis([.7 1.6 -10 15]);
  end
  if big_G == 1000
    axis([.7 1.6 -10 15]);
  end
  if big_G == 1200
    axis([.6 1.6 -10 15]);
  end
  hold on;
  line(xlim(), [0 0], 'Color', 'k');
  plot(h, cvt, 'x');
  if big_G == 600
    set(get(gca, 'YLabel'), 'String', 'Curvature (1/cm)');
  end
  set(get(gca, 'XLabel'), 'String', 'Altitude (cm)');
  set(gca, 'FontSize', 24);
  pause
end
