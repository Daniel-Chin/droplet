clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants_bm_fd();
initialize();

init_a();
initX_bm_fd();
initInertia();

%% Run simulation
clock = 0;

render();
while clock <= clockmax
  clock = clock + 1;
  step_bm_fd();

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
