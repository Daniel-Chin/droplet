function [F, new_X] = computeWallForce( ...
  X, X_midpoint, u, WALL_STIFF, PERFECT_WALL, F_MIN, ...
  SLIP_LENGTH, SLIP_LENGTH_COEF, wall_links, links ...
)
% `X` is the displacement of wall markers
% `u` is the fluid velocity field
% `PERFECT_WALL` is the initial displacement of wall markers
% `SLIP_LENGTH` describes the region of markers affected by moving contact point
F = WALL_STIFF * (PERFECT_WALL - X_midpoint);
new_X = X;

marker_velocity = interpolateVelocityField(u, X);
for k = wall_links  
  % a wall_link is a link between an interface marker and the wall
  id = k(1);  % interface marker id
  direction = k(2);
  contact_line_vertical_v = marker_velocity(id, 2);
  next2 = links(direction, links(direction, id));
  tangent_vector = X(next2, :) - X(id, :);
  contact_angle = pi/2 + atan(tangent_vector(2) / tangent_vector(1));
  f_limit = friction(contact_angle, ...
    contact_line_vertical_v, direction, F_MIN) * SLIP_LENGTH_COEF;
  for j=1:Nb2
    if abs(X_midpoint(j, 2) - X(id, 2)) <= SLIP_LENGTH / 2
      intention = F(j, 2);
      % `intention` estimates the sum of all active forces
      % Error approaches 0 as timestep approaches 0
      if intention / f_limit > 1
        % penalty dismissal! 
        F(j, 2) = f_limit;
        new_X(j, 2) = PERFECT_WALL(j, 2) - f_limit / WALL_STIFF;
      end    
    end
  end
end
