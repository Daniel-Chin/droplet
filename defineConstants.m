dt = 0.005; % Time step, second
N = 64; % Number of grid cells
L = 2.0; % Box size, cm

K = .2; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
WALL_STIFFNESS = 60;
WALL_LINKER_TO_WALL_STIFF = 200;
rho = .1; % air density g/cm2
rho_heavy = 1; % density g/cm2
mu = .002; % viscosity g/s. 2D water can be 0.00089
tmax = 4; % Run until time s
big_G = 980; % cm/s2
NO_SLIP_FORCE = 0;
FRICTION_ADJUST = 1;
SLIP_LENGTH_UNITS = 6;

pIB_STIFF = 2; % change so that max|X−Y| <= h/10

VERTICAL_FLOW = 1;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;

Nb3_space = round(N / 16);  % spacing of visual indicators
