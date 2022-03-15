close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;

for SIZE = [.18 .2 .25]
  defineConstants();
  tmax = .15; % Run until time s
  initialize();
  OUTPUT_PLACE = strrep(getenv('h'), '\', '/') + sprintf("/d/IBM_Space/size_effect/output_%f", SIZE*2);
  mkdir(OUTPUT_PLACE);
  OUTPUT_PATH = OUTPUT_PLACE + "/%d.png";
  RECORD_PLACE = strrep(getenv('h'), '\', '/') + sprintf("/d/IBM_Space/size_effect/record_%f", SIZE*2);
  mkdir(RECORD_PLACE);
  RECORD_PATH = RECORD_PLACE + "/%d.mat";
  RENDER_DEBUG = 0;
  init_a();
  n_init_droplets = 1;
  init_circle_rad = [SIZE];
  init_circle_pos = zeros(1, 2);
  init_circle_pos(1, :) = [0, L * 0.8];
  initX_multi_half_circles();
  initInertiaNew();
  % plot(0);
  % hold on;
  % render_phase = SPF - dt;
  render();
  while clock < clockmax
    clock = clock + 1;
    step();
  end
end
