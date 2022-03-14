if any(size(wall_links) ~= [2 2])
  error("Error 35p9w8ghp43");
end

id_0 = wall_links(1, 1);
direction = wall_links(2, 1);
id_1 = links(direction, id_0);
id_2 = links(direction, id_1);

terminal_id = wall_links(1, 2);

curvature_pairs = zeros(0, 2);
curvature_pairs_i = 0;
while terminal_id ~= id_1
  curvature = estimateCurvature(X(id_0, :), X(id_1, :), X(id_2, :));
  if all(X([id_0 id_1 id_2], 1) > L / 24 * 2)
    curvature_pairs_i = curvature_pairs_i + 1;
    curvature_pairs(curvature_pairs_i, :) = [X(id_1, 2), curvature];
  end
  id_0 = id_1;
  id_1 = id_2;
  id_2 = links(direction, id_2);
end
