% FPS = 60 * 80;
FPS = 60 * .5;
TIMESTEPS_PER_FRAME = round(1 / dt / FPS / 2) * 2 + 1;
display(TIMESTEPS_PER_FRAME);
render_phase = 0;
