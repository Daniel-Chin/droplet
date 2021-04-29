clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
defineConstants();
initialize();
init_a();
initX_split();
initInertia();
big_G = 0;

%% Run simulation
tmax=4; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  if clock <= 450
    big_G = big_G + 10;
  end
  if 450 < clock && clock <= 700
    big_G = big_G - 10;
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
