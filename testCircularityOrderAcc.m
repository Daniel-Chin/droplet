ci_his = [];
h_his = [.0001 .004 .008 .016 .032 .064 .128];
i = 0;
for h = h_his
  n_init_droplets = 1;
  init_circle_rad = ones(n_init_droplets, 1);
  init_circle_pos = zeros(n_init_droplets, 2);
  initX_multi_circle();
  i = i + 1;
  ci_his(i) = calcPerimeter(X, Nb, links);
end
plot(-log(h_his(2:end)), log(abs(ci_his(2:end) - ci_his(1))));
axis equal;
