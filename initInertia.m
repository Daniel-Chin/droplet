% Using pIB to simulate water-air density difference

pIB_STIFF = 1; % change so that max|X−Y| <= h/10

dtheta4 = h / 2;
estimated_area = (init_circle_r / dtheta4) ^ 2 * pi / 2 + (init_circle_r_2 / dtheta4) ^ 2 * pi / 2;
X4 = zeros(floor(estimated_area * .7), 2);
Nb4 = 0;
for i = 0 : dtheta4 : L
  for j = 0 : dtheta4 : L
    if norm([i-init_circle_x, j-init_circle_y]) < init_circle_r
      Nb4 = Nb4 + 1;
      X4(Nb4, :) = [i, j];
    end
    if norm([i-init_circle_x_2, j-init_circle_y_2]) < init_circle_r_2
      Nb4 = Nb4 + 1;
      X4(Nb4, :) = [i, j];
    end
  end
end

Y4 = X4;
V4 = zeros(Nb4, 2);
MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;
