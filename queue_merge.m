close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;


for kk = [.0005, .0002, .0001; 64, 96, 128]
  defineConstants();
  dt = kk(1); % Time step, second
  N = kk(2); % Number of grid cells
  pIB_STIFF = 300;
  tmax = .1;
  initialize();

  OUTPUT_PLACE = sprintf('E:/IBM_Space/merge2/output_%f_%d', dt, N);
  mkdir(OUTPUT_PLACE);
  OUTPUT_PATH = OUTPUT_PLACE + "/%d.png";
  RECORD_PLACE = sprintf('E:/IBM_Space/merge2/record_%f_%d', dt, N);
  mkdir(RECORD_PLACE);
  RECORD_PATH = RECORD_PLACE + "/%d.mat";
  RENDER_DEBUG = 0;

  init_a();
  WALL_EXISTS = 0;

  n_init_droplets = 2;
  init_circle_rad = [L * .1, L * .08];
  init_circle_pos = zeros(2, 2);
  init_circle_pos(1, :) = [L/4, L * 0.8];
  init_circle_pos(2, :) = [L/4, L * 0.2];

  initX_multi_circle();
  initInertiaNew();

  ASG = 20;
  for i = 1 : N / 2
    for j = 1 : N
      if norm([i-1, j-1] - init_circle_pos(1, :) / h) < init_circle_rad(1) / h
        u(i, j, 2) = -ASG;
        u(N - i + 2, j, 2) = -ASG;
      end
      if norm([i-1, j-1] - init_circle_pos(2, :) / h) < init_circle_rad(2) / h
        u(i, j, 2) = ASG;
        u(N - i + 2, j, 2) = ASG;
      end
    end
  end
  for i = 1 : Nb4
    if norm(X4(i, :) - init_circle_pos(1, :)) < init_circle_rad(1)
      V4(i, 2) = -ASG;
    end
    if norm(X4(i, :) - init_circle_pos(2, :)) < init_circle_rad(2)
      V4(i, 2) = ASG;
    end
  end


  %% Run simulation
  clockmax=ceil(tmax/dt);
  clock = 0;
  % plot(0);
  % hold on;
  % render_phase = SPF - dt;
  render();
  area_his = [];
  area_his_i = 0;
  mergeExpLoop;
end







clear all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;

for kk = [.0002, .0001, .00005; 96, 128, 192]
  defineConstants();
  dt = kk(1); % Time step, second
  N = kk(2); % Number of grid cells
  pIB_STIFF = 500;

  % rho_heavy = 2; % density g/cm2
  initialize();

  OUTPUT_PLACE = sprintf('E:/IBM_Space/merge6/output_%f_%d', dt, N);
  mkdir(OUTPUT_PLACE);
  OUTPUT_PATH = OUTPUT_PLACE + "/%d.png";
  RECORD_PLACE = sprintf('E:/IBM_Space/merge6/record_%f_%d', dt, N);
  mkdir(RECORD_PLACE);
  RECORD_PATH = RECORD_PLACE + "/%d.mat";
  RENDER_DEBUG = 0;

  Nb3x = floor((N / Nb3_space));
  Nb3y = floor((N / Nb3_space));
  Nb3 = Nb3x * Nb3y; % Number of IB points
  dtheta3 = h * Nb3_space; % IB point spacing
  X3 = zeros(Nb3y, Nb3y, 2);
  theta3 = (1:Nb3y) * dtheta3;
  for j=1:Nb3y
    X3(j, :, 1) = theta3;
    X3(:, j, 2) = theta3';
  end
  X3 = reshape(X3(:, 1:Nb3x, :), Nb3, 2);

  xgrid=zeros(N,N);
  ygrid=zeros(N,N);
  for j=0:(N-1)
    xgrid(j+1,:)=j*h;
    ygrid(:,j+1)=j*h;
  end

  init_a();
  WALL_EXISTS = 0;
  % dvorticity = 5;
  % values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
  % valminmax=[min(values),max(values)];  % for plotting vortocity

  n_init_droplets = 6;
  init_circle_rad = ones(n_init_droplets, 1) * L * .06;
  init_circle_pos = zeros(n_init_droplets, 2);

  for j = 1 : n_init_droplets
    % theta = 2 * pi / n_init_droplets * j;
    theta = 2 * pi / n_init_droplets * j + pi / 9;
    % theta = 2 * pi / n_init_droplets * j + pi / 6;
    % off_center = L * .2;
    off_center = L * (.16 + j * .02);
    init_circle_pos(j, :) = [L/2, L/2] + off_center * [cos(theta), sin(theta)];
  end

  initX_multi_circle();
  initInertiaNew();
  big_G = 900;

  %% Run simulation
  tmax = .1; % Run until time
  clockmax=ceil(tmax/dt);
  clock = 0;
  % plot(0);
  % hold on;
  % render_phase = SPF - dt;
  render_wide();
  area_his = [];
  area_his_i = 0;
  mergeSixExpLoop;
end
