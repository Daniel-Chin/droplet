%% Initialize simulation
clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
con_ib2d_defineConstants();
initialize();
init_a();
con_ib2d_initX();

X4 = zeros(0, 2);  % for rendering

%% Run simulation
clock = 0;
render_clean();
while clock <= clockmax
  clock = clock + 1;
  con_static_ib2d_step();

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
