load('D:\IBM\main\rising_bubble\10to10\wall_stiff_8000\terminal_state.mat')
clock = 1499;

FONT_SIZE_MAIN = 18;
FONT_SIZE_LGD = 14;

bm_table = readtable("RB_10to10Vis/data_10to10Vis.txt");
sz = size(bm_table, 1);
bm_cm_y = zeros(sz, 1);
now_y = .5;
for k = 1 : sz
  now_y = now_y + bm_table{k, 6} * .0005;
  bm_cm_y(k) = now_y;
end
hold off;
plot(0);

ax = subplot(2, 2, 1);
hold on; 
plot(dt * [1:clock], CM_his, 'Color', 'r');
plot(bm_table{:, 1}, bm_cm_y, 'Color', 'k');
lgd = legend("IB", "Featflow", 'Location', 'NW', 'interpreter', 'latex');
ylabel("Altitude (cm)", 'interpreter', 'latex');
set(ax, 'xtick', []);
formatPlot();
ax.FontSize = FONT_SIZE_MAIN;
lgd.FontSize = FONT_SIZE_LGD;

% plot absolute error. 
% headache: they are not of the same sample rate. 
ax = subplot(2, 2, 3);
hold on; 
plot(dt * [1:clock], CM_his' - bm_cm_y(1:4:clock*4), 'Color', 'r');
line(xlim(), [0 0], 'Color', 'k');

lgd = legend("IB", "Featflow", 'Location', 'NW', 'interpreter', 'latex');
ylabel("Error (cm)", 'interpreter', 'latex');
xlabel("Time", 'interpreter', 'latex');
axis([0 3 -.0005 0.0025]);
formatPlot();
ax.FontSize = FONT_SIZE_MAIN;
lgd.FontSize = FONT_SIZE_LGD;

ax = subplot(2, 2, 2);
hold on; 
plot(dt * [1:clock], circularity_his, 'Color', 'r');
plot(bm_table{:, 1}, bm_table{:, 4}, 'Color', 'k');
lgd = legend("IB", "Featflow", 'Location', 'NE', 'interpreter', 'latex');
ylabel("Circularity Index", 'interpreter', 'latex');
set(ax, 'xtick', []);
formatPlot();
ax.FontSize = FONT_SIZE_MAIN;
lgd.FontSize = FONT_SIZE_LGD;

ax = subplot(2, 2, 4);
hold on; 
plot(dt * [1:clock], circularity_his' - bm_table{:, 4}(1:4:clock*4), 'Color', 'r');
line(xlim(), [0 0], 'Color', 'k');

lgd = legend("IB", "Featflow", 'Location', 'NE', 'interpreter', 'latex');
ylabel("Error", 'interpreter', 'latex');
xlabel("Time (s)", 'interpreter', 'latex');
axis([0 3 -.0005 0.0015]);
formatPlot();
ax.FontSize = FONT_SIZE_MAIN;
lgd.FontSize = FONT_SIZE_LGD;
