% print: 
% 5.83 x 2.75 inches
% left pad: -0.35. paper width: 5

close all;

tiledlayout(1, 8, 'Padding', 'loose', 'TileSpacing', 'none'); 
for plot_i = (1:8)
  ax = nexttile;
  if plot_i == 1
    left = 220;
  else
    left = 220;
  end
  img_fn = strrep(getenv('h'), '\', '/') + sprintf( ...
    "/d/IBM_Space/big_chase_small/%d.png", plot_i + 1 ...
  );
  img = imread(img_fn);
  image(img(80:end-200, left:400, :));
  ttl = sprintf("$$0.0%d$$ s", plot_i);
  xpos = 60;
  if plot_i == 1
    ttl = "$$t =$$ " + ttl;
    xpos = 30;
  end
  title(ttl, 'interpreter', 'latex', 'position', [xpos, 0]);

  % axis equal
  set(ax, 'xtick', []);
  set(ax, 'xticklabel', []);
  set(ax, 'ytick', []);
  set(ax, 'yticklabel', []);
  
  % set(ax, 'Visible', 'off');
  color = 'w';
  set(ax,'XColor',color,'YColor',color)

  if plot_i == 4 || plot_i == 8
    if plot_i == 4
      letter = "(a)";
    else
      letter = "(b)";
    end
    text(30, 730, letter, 'FontSize', 16, 'interpreter', 'latex');
  end

  formatPlot();
  ax.FontSize = 12;
end
preprint();
