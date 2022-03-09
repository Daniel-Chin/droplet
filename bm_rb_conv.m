clc; clear all; close all;

N_course = 162 * (2 / 3) .^ [0 : 4];
dt_course = .0016 * (3 / 2) .^ [0 : 4];
course = [];
for k = 0 : 4
  % course(5 - k, :) = [N_course(k + 1), dt_course(k + 1)];
  course(k + 1, :) = [N_course(k + 1), dt_course(k + 1)];
end
for k = 1 : 4
  course(k + 5, :) = [N_course(k + 1), dt_course(1)];
end
course = course(1:end, :);
for k = course'
  clearvars -except k
  global dt Nb N h rho mu ip im a;
  global kp km dtheta K;
  global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
  global big_G;
  defineConstants_bm_rb();
  N = round(k(1));
  dt = k(2);
  initialize();
  OUTPUT_PATH = getenv('h') + "/d/IBM/main/rising_bubble/conv_degree";
  BACKUP_PATH = getenv('h') + "/d/temp/backup";

  Nb2=ceil(L / (h*.5) / 2); % Number of IB points
  dtheta2=L / 2 / Nb2; % IB point spacing
  k2=0:(Nb2-1);
  theta2 = (k2' + .5) * dtheta2;
  X2 = zeros(Nb2, 2);
  X2(:, 1) = theta2;
  X2(:, 2) = L;
  PERFECT_WALL = X2;

  init_a();
  initX_bm_rb();
  initInertia_bm_rb();

  %% Run simulation
  clock = 0;
  CM_his = [];
  CM2_his = [];
  initial_peri = calcPerimeter(X, Nb, links);
  circularity_his = [];
  render_bm_rb();
  shape_i = 0;
  X2(:, 2) = 1.99921;    % to avoid ceiling oscillation
  while clock <= clockmax
    clock = clock + 1;
    if clock == clockmax
      break;
    end
    step_bm_rb();

    CM_his(clock) = mean(X5(:, 2));
    % center_mass = CM_his(clock);
    % calcCM;
    % CM2_his(clock) = center_mass;
    circularity_his(clock) = initial_peri / calcPerimeter(X, Nb, links);

    if schedule_next_frame_pause
      pause;
    end
    if mod(clock, 100) == 0
      save(sprintf("%s/%d.mat", BACKUP_PATH, clock));
    end
  end
  save(sprintf("%s/%d_%f.mat", OUTPUT_PATH, N, dt));
end
