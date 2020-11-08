hold off
% load merge2a
load merge6_a
plot([1:clock] * dt, area_his, 'b-', 'linewidth', 1);
% plot([1:clock] * dt, resample_energy_offset_array, 'b-', 'linewidth', 1);
hold on
% load merge2b
load merge6_b
plot([1:clock] * dt, area_his, 'r:', 'linewidth', 1);
% plot([1:clock] * dt, resample_energy_offset_array, 'r:', 'linewidth', 1);
% load merge2c
load merge6_c
plot([1:clock] * dt, area_his, 'g--', 'linewidth', 1);
% plot([1:clock] * dt, resample_energy_offset_array, 'g--', 'linewidth', 1);
% axis([0 .1 .185 .21]);
% axis([0 .1 0 .23]);
% axis([0 .1 .22 .28]);
axis([0 .1 0 .28]);
% axis([0 .1 -.7 .05]);
% h = legend('N = 96', 'N = 128', 'N = 192');
h = legend('N = 64', 'N = 96', 'N = 128');
set(h,'FontSize',12);
