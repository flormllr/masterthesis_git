function VMstress = minimize_von_mises_stress_orientation(n, orientation, p)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in n*n squares and in
%       each square we set a cut according to the orientation. We then
%       create and solve this model, calculate the Lp-norm of the von Mises
%       stress and return it.
% INPUT:
%       n: number of little square the domain is divided into per row, >0,
%           in total there are thus n*n squares
%       orientation: vector of size n*n. each entry is either 0 (no
%           cut), 1 (horizontal cut), 2 (vertical cut), 3 (diagonal cut,
%           bottom left to top right), 4 (diagonal cut, bottom right to top
%           left). tells us how the cut in each square should look like.
%       p: integer, tells us which Lp-norm to use
% OUTPUT:
%       VMstress: the Lp-norm of the von Mises stress of the model

cut_list = generate_squares_with_cuts(n, orientation);

% cut_list = shorten_edges(cut_list, 1/n/5);

cut_list = eliminate_cuts_around_corner(cut_list, 0.1 + 1/n/10);

cs = 0.1;
displ = 0.5;
horizontal_and_vertical = true;

model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);

% generates the mesh, Hmax is used to control the mesh size
generateMesh(model,'Hmax',0.007);

result = solve(model);

% VMstress = norm(result.VonMisesStress);
VMstress = calculate_Lp_norm_von_mises_stress(result, p);

end