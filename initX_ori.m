% one droplet on wall

n_init_droplets = 1;
% init_circle_r = .2;
init_circle_rad = [.25];
% init_circle_r = .3;
init_circle_pos = zeros(1, 2);
init_circle_pos(:) = [0, L * 0.8];
dtheta = h / 2; % IB point spacing
Nb = ceil(pi * 2 * init_circle_rad(1) / 2 / dtheta);   % Number of IB points
links = zeros(2, Nb);
links(1, :) = [(2:Nb), 1]; % IB index shifted left
links(2, :) = [1, (1:(Nb-1))]; % IB index shifted right
wall_links = zeros(2, 2);  % special points that attach to the wall
wall_links(:, 1) = [1;  1];
wall_links(:, 2) = [Nb; 2];

theta = linspace(0, pi, Nb)';
X = [init_circle_pos(1, :)] + init_circle_rad(1) * [sin(theta), cos(theta)];
