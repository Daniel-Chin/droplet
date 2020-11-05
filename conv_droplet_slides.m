close all

% clc; 
% clear all
% global dt Nb N h rho mu ip im a;
% global kp km dtheta K;
% global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
% global big_G;
% defineConstants();

% dt = 0.0001; % Time step, second
% N = 96; % Number of grid cells

% initialize();
% RENDER_DEBUG = 0;

% OUTPUT_PATH = 'E:/IBM_Space/output_11/%d.png';

% init_a();
% initX_ori();
% initInertia();

% %% Run simulation
% clock = 0;
% render();
% while clock < clockmax
%   clock = clock + 1;
%   step();
% end




% clc; 
% clear all
% global dt Nb N h rho mu ip im a;
% global kp km dtheta K;
% global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
% global big_G;
% defineConstants();

% dt = 0.00005; % Time step, second
% pIB_STIFF = 1000 * 2;
% N = 96; % Number of grid cells

% initialize();
% RENDER_DEBUG = 0;

% OUTPUT_PATH = 'E:/IBM_Space/output_21/%d.png';

% init_a();
% initX_ori();
% initInertia();

% %% Run simulation
% clock = 0;
% render();
% while clock < clockmax
%   clock = clock + 1;
%   step();
% end




% clc; 
% clear all
% global dt Nb N h rho mu ip im a;
% global kp km dtheta K;
% global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
% global big_G;
% defineConstants();

% dt = 0.00002; % Time step, second
% pIB_STIFF = 1000 * 5;
% N = 96; % Number of grid cells

% initialize();
% RENDER_DEBUG = 0;

% OUTPUT_PATH = 'E:/IBM_Space/output_31/%d.png';

% init_a();
% initX_ori();
% initInertia();

% %% Run simulation
% clock = 0;
% render();
% while clock < clockmax
%   clock = clock + 1;
%   step();
% end




% clc; 
% clear all
% global dt Nb N h rho mu ip im a;
% global kp km dtheta K;
% global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
% global big_G;
% defineConstants();

% dt = 0.00002; % Time step, second
% pIB_STIFF = 1000 * 5;
% N = 128; % Number of grid cells

% initialize();
% RENDER_DEBUG = 0;

% OUTPUT_PATH = 'E:/IBM_Space/output_32/%d.png';

% init_a();
% initX_ori();
% initInertia();

% %% Run simulation
% clock = 0;
% render();
% while clock < clockmax
%   clock = clock + 1;
%   step();
% end




% clc; 
% clear all
% global dt Nb N h rho mu ip im a;
% global kp km dtheta K;
% global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
% global big_G;
% defineConstants();

% dt = 0.00002; % Time step, second
% pIB_STIFF = 1000 * 5;
% N = 192; % Number of grid cells

% initialize();
% RENDER_DEBUG = 0;

% OUTPUT_PATH = 'E:/IBM_Space/output_33/%d.png';

% init_a();
% initX_ori();
% initInertia();

% %% Run simulation
% clock = 0;
% render();
% while clock < clockmax
%   clock = clock + 1;
%   step();
% end




clc; 
clear all
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();

dt = 0.00005; % Time step, second
pIB_STIFF = 1000 * 2;
N = 128; % Number of grid cells

initialize();
RENDER_DEBUG = 0;

OUTPUT_PATH = 'E:/IBM_Space/output_22/%d.png';

init_a();
initX_ori();
initInertia();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();
end




clc; 
clear all
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();

dt = 0.00005; % Time step, second
pIB_STIFF = 1000 * 2;
N = 192; % Number of grid cells

initialize();
RENDER_DEBUG = 0;

OUTPUT_PATH = 'E:/IBM_Space/output_23/%d.png';

init_a();
initX_ori();
initInertia();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();
end




clc; 
clear all
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();

dt = 0.0001; % Time step, second
N = 128; % Number of grid cells

initialize();
RENDER_DEBUG = 0;

OUTPUT_PATH = 'E:/IBM_Space/output_12/%d.png';

init_a();
initX_ori();
initInertia();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();
end




clc; 
clear all
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();

dt = 0.0001; % Time step, second
N = 192; % Number of grid cells

initialize();
RENDER_DEBUG = 0;

OUTPUT_PATH = 'E:/IBM_Space/output_13/%d.png';

init_a();
initX_ori();
initInertia();

%% Run simulation
clock = 0;
render();
while clock < clockmax
  clock = clock + 1;
  step();
end




