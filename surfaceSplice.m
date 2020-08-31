past_extreme_velocity(past_extreme_velocity_cursor) = max(vecnorm(surface_velocity'));
past_extreme_velocity_cursor = past_extreme_velocity_cursor + 1;
if past_extreme_velocity_cursor > N_PAST_EXTREME_VELOCITY
  past_extreme_velocity_cursor = 1;
end

for id0 = 1 : Nb
  for id1 = 1 : j - 1
    pid0 = X(id0, :);
    pid1 = X(id1, :);
    displacement = pid1 - pid0;
    if norm(displacement) > SPLICE_THRESHOLD
      continue;
    end
    if doesLinkWall(id0, links, wall_links) || doesLinkWall(id1, links, wall_links)
      continue;
    end

    id0_1 = links(1, id0);
    if id0_1 == 1 % potential wall link
      id0_2 = links(2, id0);
      if id0_2 == 1 % potential wall link
        id1_1 = links(1, id1);
        if id1_1 == 1 % potential wall link
          id1_2 = links(2, id1);  % cannot be 1 anymore
          tangent_vector = pid1 - X(id1_2, :);
        else
          tangent_vector = pid1 - X(id1_1, :);
        end
      else
        tangent_vector = pid0 - X(id0_2, :);
      end
    else
      tangent_vector = pid0 - X(id0_1, :);
    end

    if abs(dot(tangent_vector, displacement) / norm(tangent_vector) / norm(displacement)) > .3
      % not perpendicular
      continue;
    end

    relative_velocity = surface_velocity(id1, :) - surface_velocity(id0, :);
    if dot(relative_velocity, (p0 - p1)) <= 0
      % not approaching
      continue;
    end

    id0_j1 = id0;
    id0_j2 = id0;
    not_ok = 0;
    for j = 1 : 3
      id0_j1 = links(1, id0_j1);
      id0_j2 = links(2, id0_j2);
      if id0_j1 == id1 || id0_j2 == id1
        not_ok = 1;
        return;
      end
    end
    if not_ok
      continue;
    end

    id0_1 = links(1, id0);
    id1_2 = links(2, id1);
    
    links(1, id0) = id1;
    links(2, id1) = id0;
    links(1, id1_2) = id0_1;
    links(2, id0_1) = id1_2;
    disp("SPLICE");

    return; % One splice at a step
  end
end
