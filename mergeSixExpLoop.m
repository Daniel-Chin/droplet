while clock <= clockmax
  clock = clock + 1;
  stepMergeSixExp();

  % pause(1);
  if clock == 410
    disp("!!!");
  end
  % if clock > 369
  %   pause(1);
  % end
  if schedule_next_frame_pause
    pause;
  end
end
