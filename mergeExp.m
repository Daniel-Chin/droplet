clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
initialize();
init_a();
initX();
initInertia();

ASG = 15;
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
  if norm(X4(i, :) - [init_circle_x, init_circle_y]) < init_circle_r
    V4(i, 2) = -ASG;
  end
  if norm(X4(i, :) - [init_circle_x_2, init_circle_y_2]) < init_circle_r_2
    V4(i, 2) = ASG;
  end
end


%% Run simulation
tmax=1; % Run until time
clockmax=ceil(tmax/dt);
clock = 0;
render();
while clock <= clockmax
  clock = clock + 1;
  stepMergeExp();

  % pause(1);
  if clock == 410
    disp("!!!");
  end
  if clock == 420
    lu = 90;
    ru = links(2, lu);
    ld = 23;
    rd = links(1, ld);
    links(1, ru) = rd;
    links(2, rd) = ru;
    links(1, ld) = lu;
    links(2, lu) = ld;
  end

  if clock > 410
    pause(.1);
  end
  if schedule_next_frame_pause
    pause;
  end
end
