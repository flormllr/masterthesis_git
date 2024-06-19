function model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs, innerFace)
% SUMMARY:
%       This function creates the linear elasticity model, which is used to
%       model the stretch of the skin. This is done with the help of the
%       "PDE Toolbox".
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       displ: displacement, tells us how hard/far we want to stretch
%       horizontal_and_vertical: true if we should stretch horizonatlly and
%           vertically, false if we only stretch vertically
%       cs: corner size, i.e. how far the corner can be stretched in
%       innerFace: coordinates of a second face in our geometry. The mesh
%           will adjust to the square specified here. If nothing is
%           specified there is no second face.
% OUTPUT:
%       model: model of our problem

% creates a structural model for static analysis of a planestress problem
% we use "planestress" and not "planestrain", since we don't want
% deformation in the direction perpendicular to the plane
model = createpde('structural','static-planestress');

% create the geometry and add it to our model
if nargin < 5
    [model, dl] = create_geometry(model, cut_list, cs);
else
    [model, dl] = create_geometry_multiple_faces(model, cut_list, cs, innerFace);
end

% pdegplot(dl,'EdgeLabels','off','FaceLabels','on'); % to check if geometry looks fine

% assigns Young's modulus and Poisson's ratio for the entire geometry
% also assign the mass density
% structuralProperties(model,'YoungsModulus',500000,'PoissonsRatio',0.47);
structuralProperties(model,'YoungsModulus',500e3,'PoissonsRatio',0.47,'MassDensity',1);

% now we need to specify the boundary conditions for the outer edges
tol = 1e-8;
% these positions tell us where we will "pull" to stretch the skin
pos_stretch_bottom = get_line_edge_index(dl, [0+cs, 1-cs, 0.0, 0.0], tol);
pos_stretch_left = get_line_edge_index(dl, [0.0, 0.0, 0+cs, 1-cs], tol);
pos_stretch_top = get_line_edge_index(dl, [0+cs, 1-cs, 1.0, 1.0], tol);
pos_stretch_right = get_line_edge_index(dl, [1.0, 1.0, 0+cs, 1-cs], tol);

% these positions are of the edges on the outer boundary where we don't
% want to stretch, i.e. the ones directly around the corners
pos_corner = zeros(8,1);
pos_corner(1) = get_line_edge_index(dl, [0.0, cs, 0.0, 0.0], tol);
pos_corner(2) = get_line_edge_index(dl, [0.0, cs, 1.0, 1.0], tol);
pos_corner(3) = get_line_edge_index(dl, [1-cs, 1, 0.0, 0.0], tol);
pos_corner(4) = get_line_edge_index(dl, [1-cs, 1, 1.0, 1.0], tol);
pos_corner(5) = get_line_edge_index(dl, [0.0, 0.0, 0.0, cs], tol);
pos_corner(6) = get_line_edge_index(dl, [1.0, 1.0, 0.0, cs], tol);
pos_corner(7) = get_line_edge_index(dl, [0.0, 0.0, 1-cs, 1], tol);
pos_corner(8) = get_line_edge_index(dl, [1.0, 1.0, 1-cs, 1], tol);

% now we set the edges around the corner to be free, so they can be
% stretched accordingly
structuralBC(model,'Edge',pos_corner,'Constraint','free');

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

% % inner edges are free, so they can be stretched accordingly
% cut_count = size(cut_list,1);
% positions_inner = 1:cut_count;
% positions_inner([pos_corner', pos_stretch_bottom, pos_stretch_top, pos_stretch_right, pos_stretch_left]) = [];
% structuralBC(model,'Edge',positions_inner,'Constraint','free');

end