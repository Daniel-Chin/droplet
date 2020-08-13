clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
initialize
init_a

ASG = 5;
for i = 1 : N / 2
  for j = 1 : N
    if norm([i-init_circle_x / h, j-init_circle_y / h]) < init_circle_r / h
      u(i, j, 2) = -ASG;
      u(N - i + 1, j, 2) = -ASG;
    end
    if norm([i-init_circle_x_2 / h, j-init_circle_y_2 / h]) < init_circle_r_2 / h
      u(i, j, 2) = ASG;
      u(N - i + 1, j, 2) = ASG;
    end
  end
end
for i = 1 : Nb4
  % if norm(X4(i, :) - [init_circle_x, init_circle_y]) < init_circle_r
  %   V4(i, 2) = -ASG;
  % end
  if norm(X4(i, :) - [init_circle_x_2, init_circle_y_2]) < init_circle_r_2
    V4(i, 2) = ASG;
  end
end


%% Run simulation
tmax=1; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
while clock <= clockmax
  clock = clock + 1;
  stepMergeExp();

  % pause(1);

  % if clock > 515
  %   pause;
  % end

  if schedule_next_frame_pause
    pause;
  end
end
