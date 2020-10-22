clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants_conv_vanila();
initialize();

init_a();

INIT_VELO = 2;
for x=round(N * .15) : round(N * .35)
  for y = round(N * .15) : round(N * .35)
    u(x,       y,       2) =  INIT_VELO;
    u(N+1 - x, y,       2) =  INIT_VELO;
    u(x,       N+1 - y, 2) = -INIT_VELO;
    u(N+1 - x, N+1 - y, 2) = -INIT_VELO;
  end
end

%% Run simulation
clock = 0;

render_vanila();
while clock <= clockmax
  clock = clock + 1;
  step_conv_vanila();

  % pause(1);

  % if clock == floor(.1 / dt)
  %   big_G = big_G * 1.5;
  % end

  % if clock > 515
  %   pause;
  % end

  if schedule_next_frame_pause
    pause;
  end
end
