function F=ForceSurface(X, kp, km, dtheta, K, NAILS, NAIL_STIFF)
% elastic stretching force
F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
% F(1, :) = NAIL_STIFF * (NAILS(1, :) - X(1, :));
% F(end, :) = NAIL_STIFF * (NAILS(end, :) - X(end, :));

% not circular anymore, break it
F(1, :) = [0 0];
F(end, :) = [0 0];

% this is wrong. spring force should not be proportional to distance. it should be constant. 
