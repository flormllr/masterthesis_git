function VMstress = minimize_von_mises_stress_length_cuts(length, cut_list, p, xRange, yRange)
% SUMMARY:
%       This function creates and solves the model. The cuts of the model
%       are given in cut_list. The length of the cuts is changed by the
%       percentage values (+/-), given in length, that we want to
%       lengthen/shorten the cuts in cut_list by. We then calculate the
%       Lp-norm of the von Mises stress and return it.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       length: percentage values (+/-) that we want to lengthen/shorten
%           the cuts in cut_list by
%       p: integer, tells us which Lp-norm to use
% OUTPUT:
%       VMstress: the Lp-norm of the von Mises stress of the model

cs = 0.1;
displ = 0.5;
horizontal_and_vertical = true;

cut_list = change_length_of_cuts(cut_list, 1:size(cut_list,1), length);

model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);

% generates the mesh, Hmax is used to control the mesh size
generateMesh(model,'Hmax',0.007);
% inner_edges = size(cut_list,1);
% generateMesh(model,Hedge={1:(4+(4*inner_edges)), 0.003});

result = solve(model);

% VMstress = norm(result.VonMisesStress);
if nargin < 4
    VMstress = calculate_Lp_norm_von_mises_stress(result, p);
else
    VMstress = calculate_Lp_norm_von_mises_stress(result, p, xRange, yRange);
end

end