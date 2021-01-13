equiDefineConstants();
initialize();
init_a();
n_init_droplets = 1;
init_circle_rad = [.35];
init_circle_pos = zeros(1, 2);
init_circle_pos(1, :) = [0, L * 0.6];
initX_multi_half_circles();
initInertiaNew();

%% Run simulation
render();
while clock < clockmax
  clock = clock + 1;
  step();

  if schedule_next_frame_pause
    pause;
  end
end

equiDoIt;
