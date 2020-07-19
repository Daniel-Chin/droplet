X(holeToFill, :) = X(Nb, :);
links(:, holeToFill) = links(:, Nb);
links(1, links(2, holeToFill)) = holeToFill;
links(2, links(1, holeToFill)) = holeToFill;
Nb = Nb - 1;
