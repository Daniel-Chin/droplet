hold off
load e1
% plot([1:clock] * dt, area_his(1:clock), 'b-', 'linewidth', 1);
plot([1:clock] * dt, resample_energy_offset_array(1:clock), 'b-', 'linewidth', 1);
hold on
load e2
% plot([1:clock] * dt, area_his(1:clock), 'r:', 'linewidth', 1);
plot([1:clock] * dt, resample_energy_offset_array(1:clock), 'r:', 'linewidth', 1);
% axis([0 .45 0 .14]);
axis([0 .45 -.01 .001]);
h = legend('N = 64', 'N = 128', 'N = 192');
set(h,'FontSize',12);
