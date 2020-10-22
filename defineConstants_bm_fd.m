% Benchmark: falling droplet
L=2.0; % Box size, cm

N=64; % Number of grid cells
% N=96; % Number of grid cells
% N=128; % Number of grid cells

dt=0.02; % Time step, second
K=25; % Surface tension coefficient, N*10^-5
rho = 1; % air density g/cm2
rho_heavy = 100; % density g/cm2
mu = 0.01; % viscosity g/s. divide by rho. 
big_G = .98; % cm/s2
pIB_STIFF = 10; % change so that max|X−Y| <= h/10

WALL_STIFFNESS = 0;
% FAKE_REPEL_K = .00001;
WALL_LINKER_TO_WALL_STIFF = 0;
% rho_heavy=1000; % density g/cm2
tmax=2.7; % Run until time s
clockmax=ceil(tmax/dt);
NO_SLIP_FORCE = 0;
FRICTION_ADJUST = 1;
SLIP_LENGTH = 6 * h;
SLIP_LENGTH_COEF = h / SLIP_LENGTH;

VERTICAL_FLOW = 0;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 0;

Nb3_space = 8;  % spacing of visual indicators
