function [F, new_X2]=ForceWall(XX2, WALL_STIFFNESS, u, X, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h, FRICTION_ADJUST, wall_links, links, SLIP_LENGTH, kp, km, dtheta2)
% penalty
F = WALL_STIFFNESS * (XX2(kp,:) + XX2(km,:) - 2*XX2) / dtheta2;
F(1, :) = 0;
F(end, :) = 0;
new_X2 = X2;
return;
point_velocity = vec_interp(u, X, Nb);
for k = wall_links
  id = k(1);
  direction = k(2);
  contact_line_vertical_v = point_velocity(id, 2);
  next2 = links(direction, links(direction, id));
  tangent_vector = X(next2, :) - X(id, :);
  contact_angle = pi/2 + atan(tangent_vector(2) / tangent_vector(1));
  static_limit = friction(contact_angle, contact_line_vertical_v, direction, NO_SLIP_FORCE, FRICTION_ADJUST) * SLIP_LENGTH_COEF;
  % static_limit
  entered_slip_region = false;
  for j=1:Nb2
    if abs(XX2(j, 2) - X(id, 2)) <= SLIP_LENGTH / 2
      entered_slip_region = true;
      intention = F(j, 2);
      if intention / static_limit > 1
        % fprintf('Slip! y=%.1f, level=%.2f \n', X2(j, 2), intention / the_limit);
        plot(X2(j, 1), X2(j, 2), 'ko');
        F(j, 2) = static_limit;
        new_X2(j, 2) = PERFECT_WALL(j, 2) - static_limit / WALL_STIFFNESS;
      end    
    else
      if entered_slip_region
        break;
      end
    end
  end
end
