if holeToFill == Nb
  % do nothing
else
  if any(links(:, Nb) == 1) && any(wall_links(1, :) == Nb)
    % move a wall point into hole
    wall_links_l_i = wall_links(1, :) == Nb;
    wall_links(1, wall_links_l_i) = holeToFill;
    direction = wall_links(2, wall_links_l_i);
    links(3 - direction, links(direction, Nb)) = holeToFill;
  else
    links_1_Nb = links(1, Nb);  % Save in case it's a 1-item loop
    links(1, links(2, Nb)) = holeToFill;
    links(2, links_1_Nb) = holeToFill;
  end
  X(holeToFill, :) = X(Nb, :);
  links(:, holeToFill) = links(:, Nb);
end
Nb = Nb - 1;
