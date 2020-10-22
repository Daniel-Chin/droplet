% Benchmark: Rising Bubble
L=2.0; % Box size, cm

% N=64; % Number of grid cells
N=96; % Number of grid cells

% too much hack!
% dt=0.004; % Time step, second
% K=24.5 * 13; % Surface tension coefficient, N*10^-5
% WALL_STIFFNESS = 400000;
% rho=100; % air density g/cm2
% mu = 10 * 0.2; % viscosity g/s. 2D water can be 0.00089
% big_G = .98 * 15.5; % cm/s2
% pIB_STIFF = 5000; % change so that max|X−Y| <= h/10

% test case 1
dt=0.004; % Time step, second
K=24.5 * 1; % Surface tension coefficient, N*10^-5
WALL_STIFFNESS = 60000;
rho = 100 / 10; % air density g/cm2
mu = 10 / 100 / (10^.5); % viscosity g/s. divide by rho. 
big_G = .98 * 10; % cm/s2
pIB_STIFF = 600; % change so that max|X−Y| <= h/10

% test case 2
% dt=0.002; % Time step, second
% K=24.5 * 1; % Surface tension coefficient, N*10^-5
% WALL_STIFFNESS = 3000;
% rho = 1 / 10; % air density g/cm2
% mu = 10 / 10 / (10^.5); % viscosity g/s. divide by rho. 
% big_G = .98 * 10; % cm/s2
% pIB_STIFF = 400; % change so that max|X−Y| <= h/10

% FAKE_REPEL_K = .00001;
WALL_LINKER_TO_WALL_STIFF = 0;
rho_heavy=1000 / 10; % density g/cm2
% rho_heavy=1000; % density g/cm2
tmax=3; % Run until time s
clockmax=ceil(tmax/dt);
NO_SLIP_FORCE = 0;
FRICTION_ADJUST = 1;
SLIP_LENGTH = 6 * h;
SLIP_LENGTH_COEF = h / SLIP_LENGTH;

VERTICAL_FLOW = 0;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 1;
