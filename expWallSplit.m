clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
defineConstants();
STATIC_CONTACT_ANGLE = pi * .4;
dt = 0.0002; % Time step, second
N = 64; % Number of grid cells
initialize();
init_a();
initX_split();
initInertia();
big_G = 110000;

%% Run simulation
tmax=4; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  if clock <= 80
    big_G = big_G + 300;
  end
  if 80 < clock && clock <= 160
    big_G = big_G - 500;
  end
  clock = clock + 1;
  stepWallSplitExp();

  if schedule_next_frame_pause
    pause;
  end
  if mod(clock, 16) == 0
    saveRecord();
  end
end
