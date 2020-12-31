function res=doesLinkWall(id, links, wall_links)
if links(1, id) ~= 1 && links(2, id) ~= 1
  res = 0;
  return
end
res = ismember(id, wall_links(1, :));
