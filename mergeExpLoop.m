while clock <= clockmax
  clock = clock + 1;
  stepMergeExp();
  calcArea();
  area_his_i = area_his_i + 1;
  area_his(area_his_i) = droplet_area;

  % pause(1);
  if clock == 410
    disp("!!!");
  end
  % if clock == 420
  %   lu = 90;
  %   ru = links(2, lu);
  %   ld = 23;
  %   rd = links(1, ld);
  %   links(1, ru) = rd;
  %   links(2, rd) = ru;
  %   links(1, ld) = lu;
  %   links(2, lu) = ld;
  % end

  % if clock > 369
  %   pause(1);
  % end
  if schedule_next_frame_pause
    pause;
  end
end
