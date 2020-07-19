if holeToFill == Nb

else
  X(holeToFill, :) = X(Nb, :);
  links(:, holeToFill) = links(:, Nb);
  % in case moved a wall point into hole
  if any(links(:, Nb) == 1) && any(wall_links(1, :) == Nb)
    wall_links_l_i = wall_links(1, :) == Nb;
    wall_links(1, wall_links_l_i) = holeToFill;
    direction = wall_links(2, wall_links_l_i);
    links(3 - direction, links(direction, holeToFill)) = holeToFill;
  else
    links(1, links(2, holeToFill)) = holeToFill;
    links(2, links(1, holeToFill)) = holeToFill;
  end
end
Nb = Nb - 1;
