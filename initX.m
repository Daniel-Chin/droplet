% one droplet on wall
init_circle_r = L * .1;
init_circle_x = L/4;
init_circle_y = L * 0.8;
init_circle_r_2 = L * .08;
init_circle_x_2 = L/4;
init_circle_y_2 = L * 0.2;

dtheta = h / 2; % IB point spacing
circle_1_n_points = ceil(pi * 2 * init_circle_r / dtheta);
circle_2_n_points = ceil(pi * 2 * init_circle_r_2 / dtheta);
Nb = circle_1_n_points + circle_2_n_points;  % Number of IB points

links = zeros(2, Nb);
links(1, :) = [(2:Nb), 1]; % IB index shifted left
links(2, :) = [1, (1:(Nb-1))]; % IB index shifted right
links(1, circle_1_n_points) = 1;
links(2, circle_1_n_points + 1) = 1;

wall_links = zeros(2, 4);  % special points that attach to the wall
wall_links(:, 1) = [1;  1];
wall_links(:, 2) = [circle_1_n_points; 2];
wall_links(:, 3) = [circle_1_n_points + 1; 1];
wall_links(:, 4) = [Nb; 2];

X = zeros(Nb, 2);

theta = linspace(0, pi*2, circle_1_n_points)';
X(1:circle_1_n_points, :) = [init_circle_x, init_circle_y] + init_circle_r * [sin(theta), cos(theta)];

theta = linspace(0, pi*2, circle_2_n_points)';
X(circle_1_n_points+1:end, :) = [init_circle_x_2, init_circle_y_2] + init_circle_r_2 * [sin(theta), cos(theta)];
