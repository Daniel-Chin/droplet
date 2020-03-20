function F=ForceWall(X, K, PERFECT_WALL)
% penalty
F=K*(PERFECT_WALL - X);
