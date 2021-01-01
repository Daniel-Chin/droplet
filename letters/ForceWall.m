function [F, new_X2]=ForceWall(XX2, WALL_STIFFNESS, u, X, Nb, Nb2, NO_SLIP_FORCE, X2, SLIP_LENGTH_COEF, h, FRICTION_ADJUST, wall_links, links, SLIP_LENGTH, kp, km, dtheta2)
% penalty
F = WALL_STIFFNESS * (XX2(kp, :) + XX2(km, :) - 2*XX2) / dtheta2;
F(1, :) = 0;
F(end, :) = 0;

% tmpF = F;
new_X2 = X2;

% slip_iter = 0;
% while 1
%   tangent_vector = new_X2(kp, :) - new_X2(km, :);
%   unit_tangent_vector = tangent_vector ./ vecnorm(tangent_vector')';
%   tangent_stress = dot(tmpF, unit_tangent_vector, 2);
%   slip_mask = abs(tangent_stress) > NO_SLIP_FORCE;
%   slip_mask(1) = 0;
%   slip_mask(end) = 0;
%   if ~any(slip_mask) || slip_iter > 3
%     break;
%   end
%   slip_iter = slip_iter + 1;
%   mid_point = (new_X2(kp, :) + new_X2(km, :)) ./ 2;
%   correction = dot(mid_point - new_X2, unit_tangent_vector, 2) .* unit_tangent_vector;
%   new_X2 = new_X2 + correction .* slip_mask;
%   tmpF = WALL_STIFFNESS * (new_X2(kp, :) + new_X2(km, :) - 2*new_X2) / dtheta2;
%   % plot(new_X2(slip_mask, 1), new_X2(slip_mask, 2), 'ko');
% end
% % if slip_iter >= 10
% %   fprintf("large slip_iter, %d \n", slip_iter);
% % end
