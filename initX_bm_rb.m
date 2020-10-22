init_circle_r = .25;
init_circle_x = 0.5;
init_circle_y = 0.5;
dtheta = h / 2; % IB point spacing
Nb = ceil(pi * 2 * init_circle_r / dtheta);   % Number of IB points
links = zeros(2, Nb);
links(1, :) = [(2:Nb), 1]; % IB index shifted left
links(2, :) = [Nb, (1:(Nb-1))]; % IB index shifted right
wall_links = zeros(2, 0);  % special points that attach to the wall

theta = linspace(0, pi*2, Nb + 1)';
theta = theta(1 : end-1);
X = [init_circle_x, init_circle_y] + init_circle_r * [sin(theta), cos(theta)];
