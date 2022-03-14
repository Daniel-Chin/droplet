% Compares different static contact angles. 

close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF STATIC_CONTACT_ANGLE; 
global big_G;

for theta_s = pi .* [.3 .5 .7]
  defineConstants();
  tmax = .15; % Run until time s
  STATIC_CONTACT_ANGLE = theta_s;
  initialize();
  OUTPUT_PLACE = sprintf(strrep(getenv('h'), '\', '/') + "/d/IBM_Space/output_%f", theta_s);
  mkdir(OUTPUT_PLACE);
  OUTPUT_PATH = OUTPUT_PLACE + "/%d.png";
  RECORD_PLACE = sprintf(strrep(getenv('h'), '\', '/') + "/d/IBM_Space/record_%f", theta_s);
  mkdir(RECORD_PLACE);
  RECORD_PATH = RECORD_PLACE + "/%d.mat";
  RENDER_DEBUG = 0;
  init_a();
  n_init_droplets = 1;
  init_circle_rad = [.27];
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
