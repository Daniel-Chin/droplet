clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
initialize();
init_a();


n_init_droplets = 6;
init_circle_rad = ones(n_init_droplets, 1) * L * .06;
init_circle_pos = zeros(n_init_droplets, 2);

for j = 1 : n_init_droplets
  theta = 2 * pi / n_init_droplets * j;
  init_circle_pos(j, :) = [L/4, L/2] + L * .16 * [cos(theta), sin(theta)];
end

initX_multi_circle();
initInertiaNew();
big_G = 1000;

%% Run simulation
tmax=.2; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
mergeSixExpLoop;