function curvature = estimateCurvature(A, B, C)
  u_k_0 = -2*A(1) + 2*B(1);
  v_k_0 = -2*A(2) + 2*B(2);
  c_0 = A * A' - B * B';

  u_k_1 = -2*A(1) + 2*C(1);
  v_k_1 = -2*A(2) + 2*C(2);
  c_1 = A * A' - C * C';

  O = [u_k_0, v_k_0; u_k_1, v_k_1] \ [-c_0; -c_1];
  O = O';

  % u = O(1);
  % v = O(2);
  % disp(u_k_0*u + v_k_0*v + c_0);
  % disp(u_k_1*u + v_k_1*v + c_1);

  radius = norm(A - O);
  % disp(norm(B - O) / radius);
  % disp(norm(C - O) / radius);

  cross_ = cross([B - A, 0], [C - B, 0]);
  sign_ = cross_(3) / abs(cross_(3));

  curvature = sign_ / radius;
end
