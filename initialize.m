%initialize.m
%% Initialize Parameters and special indices

h=L/N; % Grid spacing
ip=[(2:N),1]; % Grid index shifted left
im=[N,(1:(N-1))]; % Grid index shifted right

Nb2=ceil(L / (h*WALL_SPACING)); % Number of IB points
dtheta2=L / Nb2; % IB point spacing

Nb3_space = round(N / 16);  % spacing of visual indicators
Nb3x = floor((N/2 / Nb3_space));
Nb3y = floor((N / Nb3_space));
Nb3 = Nb3x * Nb3y; % Number of IB points
dtheta3 = h * Nb3_space; % IB point spacing

dvorticity = 100;
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
VERTICAL_FLOW_OFFSET = 4;
VERTICAL_FLOW_ROW = VERTICAL_FLOW * tanh(linspace(0, 4, N/2 - VERTICAL_FLOW_OFFSET + 1));

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
SPLICE_WALL_THRESHOLD = h * 2.3;
SPLICE_REJECT_N_STEPS = 2;
splice_reject_remains = 0;

OUTPUT_PATH = strrep(getenv('h'), '\', '/') + "/d/IBM_space/output/%d.png";
RECORD_PATH = strrep(getenv('h'), '\', '/') + "/d/IBM_space/record/%d.mat";

clockmax = ceil(tmax/dt);
clock = 0;

fprintf('Static friction goodness (shuold be >> 0 and < .5): %f\n', ...
  NO_SLIP_FORCE / (dtheta2*WALL_STIFFNESS/2) ...
);

RENDER_DEBUG = 0;
% RENDER_DEBUG = 1;
RENDER_INTERFACE_LINK = 1;
