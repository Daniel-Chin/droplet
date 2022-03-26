clc; clear all; close all;

global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G STATIC_CONTACT_ANGLE;

exp_name = "equilibrium_conv";

big_G = 1000; % cm/s2
dt = 0.0004; % Time step, second
dt = 0.00005; % Time step, second
N = 24; % Number of grid cells
equiAnalysis;

big_G = 1000; % cm/s2
dt = 0.0002; % Time step, second
dt = 0.00005; % Time step, second
N = 48; % Number of grid cells
equiAnalysis;

big_G = 1000; % cm/s2
dt = 0.0001; % Time step, second
dt = 0.00005; % Time step, second
N = 72; % Number of grid cells
equiAnalysis;

big_G = 1000; % cm/s2
dt = 0.0001; % Time step, second
dt = 0.00005; % Time step, second
N = 96; % Number of grid cells
equiAnalysis;

big_G = 1000; % cm/s2
dt = 0.00005; % Time step, second
N = 192; % Number of grid cells
equiAnalysis;
