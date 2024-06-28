function VMstress = minimize_von_mises_stress_middle(n, n_middle, orientation_middle, p, innerFace)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in n*n squares. In the
%       n_middle*n_middle square, which are located in the middle of the
%       domain, we set the orientation as given in orientation. In the
%       squares around the middle we continue with the orientations as
%       given in the middle part. This is useful to test out different
%       patterns and minimize its von Mises stress, but with less degrees
%       of freedom.
%       We then create and solve this model, calculate the Lp-norm of the
%       von Mises stress and return it.
% INPUT:
%       n: number of little square the domain is divided into per row, >0,
%           in total there are thus n*n squares
%       n_middle: number of little squares in the middle, where we set the
%           orientation
%       orientation_middle: matrix of size n_middle*n_middle. each entry in
%           the middle sqares is either 0 (no cut), 1 (horizontal cut),
%           2 (vertical cut), 3 (diagonal cut, bottom left to top right),
%           4 (diagonal cut, bottom right to top left). tells us how the
%           cut in each square should look like.
%       p: integer, tells us which Lp-norm to use
%       innerFace: coordinates of a second face in our geometry. The mesh
%           will adjust to the square specified here. Is used to calculate
%           the Lp-norm on a subdomain more exact. If nothing is specified
%           there is no second face.
%           example: [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
% OUTPUT:
%       VMstress: the Lp-norm of the von Mises stress of the model

cs = 0.1;
displ = 0.5;
horizontal_and_vertical = true;

n_bigSquares = n/n_middle;
if mod(n_bigSquares, 2) ~= 1
    disp("No middle possible with these sizes of n and n_middle. See minimize_von_mises_stress_middle().")
    VMstress = [];
    return
end

orientation_middle = reshape(orientation_middle, [n_middle n_middle])';

orientation = repmat(orientation_middle, n_bigSquares)';
cut_list = generate_squares_with_cuts(n, orientation, 0.2);

if nargin < 5
    model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);
    generateMesh(model,'Hmax',0.007); % 0.007
    result = solve(model);
    VMstress = calculate_Lp_norm_von_mises_stress(result, p);
else
    model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs, innerFace);
    generateMesh(model,'Hmax',0.007); % 0.007
    result = solve(model);
    VMstress = calculate_Lp_norm_von_mises_stress(result, p, [min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
end

end