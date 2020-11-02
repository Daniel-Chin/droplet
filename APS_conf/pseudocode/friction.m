function f = friction(angle, v, direction, F_MIN)
% `angle`: contact_angle
% `v`: contact_line_vertical_v
advance_or_recede = xor(direction == 1, v < 0);
if advance_or_recede
  % advance
  if angle > 1.117
    if angle > 2
      mu = 1.54;
    else
      mu = - 8.48 * angle + 18.5;
    end
  else
    mu = - 19.1 * angle + 30.31;
  end
  f = - mu * v;
  if v > 0
    f = f - F_MIN;
  else
    f = f + F_MIN;
  end
else
  % recede
  % not explored by the molecular simulation
  f = 0;
  if v > 0
    f = f - F_MIN;
  else
    f = f + F_MIN;
  end
end
