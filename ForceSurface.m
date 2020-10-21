function F=ForceSurface(X, links, dtheta, K, wall_links, Nb, WALL_LINKER_TO_WALL_STIFF)
% surface tension & Contact point force

% surface tension
displace1 = (X(links(1, 1:Nb),:) - X)';
displace2 = (X(links(2, 1:Nb),:) - X)';
F = K / dtheta * (displace1 ./ vecnorm(displace1) + displace2 ./ vecnorm(displace2))';
F(isnan(F)) = 0;

% contact point force
for wlink = wall_links
  displace = X(links(wlink(2), wlink(1)), :) - X(wlink(1), :);
  position = X(wlink(1), :);
  F(wlink(1), 2) = displace(2) ./ vecnorm(displace') * K;
  F(wlink(1), 1) = - position(1) * WALL_LINKER_TO_WALL_STIFF;
end
