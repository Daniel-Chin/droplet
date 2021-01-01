function [F, force_wall]=ForceSurface(X, links, dtheta, K, wall_links, Nb, XX2, WALL_LINK_STIFF, Nb2)
% surface tension & Contact point force

% surface tension
displace1 = (X(links(1, 1:Nb),:) - X)';
displace2 = (X(links(2, 1:Nb),:) - X)';
F = K * (displace1 ./ vecnorm(displace1) + displace2 ./ vecnorm(displace2))';
F(isnan(F)) = 0;

% contact point force
force_wall = zeros(Nb2, 2);
for wlink = wall_links
  interface_id = wlink(1);
  p = X(interface_id, :);
  [~, wall_id] = min(vecnorm((XX2 - p)'));
  youngs_displace = X(links(wlink(2), interface_id), :) - p;
  youngs_force = K * youngs_displace ./ vecnorm(youngs_displace');
  wall_displace = XX2(wall_id, :) - p;
  wall_force = WALL_LINK_STIFF * wall_displace / dtheta;

  F(interface_id, :) = youngs_force + wall_force;
  force_wall(wall_id, :) = force_wall(wall_id, :) - wall_force;
end
