%initialize.m
%% Initialize Parameters and special indices

h=L/N; % Grid spacing
ip=[(2:N),1]; % Grid index shifted left
im=[N,(1:(N-1))]; % Grid index shifted right

Nb3_space = round(N / 16);  % spacing of visual indicators
Nb3x = floor((N / Nb3_space));
Nb3y = floor((N / Nb3_space));
Nb3 = Nb3x * Nb3y; % Number of IB points
dtheta3 = h * Nb3_space; % IB point spacing

dvorticity = 40;
values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
valminmax=[min(values),max(values)];  % for plotting vortocity

X3 = zeros(Nb3y, Nb3y, 2);
theta3 = (1:Nb3y) * dtheta3;
for j=1:Nb3y
  X3(j, :, 1) = theta3;
  X3(:, j, 2) = theta3';
end
X3 = reshape(X3, Nb3, 2);

u=zeros(N,N,2);

%% Initialize animation
% vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
% dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
% values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
% valminmax=[min(values),max(values)];
xgrid=zeros(N, N);
ygrid=zeros(N, N);
for j=0:(N-1)
  xgrid(j+1,:)=j*h;
  ygrid(:,j+1)=j*h;
end

% set(gcf,'double','on')

MIRROR = ones(1, 1, 2);
MIRROR(1, 1, 1) = -1;

save_render_i = 0;

schedule_next_frame_pause = false;

resample_energy_offset = 0;
resample_energy_offset_array = [];
resample_energy_offset_array_size = 0;

setFrameRate;

N_PAST_EXTREME_VELOCITY = 5;
past_extreme_velocity = zeros(1, N_PAST_EXTREME_VELOCITY);
past_extreme_velocity_cursor = 1;

SPLICE_THRESHOLD = h;
SPLICE_WALL_THRESHOLD = h * 1.4;
SPLICE_REJECT_N_STEPS = 2;
splice_reject_remains = 0;

OUTPUT_PATH = 'E:/IBM_Space/output/%d.png';

clock = 0;
clockmax = ceil(tmax/dt);

SLIP_LENGTH = SLIP_LENGTH_UNITS * h;
SLIP_LENGTH_COEF = 1 / SLIP_LENGTH_UNITS;

RENDER_DEBUG = 0;
% RENDER_DEBUG = 1;
RENDER_INTERFACE_LINK = 1;

NAILS_DIST = NAILS(2, 1) - NAILS(1, 1);
Nb2 = ceil(NAILS_DIST / (h*WALL_SPACING)); % Number of IB points
dtheta2 = NAILS_DIST / Nb2; % IB point spacing
theta2 = linspace(0, NAILS_DIST, Nb2);
X2 = zeros(Nb2, 2);
X2(:, 1) = theta2 + NAILS(1, 1);
X2(:, 2) = NAILS(1, 2);
kp=[(2:Nb2),1]; % IB index shifted left
km=[Nb2,(1:(Nb2-1))]; % IB index shifted right

% nearest_interface_got = 0;
% we cannot easily cache `nearest_interface` because linked list id unstable.
