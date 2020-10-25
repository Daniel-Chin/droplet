% one droplet on wall
init_circle_r = .25;
% init_circle_r = .42;
% init_circle_r = .5;
init_circle_x = 0;
init_circle_y = L * 0.8;
dtheta = h / 2; % IB point spacing
Nb = ceil(pi * 2 * init_circle_r / 2 / dtheta);   % Number of IB points
links = zeros(2, Nb);
links(1, :) = [(2:Nb), 1]; % IB index shifted left
links(2, :) = [1, (1:(Nb-1))]; % IB index shifted right
wall_links = zeros(2, 2);  % special points that attach to the wall
wall_links(:, 1) = [1;  1];
wall_links(:, 2) = [Nb; 2];

theta = linspace(0, pi, Nb)';
X = [init_circle_x, init_circle_y] + init_circle_r * [sin(theta), cos(theta)];
