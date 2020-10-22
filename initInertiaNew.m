% Using pIB to simulate water-air density difference

dtheta4 = h / 2;
estimated_area = 0;
for k = 1 : n_init_droplets
  estimated_area = estimated_area + (init_circle_rad(k) / dtheta4) ^ 2 * pi;
end
X4 = zeros(floor(estimated_area * .7), 2);
Nb4 = 0;
for i = 0 : dtheta4 : L
  for j = 0 : dtheta4 : L
    for k = 1 : n_init_droplets
      if norm([i, j] - init_circle_pos(k, :)) < init_circle_rad(k)
        Nb4 = Nb4 + 1;
        X4(Nb4, :) = [i, j];
        break;
      end
    end
  end
end
X4 = X4(1:Nb4, :);

Y4 = X4;
V4 = zeros(Nb4, 2);
MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;
