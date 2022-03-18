% print: 
% 4 x 6 inches
% pad: -.3, -.2; paper: 3.4 x 5.4

close all;

diams = [0.36 0.4 0.5];
tiledlayout(3, 7, 'Padding', 'loose', 'TileSpacing', 'tight'); 
for row = (1:3)
  for col = (1:7)
    ax = nexttile;
    diameter = diams(row);

    if col == 1
      text(.2, .5, sprintf("%.2f cm", diameter), 'interpreter', 'latex', ...
        'fontsize', 12 ...
      );
      if row == 1
        title("Diameter", 'interpreter', 'latex', 'fontsize', 12, 'position', [.3, 1]);
      end
    else
      t = .03 * (col - 2);
      render_i = round(179 / .15 * t);

      load(strrep(getenv('h'), '\', '/') + sprintf( ...
        "/d/IBM_Space/size_effect/record_%f/%d.mat", diameter, render_i ...
      ));
      if row == 1
        ttl = sprintf("$$%.2f$$ s", t);
        if col == 2
          ttl = "$$t=0$$ s";
        end
        title(ttl, 'interpreter', 'latex', 'fontsize', 12);
      end

      hold on;
      plot(X4(:,1),X4(:,2),'c.','MarkerSize',1);
      plot(X2(:,1),X2(:,2),'k.','MarkerSize',1);
      for j = 1 : Nb
        if doesLinkWall(j, links, wall_links)
          continue;
        end
        k = links(1, j);
        if k > j
          plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 1);
        end
        k = links(2, j);
        if k > j
          plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 1);
        end
      end
      axis equal
      axis manual
      axis([0, L * .16, 0, L])
      drawnow
      hold off
    end

    set(ax, 'xtick', []);
    set(ax, 'xticklabel', []);
    set(ax, 'ytick', []);
    set(ax, 'yticklabel', []);
  
    color = 'w';
    set(ax,'XColor',color,'YColor',color)

    if row == 3 && (col == 4 || col == 7)
      if col == 4
        letter = "(a)";
      else
        letter = "(b)";
      end
      text(0, -.2, letter, 'FontSize', 12, 'interpreter', 'latex');
    end

    formatPlot();
    ax.FontSize = 12;
  end
end
