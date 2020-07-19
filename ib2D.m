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
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
initialize
init_a

%% Run simulation
clock = 0;
while clock <= clockmax
  clock = clock + 1;
  step();

  % pause(1);

  if clock == floor(1.5 / dt)
    big_G = big_G * 1.3;
  end

  % if clock > 515
  %   pause;
  % end

  if schedule_next_frame_pause
    pause;
  end
end
