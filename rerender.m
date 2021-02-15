% render video from records. 

save_render_i = 0;
while 1
  load(sprintf(RECORD_PATH, save_render_i));
  render_phase = SPF;
  disp(save_render_i);
  plot(0);
  render;
end
