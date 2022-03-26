% function [new_X, new_Nb, kp, km]=surfaceResample(X, Nb, dtheta, u)
resample_threshold = 1.414 * dtheta;

% take out
holes = zeros(1, Nb);
holes_i = 0;
for j = Nb:-1:1
  if (links(1, j) ~= 1 && links(2, j) ~= 1) || ~any(wall_links(1, :) == j)
    p_1 = X(links(1, j), :);
    p_2 = X(links(2, j), :);
    if norm(p_1 - p_2) < resample_threshold
      if holes_i == 0 || holes(holes_i) ~= j + 1    % dont consecutively take out
        p = X(j, :);
        displace_1 = p_1 - p;
        displace_2 = p_2 - p;
        dot_prod = dot(displace_1, displace_2) / norm(displace_1) / norm(displace_2);
        % sharpness control
        if isnan(dot_prod) || dot_prod < -.9
          holes_i = holes_i + 1;
          holes(holes_i) = j;
          % plot(X(j, 1), X(j, 2), 'ro');
          % disp("take out");
          % schedule_next_frame_pause = true;
        end
      end
    end
  end
end
if holes_i ~= 0
  for hole = holes(1:holes_i)
    % splice
    hole_left  = links(1, hole);
    hole_right = links(2, hole);
    links(2, hole_left)  = hole_right;
    links(1, hole_right) = hole_left;

    % compute resample_energy_offset
    resample_energy_offset = resample_energy_offset + ...
      norm(X(hole_left, :) - X(hole_right, :)) - ( ...
        norm(X(hole_left, :) - X(hole, :)) + ...
        norm(X(hole, :) - X(hole_right, :)) ...
      );

    % fill hole
    holeToFill = hole;
    fillLinksHole();
  end
end

% shrink/grow head/tail
% j = 0;
% for wall_link = wall_links
%   j = j + 1;
%   x_id = wall_link(1);
%   direction = wall_link(2);
%   tip_x = X(x_id, 1);
%   if tip_x < - dtheta / 2 % shrink
%     % splice
%     new_x_id = links(direction, x_id);
%     links(3 - direction, new_x_id) = 1;
%     wall_links(1, j) = new_x_id;

%     % fill hole
%     holeToFill = x_id;
%     fillLinksHole();

%     plot(X(x_id, 1), X(x_id, 2), 'ro');
%     disp("shrink");
%     % schedule_next_frame_pause = true;
%   elseif tip_x > dtheta / 2 % grow
%     v = vec_interp(u, X(x_id, :), 1);
%     Nb = Nb + 1;
%     X(Nb, :) = X(x_id, :) - v ./ norm(v) * dtheta;

%     links(3 - direction, x_id) = Nb;
%     links(3 - direction, Nb) = 1;
%     links(    direction, Nb) = x_id;

%     wall_links(1, j) = Nb;

%     plot(X(Nb, 1), X(Nb, 2), 'bo');
%     disp("grow");
%     schedule_next_frame_pause = true;
%   end
% end

% put in
for j = 1 : Nb
  left_id  = j;
  right_id = links(2, j);
  if right_id == 1 % && any(wall_links(1, :) == j)
    if wall_links(2, wall_links(1, :) == j) == 1
      continue;   % `right_id` is a placeholder "1"
    end
  end
  b = X(left_id , :);
  c = X(right_id, :);
  space = norm(b - c);
  if space > resample_threshold
    point = (b + c) ./ 2;
    leftleft_id   = links(1, left_id);
    rightright_id = links(2, right_id);
    if (leftleft_id ~= 1 && rightright_id ~= 1) || ~(any(wall_links(1, :) == left_id) || any(wall_links(1, :) == right_id))
      a = X(leftleft_id   , :);
      d = X(rightright_id , :);
      ab = b - a;
      dc = c - d;
      rhs1 = dot(a, [b(2), -b(1)]);
      rhs2 = dot(d, [c(2), -c(1)]);
      intersection = [ab(2), -ab(1); dc(2), -dc(1)] \ [rhs1; rhs2];
      % display(intersection);
      % display(point);
      % plot(intersection(1), intersection(2), 'rx');
      % plot(point(1), point(2), 'bx');
      if norm(intersection - point) < resample_threshold * .5
        % This is almost never the case
        point = point .* (1-RESAMPLE_AMEND) + intersection' .* RESAMPLE_AMEND;
      end
    end
    Nb = Nb + 1;
    X(Nb, :) = point;

    links(1, Nb) = left_id;
    links(2, Nb) = right_id;
    links(1, right_id) = Nb;
    links(2, left_id ) = Nb;
    % plot(point(1), point(2), 'bo');
    % disp("put in");
    % schedule_next_frame_pause = true;
    resample_energy_offset = resample_energy_offset + ( ...
      norm(X(left_id, :) - point) + ...
      norm(point - X(right_id, :)) ...
    ) - norm(X(left_id, :) - X(right_id, :));
  end
end
X = X(1:Nb, :);
