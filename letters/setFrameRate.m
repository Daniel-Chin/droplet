FPS = 1 / dt;
% FPS = 60 * 80;
% FPS = 60 * 40;
% FPS = 60 * 20;
% FPS = 60 * 1;
SPF = 1 / FPS;
approx_timesteps_per_frame = floor(1 / dt / FPS / 2) * 2 + 1;
display(approx_timesteps_per_frame);
render_phase = 0;
