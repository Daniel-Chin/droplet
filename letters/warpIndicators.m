% warpIndicators
for k = 1 : 2
  for j = 1 : Nb3
    if X3(j, k) < 0
      X3(j, k) = X3(j, k) + L;
    end
    if X3(j, k) > L
      X3(j, k) = X3(j, k) - L;
    end
  end
end
for k = 1 : 2
  for j = 1 : Nb4
    if X4(j, k) < 0
      X4(j, k) = X4(j, k) + L;
      Y4(j, k) = Y4(j, k) + L;
    end
    if X4(j, k) > L
      X4(j, k) = X4(j, k) - L;
      Y4(j, k) = Y4(j, k) - L;
    end
  end
end
