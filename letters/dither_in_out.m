to_dither = find(in_out_acc == .5);
in_out_acc(to_dither(1:2:end)) = 1;
in_out_acc(to_dither(2:2:end)) = 0;
