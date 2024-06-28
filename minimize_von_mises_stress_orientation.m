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

% orientation_new = zeros(1,n*n);
% orientation_new(2:9) = orientation(1:8);
% orientation_new(11:90) = orientation(9:88);
% orientation_new(92:99) = orientation(89:96);
% cut_list = generate_squares_with_cuts(n, orientation_new, 0.2);
cut_list = generate_squares_with_cuts(n, orientation, 0.2);

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