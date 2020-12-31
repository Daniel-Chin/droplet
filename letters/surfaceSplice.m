% This script treats points assymetrically. Should be good enough

past_extreme_velocity(past_extreme_velocity_cursor) = max(vecnorm(surface_velocity'));
past_extreme_velocity_cursor = past_extreme_velocity_cursor + 1;
if past_extreme_velocity_cursor > N_PAST_EXTREME_VELOCITY
  past_extreme_velocity_cursor = 1;
end

if splice_reject_remains > 0
  splice_reject_remains = splice_reject_remains - 1;
  return;
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
    if dot(relative_velocity, (pid0 - pid1)) <= 0
      % not approaching
      continue;
    end

    id0_j1 = id0;
    id0_j2 = id0;
    not_ok = 0;
    for j = 1 : 3
      id0_j1 = links(1, id0_j1);
      id0_j2 = links(2, id0_j2);
      if id0_j1 == id1 || id0_j2 == id1 || doesLinkWall(id0_j1, links, wall_links) || doesLinkWall(id0_j2, links, wall_links)
        not_ok = 1;
        break;
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
    
    fprintf("SPLICE t = %f\n", clock * dt);
    splice_reject_remains = SPLICE_REJECT_N_STEPS;
    return; % One splice at a step
  end
end
if WALL_EXISTS
  % attach / wall split
  for j = 1 : Nb
    p = X(j, :);

    if p(1) > SPLICE_WALL_THRESHOLD
      continue;
    end

    if doesLinkWall(j, links, wall_links)
      continue;
    end

    if surface_velocity(j, 1) >= 0
      continue;
    end
    
    j_jj1 = j;
    j_jj2 = j;
    not_ok = 0;
    for jj = 1 : 15
      j_jj1 = links(1, j_jj1);
      j_jj2 = links(2, j_jj2);
      if doesLinkWall(j_jj1, links, wall_links) || doesLinkWall(j_jj2, links, wall_links)
        not_ok = 1;
        break;
      end
    end
    if not_ok
      continue;
    end
    
    j_1 = links(1, j);

    wall_links_len = size(wall_links, 2);
    wall_links(:, wall_links_len + 1) = [j_1, 1];
    wall_links(:, wall_links_len + 2) = [j, 2];
    clear wall_links_len; % avoid confusion. (Not a usable global var)

    links(1, j) = 1;
    links(2, j_1) = 1;
    
    fprintf("attach / wall split. t = %f\n", clock * dt);
    splice_reject_remains = SPLICE_REJECT_N_STEPS;
    return;
  end

  % detach / wall merge
  wall_links_len = size(wall_links, 2);
  for j = 1 : wall_links_len
    for k = 1 : j-1
      id0 = wall_links(1, j);
      id1 = wall_links(1, k);
      p0 = X(id0, :);
      p1 = X(id1, :);
      displacement = p0(2) - p1(2);

      if abs(displacement) > SPLICE_WALL_THRESHOLD
        continue;
      end

      relative_velocity = surface_velocity(id1, 2) - surface_velocity(id0, 2);
      if relative_velocity * displacement < 0
        % not approaching
        continue;
      end
    
      j_direction = wall_links(2, j);
      k_direction = wall_links(2, k);
      if j_direction + k_direction ~= 3
        error('2 interfaces of the same orientation are joining!');
      end
      wall_links_pop_ids = [j, k];
      popWallLinks();
      clear wall_links_len;

      id0_next = links(j_direction, id0);
      id1_next = links(k_direction, id1);
      links(3 - j_direction, id0_next) = id1_next;
      links(3 - k_direction, id1_next) = id0_next;
      for holeToFill = sort([id0, id1], 'd')
        fillLinksHole();  % descending order so that we don't fill an out-of-bound hole
      end
      X = X(1:Nb, :);

      fprintf("detach / wall merge. t = %f\n", clock * dt);
      
      splice_reject_remains = SPLICE_REJECT_N_STEPS;
      return;
    end
  end
  clear wall_links_len; % avoid confusion. (Not a usable global var)
end
