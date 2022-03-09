N_course = 162 * (2 / 3) .^ [0 : 4];
dt_course = .0016 * (3 / 2) .^ [0 : 4];

N = N_course(1);
dt = dt_course(1);
load(sprintf("rising_bubble/conv_degree/%d_%f.mat", N, dt));
CM_true = CM_his(end);
ci_true = circularity_his(end);

for kkk = [1 2]
  if kkk == 1
    disp("Varying dt AND N:");
  else
    disp("Varying only N:");
  end
  fprintf("N & dt & CM error & ci error & CM order & ci order \n");
  first = true;
  for k = 5 : -1 : 1
    N = N_course(k);
    if kkk == 1
      dt = dt_course(k);
    else
      dt = dt_course(1);
    end
    load(sprintf("rising_bubble/conv_degree/%d_%f.mat", N, dt));
    CM_error = CM_his(end) - CM_true;
    ci_error = circularity_his(end) - ci_true;
    fprintf("%d & %f & %f & %f & ", N, dt, CM_error, ci_error);
    if first
      first = false;
      fprintf("NA & NA \n");
    else
      cm_order = (log(abs(CM_error)) - last_log_CM_e) / (log(N) - last_log_N);
      ci_order = (log(abs(ci_error)) - last_log_ci_e) / (log(N) - last_log_N);
      fprintf("%f & %f \n", CM_order, ci_order);
    end
    last_log_N = log(N);
    last_log_CM_e = log(abs(CM_error));
    last_log_ci_e = log(abs(ci_error));
  end
end
