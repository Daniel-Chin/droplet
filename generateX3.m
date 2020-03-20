function [X3, Nb3, dtheta3]=generateX3(N, h, L)
STEP = 1;
dtheta3 = STEP * 1;
Nb3 = 0;
for j = ceil(STEP / 2) : STEP : N-1
  for k = ceil(STEP / 2) : STEP : N-1
    if (j*h - 0) ^ 2 + (k*h - L/2) ^ 2 < (L/4) ^ 2
      Nb3 = Nb3 + 1;
    end
  end
end
X3 = zeros(Nb3, 2);
i_x3 = 0;
for j = ceil(STEP / 2) : STEP : N-1
  for k = ceil(STEP / 2) : STEP : N-1
    if (j*h - 0) ^ 2 + (k*h - L/2) ^ 2 < (L/4) ^ 2
      i_x3 = i_x3 + 1;
      X3(i_x3, :) = [j*h k*h];
    end
  end
end
