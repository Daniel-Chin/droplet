function [new_X, new_Nb, kp, km]=surfaceResample(X, Nb, dtheta, u)
threshold = 1.414 * dtheta;
new_X = zeros(size(X));

% take out
started = false;
j = 1;
while j <= Nb
  if started
    if norm(new_X(new_Nb, :) - X(j, :)) > threshold
      new_Nb = new_Nb + 1;
      new_X(new_Nb, :) = X(j - 1, :);
    else
      plot(X(j - 1, 1), X(j - 1, 2), 'ro');
    end
  else
    if X(j, 1) > - dtheta / 2
      new_X(1, :) = X(j, :);
      new_Nb = 1;
      j = j + 1;
      started = true;
    end
  end
  j = j + 1;
end
new_Nb = new_Nb + 1;
new_X(new_Nb, :) = X(end, :);
j = new_Nb;
while new_X(j, 1) < - dtheta / 2
  new_Nb = new_Nb - 1;
  j = j - 1;
end

% grow head/tail
if new_X(1, 1) > dtheta / 2
  v = vec_interp(u, new_X(1, :), 1);
  new_X(2:new_Nb+1, :) = new_X(1:new_Nb, :);
  new_Nb = new_Nb + 1;
  new_X(1, :) = new_X(2, :) - v ./ norm(v) * dtheta;
end
if new_X(new_Nb, 1) > dtheta / 2
  v = vec_interp(u, new_X(new_Nb, :), 1);
  v = v ./ norm(v);
  v(1) = max(.1, v(1)); % safeguard
  new_Nb = new_Nb + 1;
  new_X(new_Nb, :) = new_X(new_Nb - 1, :) - v * dtheta;
  % plot(new_X(new_Nb, 1), new_X(new_Nb, 2), 'bo');
end

% put in
j = 1;
while j <= new_Nb - 1
  space = norm(new_X(j, :) - new_X(j + 1, :));
  if space > threshold
    b = new_X(j    , :);
    c = new_X(j + 1, :);
    point = (b + c) ./ 2;
    if j >= 2 && j <= new_Nb -2
      a = new_X(j - 1, :);
      d = new_X(j + 2, :);
      ab = b - a;
      dc = c - d;
      rhs1 = dot(a, [b(2), -b(1)]);
      rhs2 = dot(d, [c(2), -c(1)]);
      intersection = [ab(2), -ab(1); dc(2), -dc(1)] \ [rhs1; rhs2];
      % display(intersection);
      % display(point);
      % plot(intersection(1), intersection(2), 'rx');
      % plot(point(1), point(2), 'bx');
      if norm(intersection - point) < threshold * .5
        point = point .* .5 + intersection' .* .5;
      end
      plot(point(1), point(2), 'bo');
      % pause;
    end
    new_X(j+2 : new_Nb+1, :) = new_X(j+1 : new_Nb, :);
    new_Nb = new_Nb + 1;
    new_X(j+1, :) = point;
    j = j + 1;
  end
  j = j + 1;
end

new_X = new_X(1:new_Nb, :);
kp=[(2:new_Nb),1]; % IB index shifted left
km=[new_Nb,(1:(new_Nb-1))]; % IB index shifted right