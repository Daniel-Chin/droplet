clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();
dt = 0.0005; % Time step, second
N = 64; % Number of grid cells
pIB_STIFF = 300;
tmax = .1;
initialize();
init_a();
WALL_EXISTS = 0;

n_init_droplets = 2;
init_circle_rad = [L * .1, L * .08];
init_circle_pos = zeros(2, 2);
init_circle_pos(1, :) = [L/4, L * 0.8];
init_circle_pos(2, :) = [L/4, L * 0.2];

initX_multi_circle();
initInertiaNew();

ASG = 22;
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
render();
area_his = [];
area_his_i = 0;
mergeExpLoop;
