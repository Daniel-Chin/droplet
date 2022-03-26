DX = h * .01;

X = zeros(1, 2);
x = [0 -5];
X_size = 0;
theta = pi * .3;
ideal_slope = - K / big_G;
s = 0;

while s < h * 10
  X_size = X_size + 1;
  s = s + DX;
  X(X_size, :) = x;
  x = x + [cos(theta), sin(theta)] .* DX;
  curvature = x(2) * ideal_slope;
  theta = theta + curvature * DX;
end

curvature = estimateCurvature( ...
  X(1                , :), ...
  X(round(X_size * .4), :), ...
  X(end              , :) ...
);

actual_slope = curvature / X(round(X_size / 2), 2);
plot(X(:, 1),X(:, 2));
axis equal;
ideal_slope
actual_slope
slope_error = actual_slope - ideal_slope
