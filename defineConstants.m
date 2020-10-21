dt=0.0002; % Time step, second
N=96; % Number of grid cells
L=3.0; % Box size, cm

K=.2; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
WALL_STIFFNESS = 600;
WALL_LINKER_TO_WALL_STIFF = 200;
rho=.00013; % air density g/cm2
rho_heavy=.1; % density g/cm2
mu=0.0002; % viscosity g/s. 2D water can be 0.00089
tmax=4; % Run until time s
clockmax=ceil(tmax/dt);
big_G = 980; % cm/s2
NO_SLIP_FORCE = 14;
FRICTION_ADJUST = 1;
SLIP_LENGTH = 6 * h;
SLIP_LENGTH_COEF = h / SLIP_LENGTH;

VERTICAL_FLOW = 1;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;
