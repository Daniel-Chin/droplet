hold on;
axis equal
axis manual
axis([0, .5, .6, 1.6])
for x = [.1 .2 .3 .4 .5]
  line([x x], ylim(), 'Color', [.5 .5 .5]);
end
for y = [.6 .8 1 1.2 1.4 1.6]
  line(xlim(), [y y], 'Color', [.5 .5 .5]);
end
plot(X4(:,1),X4(:,2),'c.')
plot(X2(:,1),X2(:,2),'k.')
for j = 1 : Nb
  if doesLinkWall(j, links, wall_links)
    continue;
  end
  k = links(1, j);
  if k > j
    plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 2);
  end
  k = links(2, j);
  if k > j
    plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'b', 'LineWidth', 2);
  end
end
title(sprintf('$G$ = %.0f\n', big_G), 'interpreter', 'latex');
hold off
