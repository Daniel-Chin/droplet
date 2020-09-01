wall_links_pop_ids = sort(wall_links_pop_ids);
for wall_id = wall_links_pop_ids
  wall_links(:, wall_id) = wall_links(:, end);
  wall_links = wall_links(:, 1:end-1);
end
