id = links(1, startid);
j = 1;
while id ~= startid
  j = j + 1;
  id = links(1, id);
end
% plot(points(:,1),points(:,2),'ko');
