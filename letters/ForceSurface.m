function F=ForceSurface(X, links, dtheta, K, wall_links, Nb)
% surface tension & Contact point force

% surface tension
displace1 = (X(links(1, 1:Nb),:) - X)';
displace2 = (X(links(2, 1:Nb),:) - X)';
F = K * (displace1 ./ vecnorm(displace1) + displace2 ./ vecnorm(displace2))';
F(isnan(F)) = 0;

% contact point force
for wlink = wall_links
  displace = (X(links(wlink(2), wlink(1)), :) - X(wlink(1), :))';
  F(wlink(1), :) = K * displace ./ vecnorm(displace);
end
