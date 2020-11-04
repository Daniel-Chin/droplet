while 1
  image(u(:,:,1) ./ max(max(abs(u(:,:,1)))) .* 128 + 128);
  u = fluid(u, zeros(N,N,2));
  pause(.1)
end
