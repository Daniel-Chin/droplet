function F=ForceWall_noslip(XX2, K, PERFECT_WALL)
% penalty
F=K*(PERFECT_WALL - XX2);
