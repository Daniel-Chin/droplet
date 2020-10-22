% spactial resolution convergence test: IBM, but only spreading X4 force
L=2.0; % Box size, cm

% N=64; % Number of grid cells
% N=96; % Number of grid cells
N=128; % Number of grid cells

dt=0.02; % Time step, second
rho = 1; % air density g/cm2
mu = 0.01; % viscosity g/s. divide by rho. 

tmax=5; % Run until time s
clockmax=ceil(tmax/dt);

RESAMPLE_AMEND = .5;

WALL_EXISTS = 0;

VERTICAL_FLOW = 0;
rho_heavy=.1; % density g/cm2

Nb3_space = round(N / 32);  % spacing of visual indicators
