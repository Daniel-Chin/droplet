area_calc_origin = [L/2, L/2];
oa = X(1:Nb, :) - area_calc_origin;
ob = X(links(2, 1:Nb), :) - area_calc_origin;
areas = cross([oa, zeros(Nb, 1)], [ob, zeros(Nb, 1)]) / 2;
droplet_area = sum(areas(:, 3));
