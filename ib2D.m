% ib2D.m
% This script is the main program.
% Original Code by Charlie Peskin:
% https://www.math.nyu.edu/faculty/peskin/ib_lecture_notes/index.html
% Vectorized and commented by Tristan Goodwill,2019.4
% Gravity, multi-phase, wall, surface tension by Daniel Chin
%% Initialize simulation
clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE;
global big_G;
clearBackup;
defineConstants();
initialize();
init_a();
n_init_droplets = 1;
init_circle_rad = [.25];
init_circle_pos = zeros(1, 2);
init_circle_pos(1, :) = [0, L * 0.8];
initX_multi_half_circles();
initInertiaNew();

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
