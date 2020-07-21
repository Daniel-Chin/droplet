%initialize.m
%% Initialize Parameters and special indices

dt=0.002; % Time step
N=256; % Number of grid cells
L=2.0; % Box size
h=L/N; % Grid spacing
ip=[(2:N),1]; % Grid index shifted left
im=[N,(1:(N-1))]; % Grid index shifted right

initX();

Nb2=ceil((L+1) / (h*.5)); % Number of IB points
dtheta2=L / Nb2; % IB point spacing

Nb3_space = 8;
Nb3x = floor((N/2 / Nb3_space));
Nb3y = floor((N / Nb3_space));
Nb3 = Nb3x * Nb3y; % Number of IB points
dtheta3 = h * Nb3_space; % IB point spacing

K=0.3; % Surface tension coefficient
FAKE_REPEL_K = .00001;
WALL_STIFFNESS = 35;
rho=.0013; % air density
rho_heavy=1; % water density
mu=0.0001; % viscosity
tmax=6; % Run until time
clockmax=ceil(tmax/dt);
big_G = 6;

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

initInertia;

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

% no initial u
dvorticity=8.5;
values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
valminmax=[min(values),max(values)];

set(gcf,'double','on')

MIRROR = ones(1, 1, 2);
MIRROR(1, 1, 1) = -1;
VERTICAL_FLOW = 1;
VERTICAL_FLOW_ROW = VERTICAL_FLOW * tanh(linspace(0, 20, N/2 - 1));

render_i = 0;

NO_SLIP_FORCE = .1;
FRICTION_ADJUST = .1;
SLIP_LENGTH = .04;
SLIP_LENGTH_COEF = h / SLIP_LENGTH;

fprintf('Static friction goodness (shuold be >> 0 and < .5): %f\n', ...
  NO_SLIP_FORCE*SLIP_LENGTH_COEF / (dtheta2*WALL_STIFFNESS/2) ...
);

schedule_next_frame_pause = false;
