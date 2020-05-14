% warpIndicators
global X3;

for j = 1 : Nb3
  if X3(j, 1) < 0
    X3(j, 1) = - X3(j, 1);
  end
  if X3(j, 1) > L / 2
    X3(j, 1) = L / 2 - X3(j, 1);
  end
  if X3(j, 2) < 0
    X3(j, 2) = X3(j, 2) + L;
  end
  if X3(j, 2) > L
    X3(j, 2) = X3(j, 2) - L;
  end
end
