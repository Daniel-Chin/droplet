if save_render_i == 0
  pause(1);
  drawnow;
end
saveas(gcf, sprintf(OUTPUT_PATH, save_render_i));
save_render_i = save_render_i + 1;
