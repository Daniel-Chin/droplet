if save_render_i > 0
  % saveas(gcf, sprintf(OUTPUT_PATH, save_render_i));
else
  pause(1);
end
save_render_i = save_render_i + 1;
