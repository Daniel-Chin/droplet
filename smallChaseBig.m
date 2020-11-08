clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
clearBackup;
defineConstants();
tmax = .5;
dt = 0.00005;
THING_FOUR = 2.5;
L = L * THING_FOUR;
N = N * THING_FOUR * .75;
VERTICAL_FLOW = 0;

initialize();
RENDER_DEBUG = 0;
init_a();
n_init_droplets = 2;
init_circle_rad = [.25, .27];
init_circle_pos = zeros(2, 2);
init_circle_pos(1, :) = [0, L - .5];
init_circle_pos(2, :) = [0, L - 1.4];
initX_multi_half_circles();
initInertiaNew();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();

  % if clock > 3160
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
