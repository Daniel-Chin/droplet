function f=friction(angle, v, advance_or_recede, NO_SLIP_FORCE)
% v: contact line speed
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
else
  mu = 0;
end
f = - mu * v * .01;
display(f);
if f < 0
  f = f - NO_SLIP_FORCE;
else
  f = f + NO_SLIP_FORCE;
end
