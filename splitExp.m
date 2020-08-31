clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
initialize();
init_a();
initX_split();
initInertia();
big_G = 2300;

%% Run simulation
tmax=4; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  if clock <= 2335
    big_G = big_G + 0.5;
  end
  clock = clock + 1;
  splitExpStep();

  % pause(1);
  % if clock == 2335
  %   return;
  % end
  if clock == 2335
    lu = 179;
    ru = links(2, lu);
    ld = 93;
    rd = links(1, ld);
    links(1, ru) = rd;
    links(2, rd) = ru;
    links(1, ld) = lu;
    links(2, lu) = ld;
  end

  % if clock > 410
  %   pause(.1);
  % end
  if schedule_next_frame_pause
    pause;
  end
end
