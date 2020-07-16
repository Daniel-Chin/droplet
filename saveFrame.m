% saveas(gcf, sprintf('./output/%d.png', render_i));
if render_i > 0
  saveas(gcf, sprintf('E:/IBM_Space/output/%d.png', render_i));
else
  pause(1);
end
render_i = render_i + 1;
