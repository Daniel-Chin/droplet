clc; clear all; close all;
global dt Nb N h rho mu ip im a;
global kp km dtheta K;
global WALL_STIFFNESS PERFECT_WALL NO_SLIP_FORCE SLIP_LENGTH_COEF;
global big_G;
defineConstants();
initialize();
init_a

Nb=2 * Nb; % Number of IB points
kp=[(2:Nb),1]; % IB index shifted left
km=[Nb,(1:(Nb-1))]; % IB index shifted right
k=0:(Nb-1);
theta = k' * dtheta;
init_circle_x = L * .25;
init_circle_y = L * 0.5;
init_circle_r = L / 8;
X = [init_circle_x, init_circle_y] + init_circle_r * [sin(theta*2), cos(theta*2)];

dtheta4 = h / 2;
estimated_area = (init_circle_r / dtheta4) ^ 2 * pi / 2;
X4 = zeros(floor(estimated_area * .7), 2);
Nb4 = 0;
for i = 0 : dtheta4 : L
  for j = 0 : dtheta4 : L
    if norm([i-init_circle_x, j-init_circle_y]) < init_circle_r
      Nb4 = Nb4 + 1;
      X4(Nb4, :) = [i, j];
    end
  end
end

Y4 = X4;
V4 = zeros(Nb4, 2);
MASS_PER_POINT = (rho_heavy - rho) * dtheta4 ^ 2;

%% Run simulation
ttt=1;
tmax = .5;
clockmax=ceil(tmax/dt);
for clock=1:clockmax
  hold off
  %animation:
  vorticity=(u(ip,:,2)-u(im,:,2)-u(:,ip,1)+u(:,im,1))/(2*h);
  % dvorticity=(max(max(vorticity))-min(min(vorticity)))/5;
  % values= (-10*dvorticity):dvorticity:(10*dvorticity); % Get vorticity contours
  % if any(values)
  %   valminmax=[min(values),max(values)];
  % else
  %   valminmax = [-69 69];
  % end
  contour(xgrid,ygrid,vorticity(1:end/2, :),values);
  hold on

  XX=X+(dt/2)*vec_interp(u, X, Nb); % Euler step to midpoint
  XX3 = X3 + (dt/2) * vec_interp(u, X3, Nb3); % Euler step to midpoint
  XX4 = X4 + (dt/2) * vec_interp(u, X4, Nb4); % Euler step to midpoint

  % surface tension
  p = (X(kp,:) - X)';
  m = (X(km,:) - X)';
  F = K * (p ./ vecnorm(p) + m ./ vecnorm(m))';
  
  ff=vec_spread(F, XX, dtheta, Nb); % Force at midpoint
  if ttt == 1
    YY4 = Y4 + V4 * dt;
    force4 = forcePib(YY4 - XX4, pIB_STIFF);
    ff4 = vec_spread(force4, XX4, dtheta4, Nb4);
    force4_g = force4;
    force4_g(:, 2) = force4_g(:, 2);
    V4 = V4 - force4_g * dt / MASS_PER_POINT;
    Y4 = Y4 + V4 * dt;
    total_ff = ff + ff4;
  else
    total_ff = ff;
  end
  total_ff = total_ff + total_ff(end:-1:1, :, :) .* MIRROR;
  [u,uu]=fluid(u,total_ff); % Step Fluid Velocity

  X=X+dt*vec_interp(uu, XX, Nb); % full step using midpoint velocity
  X3 = X3 + dt * vec_interp(uu, XX3, Nb3); % full step using midpoint velocity  
  X4 = X4 + dt * vec_interp(uu, XX4, Nb4); % full step using midpoint velocity  
  
      threshold = 1.414 * dtheta;
      new_X = zeros(size(X));
      
      % take out
      started = false;
      j = 1;
      while j <= Nb
        if started
          if norm(new_X(new_Nb, :) - X(j, :)) > threshold
            new_Nb = new_Nb + 1;
            new_X(new_Nb, :) = X(j - 1, :);
          else
            plot(X(j - 1, 1), X(j - 1, 2), 'ro');
          end
        else
          if X(j, 1) > - dtheta / 2
            new_X(1, :) = X(j, :);
            new_Nb = 1;
            j = j + 1;
            started = true;
          end
        end
        j = j + 1;
      end
      new_Nb = new_Nb + 1;
      new_X(new_Nb, :) = X(end, :);
      j = new_Nb;
      while new_X(j, 1) < - dtheta / 2
        new_Nb = new_Nb - 1;
        j = j - 1;
      end
      
      % put in
      j = 1;
      while j <= new_Nb - 1
        space = norm(new_X(j, :) - new_X(j + 1, :));
        if space > threshold
          b = new_X(j    , :);
          c = new_X(j + 1, :);
          point = (b + c) ./ 2;
          if j >= 2 && j <= new_Nb -2
            aa = new_X(j - 1, :);
            d = new_X(j + 2, :);
            ab = b - aa;
            dc = c - d;
            rhs1 = dot(aa, [b(2), -b(1)]);
            rhs2 = dot(d, [c(2), -c(1)]);
            intersection = [ab(2), -ab(1); dc(2), -dc(1)] \ [rhs1; rhs2];
            % display(intersection);
            % display(point);
            % plot(intersection(1), intersection(2), 'rx');
            % plot(point(1), point(2), 'bx');
            if norm(intersection - point) < threshold * .5
              point = point .* .5 + intersection' .* .5;
            end
            plot(point(1), point(2), 'bo');
            % pause;
          end
          new_X(j+2 : new_Nb+1, :) = new_X(j+1 : new_Nb, :);
          new_Nb = new_Nb + 1;
          new_X(j+1, :) = point;
          j = j + 1;
        end
        j = j + 1;
      end
      
      new_X = new_X(1:new_Nb, :);
      kp=[(2:new_Nb),1]; % IB index shifted left
      km=[new_Nb,(1:(new_Nb-1))]; % IB index shifted right
    X = new_X;
    Nb = new_Nb;
    warpIndicators;

  % plot([0 0], [0 L], 'r');
  plot([0 0], [0 L], 'r');
  plot([h h], [0 L], 'r');
  plot([h*2 h*2], [0 L], 'r');
  plot(X3(:,1),X3(:,2),'k.')
  plot(X4(:,1),X4(:,2),'g.')
  plot(X(:,1),X(:,2),'b.')
  % axis([-L/100,L/2,0,L])
  caxis(valminmax)
  axis equal
  axis manual
  title(sprintf('t = %.3f, G = %.1f', clock * dt, big_G));
  drawnow
  saveFrame();
  % pause(1);

  if clock == floor(.05 / dt)
    for j = 22:26
      for k = 10:30
        u(j, k, 2) = 24;
        u(N - j, k, 2) = -24;
        % ttt = 0;
      end
    end
  end
  % pause;
end
