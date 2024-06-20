function [cut] = generate_cut(coord, th)
% SUMMARY:
%       This function generates a cut between two points.
% INPUT:
%       coord: coordinates of the two points between which we want to cut
%       th: tells us how wide/big the cut should be
% OUTPUT:
%       cut: coordinates of rectangle, s.t. this can directly be added to a
%           geometry description matrix

x1 = coord(1);
x2 = coord(3);
y1 = coord(2);
y2 = coord(4);

grad = [x2-x1; y2-y1];
% normal vector
n = [-grad(2); grad(1)];
n = n/norm(n)*th;

geom_cut = [x1-n(1), y1-n(2);
    x2-n(1), y2-n(2);
    x2+n(1), y2+n(2);
    x1+n(1), y1+n(2)];

% 3 stands for a rectangle, 4 for the four edges
cut = [3; 4; geom_cut(:)];

end

