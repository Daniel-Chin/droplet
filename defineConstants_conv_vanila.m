% spactial resolution convergence test: vanilla NS solver
L=2.0; % Box size, cm

% N=64; % Number of grid cells
% N=128; % Number of grid cells
N=196; % Number of grid cells

dt=0.02; % Time step, second
rho = 1; % air density g/cm2
mu = 0.01; % viscosity g/s. divide by rho. 

tmax=5; % Run until time s
clockmax=ceil(tmax/dt);

RESAMPLE_AMEND = .5;

WALL_EXISTS = 0;

VERTICAL_FLOW = 1;

Nb3_space = 4;  % spacing of visual indicators
