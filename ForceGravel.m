function F=ForceGravel(Nb)
% gravity
F = zeros(Nb, 2);
F(:, 2) = - 1.5 / Nb;
