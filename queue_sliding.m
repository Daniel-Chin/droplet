close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;

for DT = [0.00005, 0.00002]
  for NN = [96, 128, 192]
    defineConstants();
    tmax = .15; % Run until time s
    dt = DT
    N = NN
    initialize();
    OUTPUT_PLACE = sprintf('E:/IBM_Space/output_%f_%d', DT, NN);
    mkdir(OUTPUT_PLACE);
    OUTPUT_PATH = OUTPUT_PLACE + "/%d.png";
    RECORD_PLACE = sprintf('E:/IBM_Space/record_%f_%d', DT, NN);
    mkdir(RECORD_PLACE);
    RECORD_PATH = RECORD_PLACE + "/%d.mat";
    RENDER_DEBUG = 0;
    init_a();
    n_init_droplets = 1;
    init_circle_rad = [.25];
    init_circle_pos = zeros(1, 2);
    init_circle_pos(1, :) = [0, L * 0.8];
    initX_multi_half_circles();
    initInertiaNew();
    render();
    while clock < clockmax
      clock = clock + 1;
      step();
    end
  end
end
