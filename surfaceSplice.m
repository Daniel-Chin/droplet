past_extreme_velocity(past_extreme_velocity_cursor) = max(vecnorm(surface_velocity'));
past_extreme_velocity_cursor = past_extreme_velocity_cursor + 1;
if past_extreme_velocity_cursor > N_PAST_EXTREME_VELOCITY
  past_extreme_velocity_cursor = 1;
end

watch_cooldown = watch_cooldown - dt;
% if watch_cooldown <= 0
if 1  % because point id is not consistent across time steps, we cannot use watchlist.
  % update watch_list
  watch_list = [];
  watch_list_len = 0;
  for j = 1 : Nb
    for k = 1 : j - 1
      if ismember(j, watch_list) && ismember(k, watch_list)
        continue;
      end
      pj = X(j, :);
      pk = X(k, :);
      displacement = pk - pj;
      if norm(displacement) > WATCH_DISTANCE
        continue;
      end
      if doesLinkWall(j, links, wall_links) || doesLinkWall(k, links, wall_links)
        continue;
      end
      j_1 = links(1, j);
      if j_1 == 1 % potential wall link
        j_2 = links(2, j);
        if j_2 == 1 % potential wall link
          k_1 = links(1, k);
          if k_1 == 1 % potential wall link
            k_2 = links(2, k);  % cannot be 1 anymore
            tangent_vector = pk - X(k_2, :);
          else
            tangent_vector = pk - X(k_1, :);
          end
        else
          tangent_vector = pj - X(j_2, :);
        end
      else
        tangent_vector = pj - X(j_1, :);
      end
      if abs(dot(tangent_vector, displacement) / norm(tangent_vector) / norm(displacement)) < .3
        % almost perpendicular
        watch_list_len = watch_list_len + 1;
        watch_list(watch_list_len) = j;
        watch_list_len = watch_list_len + 1;
        watch_list(watch_list_len) = k;
      end
    end
  end
  watch_list = unique(watch_list);
  watch_list_len = numel(watch_list);

  watch_cooldown = WATCH_DISTANCE / (max(past_extreme_velocity) * WATCH_CONSERVATIVE);
  display(watch_list_len);
end
for j = 1 : watch_list_len
  for k = 1 : j - 1
    id0 = watch_list(j);
    id1 = watch_list(k);
    pid0 = X(id0, :);
    pid1 = X(id1, :);
    displacement = pid1 - pid0;
    if norm(displacement) > SPLICE_THRESHOLD
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
    if abs(dot(tangent_vector, displacement) / norm(tangent_vector) / norm(displacement)) < .3
      % almost perpendicular
      relative_velocity = surface_velocity(id1, :) - surface_velocity(id0, :);
      if dot(relative_velocity, (p0 - p1)) > 0
        % approaching
        id0_1 = links(1, id0);
        id1_2 = links(2, id1);
        disp([id0 id1 id0_1 id1_2]);
        
        links(1, id0) = id1;
        links(2, id1) = id0;
        links(1, id1_2) = id0_1;
        links(2, id0_1) = id1_2;

        watch_cooldown = 0;
        return;
      end
    end
  end
end
