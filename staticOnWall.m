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
clearBackup;
defineConstants();
VERTICAL_FLOW = 0;
tmax = 1;
dt = 0.0005; % Time step, second
N = 64; % Number of grid cells
L = 1;
WALL_STIFFNESS = 1000;
WALL_LINKER_TO_WALL_STIFF = WALL_STIFFNESS;
pIB_STIFF = 700;
NO_SLIP_FORCE = 9999;

initialize();
RENDER_DEBUG = 0;
init_a();
n_init_droplets = 1;
init_circle_rad = [.2];
init_circle_pos = zeros(1, 2);
init_circle_pos(1, :) = [0, L * 0.5];
initX_multi_half_circles();
initInertiaNew();

%% Run simulation
clock = 0;
render();
area_his = [];
area_his_i = 0;
while clock < clockmax
  clock = clock + 1;
  step();
  % calcArea();
  % area_his_i = area_his_i + 1;
  % area_his(area_his_i) = droplet_area;

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
