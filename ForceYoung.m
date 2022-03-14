function [force_young, place_young]=ForceYoung(u, wall_links, X, Nb, K, STATIC_CONTACT_ANGLE)
% This does not compute the Young's force. This only 
% gives the part of Young's force that's unaccounted for
% with the tension method. 

[two, n_mcl] = size(wall_links);
force_young = zeros(n_mcl, 2);
place_young = zeros(n_mcl, 2);
point_velocity = vec_interp(u, X, Nb);
for k = 1 : n_mcl
  id = wall_links(1, k);
  direction = wall_links(2, k);
  force_young(k, 2) = K * cos(STATIC_CONTACT_ANGLE);
  if direction == 2
    force_young(k, 2) = - force_young(k, 2);
  end
  place_young(k, :) = X(id, :);
end
