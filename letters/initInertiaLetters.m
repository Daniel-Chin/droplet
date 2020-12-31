dtheta4 = h * .9;

UNIFORM_X4 = zeros(1, 2);
UNIFORM_X4_SIZE = 0;
for i = 0 : dtheta4 : L
  for j = 0 : dtheta4 : L
    UNIFORM_X4_SIZE = UNIFORM_X4_SIZE + 1;
    UNIFORM_X4(UNIFORM_X4_SIZE, :) = [i, j];
  end
end
inAndOut;
dither_in_out;

X4 = zeros(1, 2);
Nb4 = 0;
for k = 1 : UNIFORM_X4_SIZE
  if in_out_acc(k) == 1
    % if in_out_acc(k) == .5
    %   disp(UNIFORM_X4(k, :));
    % end
    Nb4 = Nb4 + 1;
    X4(Nb4, :) = UNIFORM_X4(k, :);
  elseif in_out_acc(k) ~= 0
    disp(UNIFORM_X4(k, :));
    disp(in_out_acc(k));
    error('Error 891236428937430');
  end
end

Y4 = X4;
V4 = zeros(Nb4, 2);
MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;
