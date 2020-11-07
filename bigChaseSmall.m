clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
clearBackup;
defineConstants();
VERTICAL_FLOW = 0;
initialize();
RENDER_DEBUG = 0;
init_a();
n_init_droplets = 2;
init_circle_rad = [.25, .17];
init_circle_pos = zeros(2, 2);
init_circle_pos(1, :) = [0, L * 0.83];
init_circle_pos(2, :) = [0, L * 0.4];
initX_multi_half_circles();
initInertiaNew();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();

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
  if mod(clock, 200) == 0
    try
      save(sprintf('E:/IBM_space/backup/%d.mat', clock));
    catch ME
      0;
    end
  end
end
