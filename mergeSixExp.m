clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
clearBackup;

defineConstants();
% rho_heavy = 2; % density g/cm2
initialize();
OUTPUT_PATH = 'E:/IBM_Space/output/%d.png';
Nb3x = floor((N / Nb3_space));
Nb3y = floor((N / Nb3_space));
Nb3 = Nb3x * Nb3y; % Number of IB points
dtheta3 = h * Nb3_space; % IB point spacing
X3 = zeros(Nb3y, Nb3y, 2);
theta3 = (1:Nb3y) * dtheta3;
for j=1:Nb3y
  X3(j, :, 1) = theta3;
  X3(:, j, 2) = theta3';
end
X3 = reshape(X3(:, 1:Nb3x, :), Nb3, 2);

xgrid=zeros(N,N);
ygrid=zeros(N,N);
for j=0:(N-1)
  xgrid(j+1,:)=j*h;
  ygrid(:,j+1)=j*h;
end

init_a();
WALL_EXISTS = 0;
% dvorticity = 5;
% values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
% valminmax=[min(values),max(values)];  % for plotting vortocity

n_init_droplets = 6;
init_circle_rad = ones(n_init_droplets, 1) * L * .06;
init_circle_pos = zeros(n_init_droplets, 2);

for j = 1 : n_init_droplets
  % theta = 2 * pi / n_init_droplets * j;
  theta = 2 * pi / n_init_droplets * j + pi / 9;
  % theta = 2 * pi / n_init_droplets * j + pi / 6;
  % off_center = L * .2;
  off_center = L * (.16 + j * .02);
  init_circle_pos(j, :) = [L/2, L/2] + off_center * [cos(theta), sin(theta)];
end

initX_multi_circle();
initInertiaNew();
big_G = .5;

%% Run simulation
tmax = 3.5; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render_wide();
mergeSixExpLoop;
