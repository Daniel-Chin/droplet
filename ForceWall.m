function [F, new_X2]=ForceWall(XX2, K, PERFECT_WALL, u, X, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF)
% penalty
F=K*(PERFECT_WALL - XX2);
new_X2 = X2;

contact_line_velocity = vec_interp(u, X, Nb);
recede_velocity = contact_line_velocity(1, 2);
advance_velocity = contact_line_velocity(end, 2);

recede_tangent = X(2, :) - X(1, :);
recede_angle = pi/2 + atan(recede_tangent(2) / recede_tangent(1));
recede_static_limit = friction(recede_angle, recede_velocity, false, NO_SLIP_FORCE) * SLIP_LENGTH_COEF;

advance_tangent = X(end-1, :) - X(end, :);
advance_angle = pi/2 - atan(advance_tangent(2) / advance_tangent(1));
advance_static_limit = friction(advance_angle, advance_velocity, true, NO_SLIP_FORCE) * SLIP_LENGTH_COEF;

y_mid = (X(1, 2) + X(end, 2)) / 2;
for j=1:Nb2
  if XX2(j, 2) > y_mid
    recede_static = F(j, 2);
    if recede_static / recede_static_limit > 1
      F(j, 2) = recede_static_limit;
      new_X2(j, 2) = PERFECT_WALL(j, 2) - recede_static_limit / K;
    end
  else
    advance_static = F(j, 2);
    if advance_static / advance_static_limit > 1
      % disp(j);disp(advance_static / advance_static_limit);
      F(j, 2) = advance_static_limit;
      new_X2(j, 2) = PERFECT_WALL(j, 2) - advance_static_limit / K;
    end
  end
end
