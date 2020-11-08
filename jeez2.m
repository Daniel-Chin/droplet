hold off
load e1
plot([1:clock] * dt, area_his, 'b-', 'linewidth', 1);
% plot([1:clock] * dt, resample_energy_offset_array, 'b-', 'linewidth', 1);
hold on
load e2
plot([1:clock] * dt, area_his, 'r:', 'linewidth', 1);
% plot([1:clock] * dt, resample_energy_offset_array, 'r:', 'linewidth', 1);
% axis([0 .1 0 .28]);
h = legend('N = 64', 'N = 128', 'N = 192');
set(h,'FontSize',12);
