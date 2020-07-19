function F=ForceSurface(X, links, dtheta, K, wall_links)
% surface tension & Contact point force

% surface tension
displace1 = (X(links(1),:) - X)';
displace2 = (X(links(2),:) - X)';
F = K * (displace1 ./ vecnorm(displace1) + displace2 ./ vecnorm(displace2))';

% contact point force
for wlink = wall_links
  displace = X(links(wlink(2), wlink(1)), :) - X(wlink(1), :);
  F(wlink(1), 2) = displace(2) ./ vecnorm(displace') * K;
  F(wlink(1), 1) = 0;
end
