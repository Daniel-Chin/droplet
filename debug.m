startid = 1;

id = links(1, startid);
stage = 0;
% x == 0.6
while id ~= 59
  x = X(id, 1);
  if stage == 0
    if x > .6
      stage = 1;
      display(id);
    end
  elseif stage == 1
    if x < .6
      stage = 2;
      display(id);
      break;
    end
  end
  id = links(1, id);
end
% plot(points(:,1),points(:,2),'ko');
