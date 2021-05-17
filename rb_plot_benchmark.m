clock = 1499;

bm_table = readtable("RB_10to10Vis/data_10to10Vis.txt");
sz = size(bm_table, 1);
bm_cm_y = zeros(sz, 1);
now_y = .5;
for k = 1 : sz
  now_y = now_y + bm_table{k, 6} * .0005;
  bm_cm_y(k) = now_y;
end
hold off;
plot(bm_table{:, 1}, bm_cm_y); 
hold on; 
plot(dt * [1:clock], CM_his);
legend("Benchmark", "Ours", 'Location', 'SE', 'interpreter', 'latex');
xlabel("Time", 'interpreter', 'latex');
ylabel("Altitude", 'interpreter', 'latex');
formatPlot();
pause();

hold off;
plot(bm_table{:, 1}, bm_table{:, 4}); 
hold on; 
plot(dt * [1:clock], circularity_his);
legend("Benchmark", "Ours", 'Location', 'NE', 'interpreter', 'latex');
xlabel("Time", 'interpreter', 'latex');
ylabel("Circularity Index", 'interpreter', 'latex');
formatPlot();
