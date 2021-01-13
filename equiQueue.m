clc; clear all; close all;

global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;

big_G = 600; % cm/s2
equiAnalysis;

big_G = 800; % cm/s2
equiAnalysis;

big_G = 1000; % cm/s2
equiAnalysis;

big_G = 1200; % cm/s2
equiAnalysis;
