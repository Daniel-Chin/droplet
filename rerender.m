% render video from records. 

close all;

RENDER_DEBUG = 0;
save_render_i = 0;
while 1
  load(sprintf(RECORD_PATH, save_render_i));
  render_phase = SPF;
  disp(save_render_i);
  plot(0);
  grid on;
  render;
  if save_render_i < 2
    pause(1);
  end
end
