clc; clear all; close all;

global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
load 'env';
clearBackup;
defineConstants();
initialize();

%% Run simulation
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
  if mod(clock, 50) == 0
    try
      save(sprintf('E:/IBM_space/backup/%d.mat', clock));
    catch ME
      0;
    end
  end
end
