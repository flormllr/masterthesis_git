function [output_image, result] = compute_skin(cut_list, displ, horizontal_and_vertical, innerFace)
% SUMMARY:
%       This function cumputes the skin, i.e. generates and solves the PDE
%       to stretch the skin with the given cuts.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       displ: displacement, tells us how hard/far we want to stretch
%       horizontal_and_vertical: boolean, true if we should stretch
%           horizonatal and vertical, false if we only stretch vertical
%       innerFace: coordinates of a second face in our geometry. The mesh
%           will adjust to the square specified here. Is used to calculate
%           the Lp-norm on a subdomain more exact. If nothing is specified
%           there is no second face.
%           example: [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
% OUTPUT:
%       output_image: data for the output image
%       result: solution to our PDE represented in model

cs = 0.1;

if nargin < 4
    model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);
else
    model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs, innerFace);
end
% model = create_lin_elast_model_stretch_everywhere(cut_list, displ, horizontal_and_vertical);

% generates the mesh, Hmax is used to control the mesh size, 0.007
generateMesh(model,'Hmax',0.007);
% pdemesh(model); % to check how the mesh looks like

result = solve(model);
% pdeplot(model,'XYData',R.VonMisesStress,'Deformation',R.Displacement,'DeformationScaleFactor',1,'ColorMap','jet')

% output_image = visualize_model_solution(model, result);
output_image = [];

end