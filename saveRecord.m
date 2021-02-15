% record data required for `render` to "recording files". 
% The recording files are used to generate rendered images/video. 

save(sprintf(RECORD_PATH, save_render_i), 'h', 'L', 'X', 'X2', 'X4', 'X3', 'Nb', 'links', 'wall_links', 'clock', 'dt', 'big_G');
