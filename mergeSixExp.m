clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
initialize();
init_a();
initX_multi_circle();
initInertiaNew();
big_G = 1000;

%% Run simulation
tmax=.2; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
mergeSixExpLoop;
