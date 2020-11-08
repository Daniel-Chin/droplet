while clock <= clockmax
  clock = clock + 1;
  stepMergeSixExp();
  calcArea();
  area_his_i = area_his_i + 1;
  area_his(area_his_i) = droplet_area;

  % pause(1);
  % if clock == 410
  %   disp("!!!");
  % end
  % if clock > 369
  %   pause(1);
  % end
  if schedule_next_frame_pause
    pause;
  end
  % if mod(clock, 200) == 0
  %   try
  %     save(sprintf('E:/IBM_space/backup/%d.mat', clock));
  %   catch ME
  %     0;
  %   end
  % end
end
