function F=ForceSurface(X, kp, km, dtheta, K)
% surface tension
p = (X(kp,:) - X)';
m = (X(km,:) - X)';
F = K * (p ./ vecnorm(p) + m ./ vecnorm(m))';

% not circular anymore, break it
F(1, :) = [0 0];
F(end, :) = [0 0];
