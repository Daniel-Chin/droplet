function f=sk(u,g)
global ip im h;
f=((u(ip,:,1)+u(:,:,1)).*g(ip,:)...
  -(u(im,:,1)+u(:,:,1)).*g(im,:)...
  +(u(:,ip,2)+u(:,:,2)).*g(:,ip)...
  -(u(:,im,2)+u(:,:,2)).*g(:,im))/(4*h);
