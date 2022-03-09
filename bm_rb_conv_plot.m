plot_dt = [];
plot_N = [];
plot_CM = [];
plot_ci = [];

fprintf("Varying dt AND N:\n");
load rising_bubble/conv_degree/256_0.001000.mat;
CM_true = CM_his(end);
ci_true = circularity_his(end);

load rising_bubble/conv_degree/32_0.008000.mat;
plot_dt(1) = 0.008;
plot_N(1) = 32;
plot_CM(1) = CM_his(end);
plot_ci(1) = circularity_his(end);

load rising_bubble/conv_degree/64_0.004000.mat;
plot_dt(2) = 0.004;
plot_N(2) = 64;
plot_CM(2) = CM_his(end);
plot_ci(2) = circularity_his(end);

load rising_bubble/conv_degree/128_0.002000.mat;
plot_dt(3) = 0.002;
plot_N(3) = 128;
plot_CM(3) = CM_his(end);
plot_ci(3) = circularity_his(end);

hold on;
x = log(plot_N);
y_CM = log(abs(plot_CM - CM_true));
y_ci = log(abs(plot_ci - ci_true));
fit = polyfit(x, y_CM, 1);
CM_coef = fit(1)
fit = polyfit(x, y_ci, 1);
ci_coef = fit(1)
plot(x, y_CM, 'o-');
plot(x, y_ci, 'o-');
legend( ...
  'Center of mass', ...
  'Circularity', ...
  'interpreter', 'latex' ...
);
set(get(gca, 'XLabel'), 'String', '$log(N)$ as well as $log(dt)+c$', 'interpreter', 'latex');
set(get(gca, 'YLabel'), 'String', '$log($error$)$', 'interpreter', 'latex');
formatPlot();
title({'Rising bubble test case 1'; 'Order of accuracry, varying both $dt$ and $N$'}, 'interpreter', 'latex');
axis equal;

pause;

fprintf("Varying ONLY N:\n");
load rising_bubble/conv_degree/32_0.001000.mat;
plot_dt(1) = 0.001;
plot_N(1) = 32;
plot_CM(1) = CM_his(end);
plot_ci(1) = circularity_his(end);

load rising_bubble/conv_degree/64_0.001000.mat;
plot_dt(2) = 0.001;
plot_N(2) = 64;
plot_CM(2) = CM_his(end);
plot_ci(2) = circularity_his(end);

load rising_bubble/conv_degree/128_0.001000.mat;
plot_dt(3) = 0.001;
plot_N(3) = 128;
plot_CM(3) = CM_his(end);
plot_ci(3) = circularity_his(end);

hold on;
x = log(plot_N);
y_CM = log(abs(plot_CM - CM_true));
y_ci = log(abs(plot_ci - ci_true));
fit = polyfit(x, y_CM, 1);
CM_coef = fit(1)
fit = polyfit(x, y_ci, 1);
ci_coef = fit(1)
plot(x, y_CM, 'o-');
plot(x, y_ci, 'o-');
legend( ...
  'Center of mass', ...
  'Circularity', ...
  'interpreter', 'latex' ...
);
set(get(gca, 'XLabel'), 'String', '$log(N)$', 'interpreter', 'latex');
set(get(gca, 'YLabel'), 'String', '$log($error$)$', 'interpreter', 'latex');
formatPlot();
title({'Rising bubble test case 1'; 'Order of accuracry, varying $N$, fixing $dt$ at minimum'}, 'interpreter', 'latex');
axis equal;
