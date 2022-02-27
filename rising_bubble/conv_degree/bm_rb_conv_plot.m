plot_dt = [];
plot_N = [];
plot_CM = [];
plot_ci = [];

BM_CM = 1.0559196;
BM_ci = 9.134410E-01;

load 32_0.008000.mat;
plot_dt(1) = 0.008;
plot_N(1) = 32;
plot_CM(1) = CM_his(end);
plot_ci(1) = circularity_his(end);

load 64_0.004000.mat;
plot_dt(2) = 0.004;
plot_N(2) = 64;
plot_CM(2) = CM_his(end);
plot_ci(2) = circularity_his(end);

load 128_0.002000.mat;
plot_dt(3) = 0.002;
plot_N(3) = 128;
plot_CM(3) = CM_his(end);
plot_ci(3) = circularity_his(end);

load 256_0.001000.mat;
plot_dt(4) = 0.001;
plot_N(4) = 256;
plot_CM(4) = CM_his(end);
plot_ci(4) = circularity_his(end);

hold on;
plot(log(plot_N), log(abs(plot_CM - BM_CM)), 'o-');
plot(log(plot_N), log(abs(plot_ci - BM_ci)), 'o-');
plot(log(plot_N), log((.9138495 - plot_ci)), 'o-');
legend( ...
  'center of mass VS featflow', ...
  'circularity VS featflow', ...
  'circularity VS asymptote' ...
);
set(get(gca, 'XLabel'), 'String', 'log(N)');
set(get(gca, 'YLabel'), 'String', 'log(error)');
formatPlot();
