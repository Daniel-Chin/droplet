% assumes (L/32, L*.4) is inside the boundary
% first spread, then fill!!!
gravity = zeros(N, N);

surface_grid = vec_spread(gravity_helper, XX, dtheta, Nb);
max_surface_grid = max(max(surface_grid(:, :, 1)));
surface_grid = surface_grid(:, :, 1) ./ max_surface_grid;
gravity_frontier = zeros(size(gravity_frontier));
gravity_frontier(1, :) = [gravity_soul(1), gravity_soul(2), 0];
gravity_frontier_top = 1;
gravity_visited = false(N, N);
gravity_render_i = 0;

while gravity_frontier_top ~= 0
  gravity_to_visit = zeros(N, N, 2);
  new_gravity_frontier = zeros(size(gravity_frontier));
  new_gravity_frontier_i = 0;
  for gravity_frontier_i = 1 : gravity_frontier_top
    job = gravity_frontier(gravity_frontier_i, :);
    gravity_x = job(1);
    gravity_y = job(2);
    if gravity_x ~= 1
      if surface_grid(gravity_x, gravity_y, 1) >= job(3) * 1.1
        job_3 = max(job(3), surface_grid(gravity_x, gravity_y));
        gravity(gravity_x, gravity_y) = gravity_per_cell * (1 - job_3);
        for offset = [0 1; 1 0; 0 -1; -1 0]'
          next_x = gravity_x + offset(1);
          next_y = gravity_y + offset(2);
          if gravity_visited(next_x, next_y) == false
            if gravity_to_visit(next_x, next_y, 1) ~= 0
              % already in new frontier
              if job_3 < gravity_to_visit(next_x, next_y, 2)
                % replace
                new_gravity_frontier(gravity_to_visit(next_x, next_y, 1), 3) = job_3;
                gravity_to_visit(next_x, next_y, 2) = job_3;
              end
            else
              new_gravity_frontier_i = new_gravity_frontier_i + 1;
              new_gravity_frontier(new_gravity_frontier_i, :) = [next_x, next_y, job_3];
              gravity_to_visit(next_x, next_y, 1) = new_gravity_frontier_i;
              gravity_to_visit(next_x, next_y, 2) = job_3;
            end
          end
        end
      end
    end
  end
  gravity_visited = gravity_visited | gravity_to_visit >= 1;
  % if mod(clock, 8) == 0 && gravity_render_i == 0
  %   pixels = zeros(N, N, 3);
  %   pixels(end:-1:1, :, 1) = surface_grid';
  %   pixels(end:-1:1, :, 2) = gravity' ./ gravity_per_cell;
  %   image(pixels);
  %   pause(.1)
  %   % saveFrame();
  % end
  gravity_render_i = mod(gravity_render_i + 1, 2);
  gravity_frontier_top = new_gravity_frontier_i;
  gravity_frontier = new_gravity_frontier;
end
% if mod(clock, 12) == 0
%   for i = 1:5
%     saveFrame();
%   end
% end
sum_gravity = sum(gravity, 'all');
fprintf("Gravity: ");
for j=1:round(-sum_gravity * .007)
  fprintf('#');
end
fprintf('\n');

% gravity_soul(2) = ceil((X(1, 2) * .2 + X(end, 2) * .8) / h);
gravity_soul = floor(mean(X(X(:, 1) > h, :)) ./ h) + [0 0];
