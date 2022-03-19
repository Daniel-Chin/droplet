N_course = round(162 * (2 / 3) .^ [0 : 4]);
dt_course = .0016 * (3 / 2) .^ [0 : 4];

% load rising_bubble/conv_degree/324_0.000800.mat
load rising_bubble/conv_degree/162_0.001600.mat
CM_true = CM_his(end, 2);
ci_true = circularity_his(end);
u_true = u;
N_true = N;

for kkk = [1 2]
  if kkk == 1
    disp("Varying dt AND N:");
  else
    disp("Varying only N:");
  end
  subplot(1, 2, kkk);
  dt_his = [];
  N_his = [];
  CM_error_his = [];
  ci_error_his = [];
  u_error_his = [];
  fprintf("N & dt & CM error & ci error & u error & CM order & ci order & u order \n");
  first = true;
  for k = 5 : -1 : 1
    N = N_course(k);
    if kkk == 1
      dt = dt_course(k);
    else
      dt = dt_course(1);
    end
    dt_his(k) = dt;
    N_his(k) = N;
    k_k_k = k;
    load(sprintf("rising_bubble/conv_degree/%d_%f.mat", N, dt));
    k = k_k_k;
    CM_error = CM_his(end, 2) - CM_true;
    ci_error = circularity_his(end) - ci_true;
    [x, y] = meshgrid(linspace(0, 1, N));
    [xq, yq] = meshgrid(linspace(0, 1, N_true));
    u_resampled_1 = interp2(x, y, u(:, :, 1), xq, yq);
    u_resampled_2 = interp2(x, y, u(:, :, 2), xq, yq);
    u_error = 0 ;
    u_error = u_error + sum((u_resampled_1 - u_true(:, :, 1)).^2, 'all');
    u_error = u_error + sum((u_resampled_2 - u_true(:, :, 2)).^2, 'all');
    u_error = sqrt(u_error);
    CM_error_his(k) = CM_error;
    ci_error_his(k) = ci_error;
    u_error_his(k) = u_error;
    fprintf("%d & %f & %f & %f & %f & ", N, dt, CM_error, ci_error, u_error);
    if first
      first = false;
      fprintf("NA & NA & NA \\\\ \n");
    else
      CM_order = (log(abs(CM_error)) - last_log_CM_e) / (log(1 / N) - last_log_N);
      ci_order = (log(abs(ci_error)) - last_log_ci_e) / (log(1 / N) - last_log_N);
      u_order = (log(abs(u_error)) - last_log_u_e) / (log(1 / N) - last_log_N);
      fprintf("%f & %f & %f \\\\ \n", CM_order, ci_order, u_order);
    end
    last_log_N = log(1 / N);
    last_log_CM_e = log(abs(CM_error));
    last_log_ci_e = log(abs(ci_error));
    last_log_u_e = log(abs(u_error));
  end
  hold on;
  % plot(log(N_his), log(abs(CM_error_his)), 'DisplayName', 'CM');
  % plot(log(N_his), log(abs(ci_error_his)), 'DisplayName', 'Circularity');
  % plot(log(N_his), log(abs(u_error_his)), 'DisplayName', 'Velocity');

  % plot(log(N_his), CM_error_his, 'DisplayName', 'CM');
  plot(log(N_his), ci_error_his, 'DisplayName', 'Circularity');
  % plot(log(N_his), u_error_his, 'DisplayName', 'Velocity');
  yline(0);
  legend();
end
