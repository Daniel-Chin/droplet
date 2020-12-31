% Two letters, "IB"

LETTER_VERTEX_I = [
    .26 .19;
    .31 .22;
    .31 .47;
    .26 .501;
    .42 .501;
    .37 .47;
    .37 .22;
    .42 .19
];
LETTER_VERTEX_B0 = [
    .45 .19;
    .49 .21;
    .49 .48;
    .45 .501;
    .64 .501;
    .69 .48;
    .72 .45;
    .73 .43;
    .73 .40;
    .71 .37;
    .68 .35;
    .65 .34;
    .71 .29;
    .71 .24;
    .67 .20;
    .62 .19    
];
LETTER_VERTEX_B1 = [
    .56 .22;
    .61 .22;
    .64 .24;
    .65 .27;
    .63 .31;
    .60 .33;
    .56 .33
];
LETTER_VERTEX_B2 = [
    .56 .35;
    .61 .35;
    .64 .37;
    .66 .41;
    .66 .44;
    .63 .47;
    .60 .48;
    .56 .48
];

dtheta = h / 2; % IB point spacing

X = zeros(1, 2);
links = zeros(2, 1);
wall_links = zeros(2, 0);  % special points that attach to the wall
Nb = 0;

for ring_i = 1:4
    switch ring_i
    case 1
        LETTER_VERTEX = LETTER_VERTEX_I;
    case 2
        LETTER_VERTEX = LETTER_VERTEX_B0;
    case 3
        LETTER_VERTEX = LETTER_VERTEX_B1;
    case 4
        LETTER_VERTEX = LETTER_VERTEX_B2;
    end
    N_VERTEX = size(LETTER_VERTEX, 1);
    last_vertex = LETTER_VERTEX(1, :);
    ring_start_Nb = Nb + 1;
    for vertex_trans = LETTER_VERTEX([2:N_VERTEX, 1], :)'
        vertex = vertex_trans';
        edge_len = norm(vertex - last_vertex);
        for k = 0 : dtheta / edge_len : 1
            Nb = Nb + 1;
            X(Nb, :) = [0, L] + (vertex * k + last_vertex * (1 - k)) .* [L, -L];
            links(2, Nb) = Nb + 1;
            links(1, Nb + 1) = Nb;
        end
        last_vertex = vertex;
    end
    links(2, Nb) = ring_start_Nb;
    links(1, ring_start_Nb) = Nb;
end

links = links(:, 1:Nb);
