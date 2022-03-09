function f=friction(angle, v, direction, FRICTION_ADJUST)
% v: contact line speed
% advance_or_recede = xor(direction == 2, v < 0);
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
% `FRICTION_ADJUST` is part of $\eta$. 
