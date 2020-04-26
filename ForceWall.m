function [F, new_X2]=ForceWall(XX2, K, PERFECT_WALL, u, X, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h)
% penalty
F=K*(PERFECT_WALL - XX2);
new_X2 = X2;

contact_line_velocity = vec_interp(u, X, Nb);
upper_velocity = contact_line_velocity(1, 2);
lower_velocity = contact_line_velocity(end, 2);

upper_tangent = X(2, :) - X(1, :);
upper_angle = pi/2 + atan(upper_tangent(2) / upper_tangent(1));
upper_static_limit = friction(upper_angle, upper_velocity, true, NO_SLIP_FORCE) * SLIP_LENGTH_COEF;

lower_tangent = X(end-1, :) - X(end, :);
lower_angle = pi/2 - atan(lower_tangent(2) / lower_tangent(1));
lower_static_limit = friction(lower_angle, lower_velocity, false, NO_SLIP_FORCE) * SLIP_LENGTH_COEF;

y_mid = (X(1, 2) + X(end, 2)) / 2;
for j=1:Nb2
  if XX2(j, 2) > y_mid
    the_limit = upper_static_limit;
  else
    the_limit = lower_static_limit;
  end
  intention = F(j, 2);
  if intention / the_limit > 1
    fprintf('Slip! y=%.1f, level=%.2f \n', j * h, intention / the_limit);
    F(j, 2) = the_limit;
    new_X2(j, 2) = PERFECT_WALL(j, 2) - the_limit / K;
  end
end
