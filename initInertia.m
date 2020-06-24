% Using pIB to simulate water-air density difference

dtheta4 = h / 2;
estimated_area = (init_circle_r / dtheta4) ^ 2 * pi;
X4 = zeros(floor(estimated_area * .7), 2);
Nb4 = 0;
for i = 1 : dtheta4 : L
  for j = 1 : dtheta4 : L
    if norm([i-init_circle_x, j-init_circle_y]) < init_circle_r
      Nb4 = Nb4 + 1;
      X4(Nb4, :) = [i, j];
    end
  end
end

Y4 = X4;
V4 = zeros(Nb4, 2);
MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;
