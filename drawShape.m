hold off;
plot(0);
hold on;
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
