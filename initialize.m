%initialize.m
%% Initialize Parameters and special indices

% dt=0.01 % Time step
dt=0.003; % Time step
N=128; % Number of grid cells
L=2.0; % Box size
h=L/N; % Grid spacing
ip=[(2:N),1]; % Grid index shifted left
im=[N,(1:(N-1))]; % Grid index shifted right

% Nb=ceil(pi*(L/2)/(h/2)) % Number of IB points
% dtheta=2*pi/Nb % IB point spacing
% kp=[(2:Nb),1] % IB index shifted left
% km=[Nb,(1:(Nb-1))] % IB index shifted right
Nb=ceil(pi*(L/4) / (h*.5)); % Number of IB points
dtheta=pi*(L/4) / Nb; % IB point spacing
kp=[(2:Nb),1]; % IB index shifted left
km=[Nb,(1:(Nb-1))]; % IB index shifted right

Nb2=ceil((L+1) / (h*.5)); % Number of IB points
dtheta2=L / Nb2; % IB point spacing

% DROPLET_LEFT = 

K=1; % Elastic stiffness
WALL_STIFFNESS = 1000;
NAIL_STIFF = 500;
rho=1; % Fluid density
mu=0.01; % viscosity
tmax=4; % Run until time
clockmax=ceil(tmax/dt);

%% Initialize boundary and velocity
k=0:(Nb-1);
theta = k'*dtheta;
X = [L*0.00, L/2] + (L/8)*[sin(theta*2), cos(theta*2)];
NAILS = [X(1, :); X(end, :)];

k2=0:(Nb2-1);
theta2 = k2'*dtheta2;
X2 = zeros(Nb2, 2);  % first column has fluid value and wall
X2(:, 2) = theta2;
PERFECT_WALL = X2;

u=zeros(N,N,2);
% j1=0:(N-1); % Initialize fluid velocity as (0,sin(2*pi*x/L))
% x=j1'*h;
% u(j1+1,:,2)=sin(2*pi*x/L)*ones(1,N);
% u(j1+1,:,2)=sin(2*pi*x/L)*ones(1,N) * (-1);

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
% contour(xgrid,ygrid,vorticity,values)
% hold on
% plot(X(:,1),X(:,2),'ko')
% plot(X2(:,1),X2(:,2),'ko')
% plot(X3(:,1),X3(:,2),'ko')
% axis([0,L,0,L])
% caxis(valminmax)
% axis equal
% axis manual
% drawnow
% hold off

MIRROR = ones(1, 1, 2);
MIRROR(1, 1, 1) = -1;
VERTICAL_FLOW = 1;

gravity_helper = ones(Nb, 2);
gravity_frontier = [];
gravity_per_cell = - 1200 * h; % should be related to density and h

render_i = 0;
