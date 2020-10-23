% Using pIB to simulate water-air density difference

dtheta4 = h / 2;
X4 = zeros(10, 2);
Nb4 = 0;
for i = dtheta4/2 : dtheta4 : L / 2
  for j = dtheta4/2 : dtheta4 : L
    if norm([i-init_circle_x, j-init_circle_y]) > init_circle_r
      Nb4 = Nb4 + 1;
      X4(Nb4, :) = [i, j];
    end
  end
end

MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;
Y4 = X4;
Y4 = X4 + [0, - MASS_PER_POINT * big_G / pIB_STIFF];
V4 = zeros(Nb4, 2);

dtheta5 = h / 2;
X5 = zeros(10, 2);
Nb5 = 0;
for i = 0 : dtheta5 : L / 2
  for j = 0 : dtheta5 : L
    if norm([i-init_circle_x, j-init_circle_y]) < init_circle_r
      Nb5 = Nb5 + 1;
      X5(Nb5, :) = [i, j];
    end
  end
end
