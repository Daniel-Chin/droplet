% dt = 0.0005; % Time step, second
% N = 96; 
% pIB_STIFF_per_mass = 25000; % change so that max|X−Y| <= h/10

% dt = 0.0003; % Time step, second
% N = 128;
% pIB_STIFF_per_mass = 25000; % change so that max|X−Y| <= h/10

dt = 0.0001; % Time step, second
N = 192;
pIB_STIFF_per_mass = 40000; % change so that max|X−Y| <= h/10

L = 10.0; % Box size, cm
K = 50; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
rho = .1; % air density g/cm2
rho_heavy = 1; % density g/cm2
mu = .01; % viscosity g/s. 2D water can be 0.00089
tmax = 2; % Run until time s
big_G = 980; % cm/s2
NO_SLIP_FORCE = 10;
FRICTION_ADJUST = 0;
WALL_SPACING = .5;
SLIP_LENGTH_UNITS = 3 / WALL_SPACING;

WALL_STIFFNESS = 4200;
WALL_LINK_STIFF = 200;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;

NAILS = [.17, .4; .83, .4] * L;
