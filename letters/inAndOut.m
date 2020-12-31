% what eular points are within the liquid phase?
% I vectorized. But not efficient. 

if size(wall_links, 2) ~= 0
    error("Hey, inAndOut does not expect wall links.");
end

ZEROS_UNIFORM_X4 = zeros(UNIFORM_X4_SIZE, 1);
IN_OUT_ORIGIN = [0, L/2 + h * pi]; % avoid overlap
XO = [IN_OUT_ORIGIN - UNIFORM_X4, ZEROS_UNIFORM_X4];
in_out_acc = zeros(UNIFORM_X4_SIZE, 1);
for k = 1 : Nb
    XA = X(k, :) - UNIFORM_X4;
    XB = X(links(2, k), :) - UNIFORM_X4;
    XAB = cross([XA, ZEROS_UNIFORM_X4], [XB, ZEROS_UNIFORM_X4]);
    XBO = cross([XB, ZEROS_UNIFORM_X4], XO);
    XOA = cross(XO, [XA, ZEROS_UNIFORM_X4]);
    XAB(:, 1) = XBO(:, 3);
    XAB(:, 2) = XOA(:, 3);
    in_out_acc = in_out_acc + all(XAB >= 0, 2);
    in_out_acc = in_out_acc + all(XAB > 0, 2);
    in_out_acc = in_out_acc - all(XAB < 0, 2);
    in_out_acc = in_out_acc - all(XAB <= 0, 2);
end
in_out_acc = in_out_acc / 2;
