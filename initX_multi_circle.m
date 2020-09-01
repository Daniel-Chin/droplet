% Six droplets merging

dtheta = h / 2; % IB point spacing
circle_n_points = ceil(pi * 2 * init_circle_rad / dtheta);
Nb = sum(circle_n_points);

links = zeros(2, Nb);
wall_links = zeros(2, 0);  % special points that attach to the wall
X = zeros(Nb, 2);

offset = 0;
for j = 1 : n_init_droplets
  n = circle_n_points(j);
  % 1 clockwise, 2 counter-clockwise
  theta = linspace(0, pi*2, n+1)';
  theta = theta(1:end-1); % prevent points form overlapping
  X(offset+1 : offset+n, :) = init_circle_pos(j, :) + init_circle_rad(j) * [sin(theta), cos(theta)];
  for k = 1 : n
    links(1, offset + k) = offset + k + 1;
    links(2, offset + k) = offset + k - 1;
  end
  links(2, offset + 1) = offset + n;
  links(1, offset + n) = offset + 1;
  offset = offset + n;
end
