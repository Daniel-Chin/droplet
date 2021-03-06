function f=friction(angle, v, direction, NO_SLIP_FORCE, FRICTION_ADJUST)
% v: contact line speed
advance_or_recede = xor(direction == 2, v < 0);
if advance_or_recede
  if angle > 1.117
    if angle > 2
      mu = 1.54;
    else
      mu = - 8.48 * angle + 18.5;
    end
  else
    mu = - 19.1 * angle + 30.31;
  end
  f = - mu * v * FRICTION_ADJUST;
  if v > 0
    f = f - NO_SLIP_FORCE;
  else
    f = f + NO_SLIP_FORCE;
  end
else
  f = 0;
  if v > 0
    f = f - NO_SLIP_FORCE;
  else
    f = f + NO_SLIP_FORCE;
  end
end
