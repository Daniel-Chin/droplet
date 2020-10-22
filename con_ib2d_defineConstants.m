% IBM force spreading from tension surface. 

% N=64; % Number of grid cells
% N=128; % Number of grid cells
N=196; % Number of grid cells

dt=0.02; % Time step, second
L=2.0; % Box size, cm
tmax=4; % Run until time s

K=2.5; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
WALL_STIFFNESS = 0;
WALL_LINKER_TO_WALL_STIFF = 0;
rho = 1; % air density g/cm2
mu = 0.01; % viscosity g/s. divide by rho. 

clockmax=ceil(tmax/dt);
VERTICAL_FLOW = 0;

RESAMPLE_AMEND = .5;

WALL_EXISTS = 0;

Nb3_space = round(N / 16);  % spacing of visual indicators
