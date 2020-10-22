clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
con_van_f_defineConstants();
initialize();

init_a();

PUSH = 1;
total_f = zeros(N, N, 2);
for x=round(N * .15) : round(N * .35)
  for y = round(N * .15) : round(N * .35)
    total_f(x,       y,       2) =  PUSH;
    total_f(N+1 - x, y,       2) =  PUSH;
    total_f(x,       N+1 - y, 2) = -PUSH;
    total_f(N+1 - x, N+1 - y, 2) = -PUSH;
  end
end

%% Run simulation
clock = 0;

render_vanila();
while clock <= clockmax
  clock = clock + 1;
  con_van_f_step();

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
