try
  filePattern = fullfile('E:/IBM_space/backup', '*.mat'); % Change to whatever pattern you need.
  theFiles = dir(filePattern);
  for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now deleting %s\n', fullFileName);
    delete(fullFileName);
  end
catch ME
  disp('No E:');
end
