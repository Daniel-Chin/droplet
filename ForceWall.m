function F=ForceWall(X)
% penalty
F=WALL_SITFFNESS*(PERFECT_WALL - X);
