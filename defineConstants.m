dt = 0.0001; % Time step, second
N = 96; % Number of grid cells
% N = 128; % Number of grid cells
L = 2.0; % Box size, cm

K = 30; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
rho = .1; % air density g/cm2
rho_heavy = 1; % density g/cm2
mu = .01; % viscosity g/s. 2D water can be 0.00089
tmax = .1; % Run until time s
big_G = 980; % cm/s2
NO_SLIP_FORCE = 25;
FRICTION_ADJUST = 30;
WALL_SPACING = .5;
SLIP_LENGTH_UNITS = 3 / WALL_SPACING;

WALL_STIFFNESS = 5000;
WALL_LINKER_TO_WALL_STIFF = 5000;
pIB_STIFF = 500; % change so that max|X−Y| <= h/10

VERTICAL_FLOW = 0;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;
