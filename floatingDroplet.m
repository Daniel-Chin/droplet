clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;

defineConstants();
WALL_EXISTS = 0;
VERTICAL_FLOW = 0;
big_G = 0; % cm/s2
tmax = .45;
% dt = 0.0001; % Time step, second
% N = 64; % Number of grid cells
dt = 0.00005; % Time step, second
N = 128; % Number of grid cells
L = 1;
pIB_STIFF = 700;

initialize();
% RENDER_DEBUG = 0;
init_a();
n_init_droplets = 1;
init_circle_rad = [.2];
init_circle_pos = zeros(1, 2);
init_circle_pos(1, :) = [L * .5, L * 0.5];
initX_multi_circle();
initInertiaNew();

xgrid=zeros(N,N);
ygrid=zeros(N,N);
for j=0:(N-1)
  xgrid(j+1,:)=j*h;
  ygrid(:,j+1)=j*h;
end

%% Run simulation
clock = 0;
render_wide();
area_his = [];
area_his_i = 0;
while clock < clockmax
  clock = clock + 1;
  step_wide();
  calcArea();
  area_his_i = area_his_i + 1;
  area_his(area_his_i) = droplet_area;

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
