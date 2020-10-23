clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
clearBackup;
defineConstants_bm_rb();
initialize();

Nb2=ceil(L / (h*.5) / 2); % Number of IB points
dtheta2=L / 2 / Nb2; % IB point spacing
k2=0:(Nb2-1);
theta2 = (k2' + .5) * dtheta2;
X2 = zeros(Nb2, 2);
X2(:, 1) = theta2;
X2(:, 2) = L;
PERFECT_WALL = X2;

init_a();
initX_bm_rb();
initInertia_bm_rb();

%% Run simulation
clock = 0;

CM_his = [];
% CM2_his = [];
initial_peri = calcPerimeter(X, Nb, links);
circularity_his = [];
render_bm_rb();
while clock < clockmax
  clock = clock + 1;
  step_bm_rb();

  % pause(1);

  % if clock == floor(.1 / dt)
  %   big_G = big_G * 1.5;
  % end

  % if clock > 515
  %   pause;
  % end
  CM_his(clock) = mean(X5(:, 2));
  % center_mass = CM_his(clock);
  % calcCM;
  % CM2_his(clock) = center_mass;
  circularity_his(clock) = initial_peri / calcPerimeter(X, Nb, links);

  if schedule_next_frame_pause
    pause;
  end
  if mod(clock, 20) == 0
    save(sprintf('E:/IBM_space/backup/%d.mat', clock));
  end
end
