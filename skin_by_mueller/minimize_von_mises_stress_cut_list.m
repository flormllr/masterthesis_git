function VMstress = minimize_von_mises_stress_cut_list(cut_list, p)
% SUMMARY:
%       This function creates and solves the model. The cuts of the model
%       are given in cut_list. We then calculate the Lp-norm of the von
%       Mises stress and return it.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       p: integer, tells us which Lp-norm to use
% OUTPUT:
%       VMstress: the Lp-norm of the von Mises stress of the model

% cut_list = shorten_edges(cut_list, 1/n/5);

% cut_list = eliminate_cuts_around_corner(cut_list, 0.1 + 1/n/10);

cs = 0.1;
displ = 0.5;
horizontal_and_vertical = true;

model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);

% generates the mesh, Hmax is used to control the mesh size
generateMesh(model,'Hmax',0.007);
% inner_edges = size(cut_list,1);
% generateMesh(model,Hedge={1:(4+(4*inner_edges)), 0.003});

result = solve(model);

% VMstress = norm(result.VonMisesStress);
VMstress = calculate_Lp_norm_von_mises_stress(result, p);

end