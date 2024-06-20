function model = create_lin_elast_model_stretch_everywhere(cut_list, displ, horizontal_and_vertical)
% SUMMARY:
%       This function creates the linear elasticity model, which is used to
%       model the stretch of the skin. This is done with the help of the
%       "PDE Toolbox".
%       This is a special version where we don't have edges around the
%       corner where we don't pull. Here we pull along the entire edges of
%       the domain.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       displ: displacement, tells us how hard/far we want to stretch
%       horizontal_and_vertical: true if we should stretch horizonatlly and
%           vertically, false if we only stretch vertically
% OUTPUT:
%       model: model of our problem

model = createpde('structural','static-planestress');

% create the geometry and add it to our model
[model, dl] = create_geometry_stretch_everywhere(model, cut_list);

structuralProperties(model,'YoungsModulus',500e3,'PoissonsRatio',0.47,'MassDensity',1);

% now we need to specify the boundary conditions for the outer edges
tol = 1e-8;
% these positions tell us where we will "pull" to stretch the skin
pos_stretch_bottom = get_line_edge_index(dl, [0.0, 1.0, 0.0, 0.0], tol);
pos_stretch_left = get_line_edge_index(dl, [0.0, 0.0, 0.0, 1.0], tol);
pos_stretch_top = get_line_edge_index(dl, [0.0, 1.0, 1.0, 1.0], tol);
pos_stretch_right = get_line_edge_index(dl, [1.0, 1.0, 0.0, 1.0], tol);

% here we specify the boundary conditions of the outer edges where we want
% stretch, so how far the edges may move in x- and y-direction. this is
% exactly the normal vector.
if horizontal_and_vertical % stretch horizontal and vertical
    structuralBC(model,'Edge',pos_stretch_bottom,'Displacement',[0;-displ/2]);
    structuralBC(model,'Edge',pos_stretch_left,'Displacement',[-displ/2;0]);
    structuralBC(model,'Edge',pos_stretch_top,'Displacement',[0;displ/2]);
    structuralBC(model,'Edge',pos_stretch_right,'Displacement',[displ/2;0]);
else % only stretch vertical, don't want displacements in x-direction
     structuralBC(model,'Edge',pos_stretch_bottom,'Displacement',[0;-displ/2]);
     structuralBC(model,'Edge',pos_stretch_top,'Displacement',[0;displ/2]);
end

end