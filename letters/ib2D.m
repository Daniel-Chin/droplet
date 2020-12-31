clc; clear all; close all;

load 'env';

global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
clearBackup;

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
  if mod(clock, 200) == 0
    try
      save(sprintf('E:/IBM_space/backup/%d.mat', clock));
    catch ME
      0;
    end
  end
end
