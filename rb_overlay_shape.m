lw = .5;

load('rising_bubble/10to10/wall_stiff_8000/final_shape.mat');
bm_triag = stlread("RB_10to10Vis/_vtk/surf_00012.stl");
X = X + [-.5 -.5];
sz = size(bm_triag.Points);

hold off;
trimesh(bm_triag.ConnectivityList, bm_triag.Points(:, 1), bm_triag.Points(:, 2), 'Color', 'b');
hold on;
for j = 1 : Nb
  if doesLinkWall(j, links, wall_links)
    continue;
  end
  k = links(1, j);
  if k > j
    plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'r', 'LineWidth', lw);
  end
  k = links(2, j);
  if k > j
    plot([X(j, 1), X(k, 1)], [X(j, 2), X(k, 2)], 'r', 'LineWidth', lw);
  end
end

axis equal;
view(0, 90);
