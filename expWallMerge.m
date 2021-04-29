clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
defineConstants();
K = 100; % Surface tension coefficient, N*10^-5
NO_SLIP_FORCE = 4;
FRICTION_ADJUST = 30;
L = 3;
initialize();
init_a();

n_init_droplets = 2;
init_circle_rad = ones(n_init_droplets, 1) * .35;
init_circle_pos = zeros(n_init_droplets, 2);

init_circle_pos(1, :) = [0, L * .5 - .4];
init_circle_pos(2, :) = [0, L * .5 + .4];

initX_wallMerge();
initInertiaNew();
big_G = 0;

%% Run simulation
tmax=1; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  if clock <= 250
    big_G = big_G - 10;
  end
  clock = clock + 1;
  splitExpStep();

  if schedule_next_frame_pause
    pause;
  end
  if mod(clock, 16) == 0
    saveRecord();
  end
end
