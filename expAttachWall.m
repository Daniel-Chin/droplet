clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
defineConstants();
% dt = 0.0002; % Time step, second
% N = 64; % Number of grid cells
initialize();
init_a();
WALL_EXISTS = 1;

n_init_droplets = 1;
init_circle_rad = ones(n_init_droplets, 1) * L * .1;
init_circle_pos = zeros(n_init_droplets, 2);

init_circle_pos(1, :) = [L * .2, L/2];

initX_multi_circle();
initInertiaNew();

big_G = -400;

%% Run simulation
tmax = 2; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  clock = clock + 1;
  splitExpStep();

  if schedule_next_frame_pause
    pause;
  end
end
