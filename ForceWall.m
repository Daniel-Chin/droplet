function [F, new_X2, force_mcl, place_mcl, n_mcl]=ForceWall(XX2, K, PERFECT_WALL, u, X, Nb, Nb2, NO_SLIP_FORCE, X2, h, FRICTION_ADJUST, wall_links, links)
% penalty
spring = PERFECT_WALL - XX2;

max_wall_penalty = max(vecnorm(spring'));
if max_wall_penalty > h*.3
  disp('Wall penalty exceeds h*.3!');
  disp(max_wall_penalty / (h*.3));
end

F = K * spring;
F(:, 2) = max(min(F(:, 2), NO_SLIP_FORCE), - NO_SLIP_FORCE);

static_radius = NO_SLIP_FORCE / K;
spring = X2 - PERFECT_WALL;

those_slip = abs(spring(:, 2)) > static_radius;
plot(X2(those_slip, 1), X2(those_slip, 2), 'ko');

spring(:, 2) = max(min(spring(:, 2), static_radius), - static_radius);
new_X2 = PERFECT_WALL + spring;

[two, n_mcl] = size(wall_links);
force_mcl = zeros(n_mcl, 2);
place_mcl = zeros(n_mcl, 2);
point_velocity = vec_interp(u, X, Nb);
for k = 1 : n_mcl
  id = wall_links(1, k);
  direction = wall_links(2, k);
  contact_line_vertical_v = point_velocity(id, 2);
  next2 = links(direction, links(direction, id));
  tangent_vector = X(next2, :) - X(id, :);
  contact_angle = pi/2 + atan(tangent_vector(2) / tangent_vector(1));
  force_mcl(k, :) = friction(contact_angle, contact_line_vertical_v, direction, FRICTION_ADJUST);
  place_mcl(k, :) = X(id, :);
end
