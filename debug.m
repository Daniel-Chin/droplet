startid = 140;

id = links(2, startid);
points = [];
points_i = 0;
while id ~= startid
  points_i = points_i + 1;
  points(points_i, :) = X(id, :);
  id = links(2, id);
end
plot(points(:,1),points(:,2),'ko');
