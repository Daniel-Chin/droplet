% Two wall droplets merging

dtheta = h / 2; % IB point spacing
circle_n_points = ceil(pi * init_circle_rad / dtheta);
Nb = sum(circle_n_points);

links = zeros(2, Nb);
wall_links = zeros(2, n_init_droplets * 2);  % special points that attach to the wall
X = zeros(Nb, 2);

offset = 0;
for j = 1 : n_init_droplets
  n = circle_n_points(j);
  % 2 clockwise, 1 counter-clockwise
  theta = linspace(-pi/2, pi/2, n)';
  X(offset+1 : offset+n, :) = init_circle_pos(j, :) + init_circle_rad(j) * [cos(theta), sin(theta)];
  for k = 1 : n
    links(1, offset + k) = offset + k + 1;
    links(2, offset + k) = offset + k - 1;
  end
  links(2, offset + 1) = 1;
  links(1, offset + n) = 1;
  wall_links(:, j * 2 - 1) = [offset + 1, 1];
  wall_links(:, j * 2    ) = [offset + n, 2];
  offset = offset + n;
end
