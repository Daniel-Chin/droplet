% render video from records. 

RENDER_DEBUG = 0;
save_render_i = 0;
while 1
  load(sprintf(RECORD_PATH, save_render_i));
  render_phase = SPF;
  disp(save_render_i);
  plot(0);
  render;
end
