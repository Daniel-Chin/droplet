equiDefineConstants();
initialize();
init_a();
n_init_droplets = 1;
init_circle_rad = [.35];
init_circle_pos = zeros(1, 2);
init_circle_pos(1, :) = [0, L * 0.6];
initX_multi_half_circles();
initInertiaNew();

%% Run simulation
render();
slope_err_his = [];
slope_err_his_i = 0;
while clock < clockmax
  clock = clock + 1;
  step();
  if mod(clock, 16) == 0
    curavture_estimation_radius = round(N / 24);
  % curavture_estimation_radius = 2;
    equiDoIt_normalized();
    alt = curvature_pairs(3:end-2, 1);
    cvt = - curvature_pairs(3:end-2, 2);
    fit_result = polyfit(cvt, alt, 1);
    slope_err = fit_result(1) - (- K / 1000 / (rho_heavy - rho));
    slope_err_his_i = slope_err_his_i + 1;
    slope_err_his(1, slope_err_his_i) = clock * dt;
    slope_err_his(2, slope_err_his_i) = slope_err;
  end
  % if mod(clock, 64) == 0
  %   hold off;
  %   simDots = plot(alt, cvt);
  %   axis([.6 1.6 -20 20]);
  %   drawnow;
  %   title(sprintf('t = %.3f', clock * dt));
  %   saveFrame();
  % end

  if schedule_next_frame_pause
    pause;
  end
end

save(sprintf('results/%s/%d_%d_%f.mat', exp_name, big_G, N, dt));
% hold off;
% plot(slope_err_his(1, :), slope_err_his(2, :));
% hold on;
% line(xlim(), [0 0], 'Color', 'k');
% xlim([slope_err_his(1, round(end * .05 / tmax)), slope_err_his(1, end)]);
% hold off;
% pause;
