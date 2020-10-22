function s = calcPerimeter(X, Nb, links)
displace = X(links(1, 1:Nb),:) - X;
s = sum(vecnorm(displace'));
