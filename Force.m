function F=Force(X, kp, km, dtheta, K)
% elastic stretching force
F=K*(X(kp,:)+X(km,:)-2*X)/(dtheta*dtheta);
