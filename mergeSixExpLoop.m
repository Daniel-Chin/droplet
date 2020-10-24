while clock <= clockmax
  clock = clock + 1;
  stepMergeSixExp();

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
  if mod(clock, 40) == 0
    try
      save(sprintf('E:/IBM_space/backup/%d.mat', clock));
    catch ME
      0;
    end
  end
end
