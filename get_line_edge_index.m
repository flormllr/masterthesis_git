function [pos] = get_line_edge_index(dl, coords, tol)
% SUMMARY:
%       This function tells us where a edge, given by coords, is located in
%       the geometry matrix dl. 
% INPUT:
%       dl: geometry matrix
%       coord: coordinates of the two points between which the cut is
%           located
%       tol: tolerance
% OUTPUT:
%       pos: index/position of the cut in the geometry matrix. tells us the
%           column in dl where we can find the cut.

dl_entry1 = [2; coords'];
dl_difference = dl(1:5,:) - repmat(dl_entry1,1,size(dl,2));
N = vecnorm(dl_difference,2,1);
pos = find(N < tol);

if isempty(pos)
    dl_entry2 = [2; coords(2); coords(1); coords(4); coords(3)];
    dl_difference= dl(1:5,:) - repmat(dl_entry2,1,size(dl,2));
    N = vecnorm(dl_difference,2,1);
    pos = find(N < tol);
end

end