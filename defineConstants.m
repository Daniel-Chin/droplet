dt = 0.00002; % Time step, second
N = 96; % Number of grid cells
L = 2.0; % Box size, cm

K = 20; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
rho = .1; % air density g/cm2
rho_heavy = 1; % density g/cm2
mu = .002; % viscosity g/s. 2D water can be 0.00089
tmax = 4; % Run until time s
big_G = 980; % cm/s2
NO_SLIP_FORCE = 100;
FRICTION_ADJUST = 100;
SLIP_LENGTH_UNITS = 6;

WALL_STIFFNESS = 22000;
WALL_LINKER_TO_WALL_STIFF = 20000;
pIB_STIFF = 10000; % change so that max|X−Y| <= h/10

VERTICAL_FLOW = 0;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;

Nb3_space = round(N / 16);  % spacing of visual indicators
