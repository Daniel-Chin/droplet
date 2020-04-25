function [new_X, new_Nb, kp, km]=surfaceResample(X, Nb, dtheta)
threshold = 1.414 * dtheta;
new_X = zeros(size(X));
new_X(1, :) = X(1, :);
new_Nb = 1;

% take out
for j = 3:Nb
  if norm(new_X(new_Nb, :) - X(j, :)) > threshold
    new_Nb = new_Nb + 1;
    new_X(new_Nb, :) = X(j - 1, :);
  end
end
new_Nb = new_Nb + 1;
new_X(new_Nb, :) = X(end, :);

% put in
j = 1;
while j <= new_Nb - 1
  space = norm(new_X(j, :) - new_X(j + 1, :));
  if space > threshold
    new_X(j+2 : new_Nb+1, :) = new_X(j+1 : new_Nb, :);
    new_Nb = new_Nb + 1;
    new_X(j+1, :) = (new_X(j, :) + new_X(j + 2, :)) ./ 2;
    j = j + 1;
  end
  j = j + 1;
end

new_X = new_X(1:new_Nb, :);
kp=[(2:new_Nb),1]; % IB index shifted left
km=[new_Nb,(1:(new_Nb-1))]; % IB index shifted right
