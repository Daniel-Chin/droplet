%initialize.m
%% Initialize Parameters and special indices

dt=0.0002; % Time step, second
N=96; % Number of grid cells
L=3.0; % Box size, cm
h=L/N; % Grid spacing
ip=[(2:N),1]; % Grid index shifted left
im=[N,(1:(N-1))]; % Grid index shifted right

Nb2=ceil(L / (h*.5)); % Number of IB points
dtheta2=L / Nb2; % IB point spacing

Nb3_space = 8;
Nb3x = floor((N/2 / Nb3_space));
Nb3y = floor((N / Nb3_space));
Nb3 = Nb3x * Nb3y; % Number of IB points
dtheta3 = h * Nb3_space; % IB point spacing

K=20; % Surface tension coefficient, N*10^-5
% FAKE_REPEL_K = .00001;
WALL_STIFFNESS = 600;
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
dvorticity = 50;
values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
valminmax=[min(values),max(values)];  % for plotting vortocity

%% Initialize boundary and velocity
k2=0:(Nb2-1);
theta2 = k2'*dtheta2;
X2 = zeros(Nb2, 2);  % first column has fluid value and wall
X2(:, 2) = theta2;
PERFECT_WALL = X2;

X3 = zeros(Nb3y, Nb3y, 2);
theta3 = (1:Nb3y) * dtheta3;
for j=1:Nb3y
  X3(j, :, 1) = theta3;
  X3(:, j, 2) = theta3';
end
X3 = reshape(X3(:, 1:Nb3x, :), Nb3, 2);

u=zeros(N,N,2);

%% Initialize animation
% vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
% dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
% values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
% valminmax=[min(values),max(values)];
xgrid=zeros(N/2,N);
ygrid=zeros(N/2,N);
for j=0:(N-1)
  if j < N/2
    xgrid(j+1,:)=j*h;
  end
  ygrid(:,j+1)=j*h;
end

set(gcf,'double','on')

MIRROR = ones(1, 1, 2);
MIRROR(1, 1, 1) = -1;
VERTICAL_FLOW = 1;
VERTICAL_FLOW_ROW = VERTICAL_FLOW * tanh(linspace(0, 20, N/2 - 1));

save_render_i = 0;

fprintf('Static friction goodness (shuold be >> 0 and < .5): %f\n', ...
  NO_SLIP_FORCE*SLIP_LENGTH_COEF / (dtheta2*WALL_STIFFNESS/2) ...
);

schedule_next_frame_pause = false;

RESAMPLE_AMEND = .5;
resample_energy_offset = 0;
resample_energy_offset_array = [];
resample_energy_offset_array_size = 0;

FPS = 60 * 20;
TIMESTEPS_PER_FRAME = round(1 / dt / FPS);
display(TIMESTEPS_PER_FRAME);
render_phase = 0;

N_PAST_EXTREME_VELOCITY = 5;
past_extreme_velocity = zeros(1, N_PAST_EXTREME_VELOCITY);
past_extreme_velocity_cursor = 1;

SPLICE_THRESHOLD = h;
SPLICE_WALL_THRESHOLD = h * 2;

WALL_EXISTS = 1;
