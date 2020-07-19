% computationally heavy

function F=fakeRepel(XX4, dtheta4, Nb4, FAKE_REPEL_K)
  K = FAKE_REPEL_K * dtheta4;
  F = zeros(Nb4, 2);
  % for j = 1 : Nb4
  %   displace = (XX4 - XX4(j, :));
  %   icrtoavntdt = displace .* ([1 1] ./ sum((displace) .^ 2, 2));
  %   icrtoavntdt(j, :) = [0 0];  % `icrtoavntdt` stands for "I can't really think of any variable name that describes this"
  %   F(j, :) = sum(icrtoavntdt, 1) .* K;
  % end
end
