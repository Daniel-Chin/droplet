startid = 2;

id = links(2, startid);
points = [];
points_i = 0;
up = 0;
down = inf;
out_id = -1;
while id ~= startid
  points_i = points_i + 1;
  points(points_i, :) = X(id, :);
  y = X(id, 2);
  if y < down
    down = y;
    out_id = id;
  end
  if y > up
    up = y;
  end
  id = links(2, id);
end
plot(points(:,1),points(:,2),'ko');
disp(out_id);
