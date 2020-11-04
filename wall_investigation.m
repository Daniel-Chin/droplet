clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();
% N = 256; % Number of grid cells
dt = 0.005; % Time step, second
WALL_STIFFNESS = 1;
initialize();
init_a();

% X2(:, 1) = 0.1;
X2(:, :) = X2(:, :) + (rand(Nb2, 2) - .5) * .5;

%% Run simulation
clock = 0;
while clock < clockmax
  clock = clock + 1;
  step_wall_only();

  if schedule_next_frame_pause
    pause;
  end
end
