function F=ForceSurface(X, kp, km, dtheta, K)
% surface tension & Contact point force

% surface tension
p = (X(kp,:) - X)';
m = (X(km,:) - X)';
F = K * (p ./ vecnorm(p) + m ./ vecnorm(m))';

% contact point force
p = (X(2, :) - X(1, :))';
F(1, 2) = p(2) ./ vecnorm(p) * K;
F(1, 1) = 0;
m = (X(end-1, :) - X(end, :))';
F(end, 2) = m(2) ./ vecnorm(m) * K;
F(end, 1) = 0;
