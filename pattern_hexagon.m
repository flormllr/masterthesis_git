function [cut_list] = pattern_hexagon(b)
% SUMMARY:
%       This function generates the cut_list for one hexagon.
% INPUT:
%       b: factor, that tells us how big the hexagon should be
% OUTPUT:
%       cut_list: matrix with all the cuts for one hexagon. one cut is
%           saved per row.


% degrees
theta = 0:60:360;
x = cosd(theta);
y = sind(theta);

% centering
x = x - min(x);
y = y - min(y);

% list of points
P = [x', y'];

% compress the hexagon by factor b
P = P*b;
cut_list = generate_cuts_from_points(P(:,1), P(:,2));

end