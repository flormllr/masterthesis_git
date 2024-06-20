function cut_list = eliminate_cuts_around_corner(cut_list, cs)
% SUMMARY:
%       This function eliminates all the cuts that are close to the corner.
%       All the cuts that are contained in a polygon of edge size cs around
%       the corner are eliminated.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       cs: corner size, i.e. how much space should be cut-free
% OUTPUT:
%       cut_list: matrix with all the cuts that aren't close to the corner

cut_count = size(cut_list,1);

% coordinates for polygon, where we want the cuts to stay
xv = [cs, 1-cs, 1, 1, 1-cs, cs, 0, 0, cs];
yv = [0, 0, cs, 1-cs, 1, 1, 1-cs, cs, 0];

for i = cut_count:-1:1
    if ~all(inpolygon([cut_list(i,1), cut_list(i,3)], [cut_list(i,2), cut_list(i,4)], xv, yv))
        cut_list(i,:) = [];
    end
end

% here we have a square instead of triangle around the corner without cuts
% for i = cut_count:-1:1
%     if any([cut_list(i,1), cut_list(i,3)] < cs) || any([cut_list(i,1), cut_list(i,3)] > 1-cs)
%         if any([cut_list(i,2), cut_list(i,4)] < cs) || any([cut_list(i,2), cut_list(i,4)] > 1-cs)
%             cut_list(i,:) = [];
%         end
%     end
% end

end