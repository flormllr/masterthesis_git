function cut_list = shorten_edges(cut_list, relative_gap_size)
% SUMMARY:
%       This function shortens the edges of the cuts given in cut_list.
%       This has to be done when we have a certain pattern (e.g. grid)
%       where two cuts are too close or exactly next to eachother. By
%       shortening the edges two cuts won't be connected anymore.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       relative_gap_size: size, relative to the old size of the gap/cut,
%           that will be shortened by
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row. The
%           edges are now shorter, i.e. the points in cut_list further
%           apart from eachother.

for i = 1:size(cut_list,1)
    cut = cut_list(i,:);
    dx = cut(3)-cut(1);
    dy = cut(4)-cut(2);
    n = norm([dx, dy]);
    dx = dx/n;
    dy = dy/n;
    cut(1) = cut(1)+relative_gap_size*dx;
    cut(2) = cut(2)+relative_gap_size*dy;
    cut(3) = cut(3)-relative_gap_size*dx;
    cut(4) = cut(4)-relative_gap_size*dy;
    cut_list(i,:) = cut;
end

end