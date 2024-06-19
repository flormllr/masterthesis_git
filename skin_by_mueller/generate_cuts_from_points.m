function [cut_list] = generate_cuts_from_points(px, py)
% SUMMARY:
%       This function generates cuts each between two neighboring points.
% INPUT:
%       px: x-coordinates of the points we want to cut inbetween
%       py: y-coordinates of the points we want to cut inbetween
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

cut_list = zeros(size(px,1)-1, 4);

for i=1:length(px)-1
    cut_list(i,:) = [px(i), py(i), px(i+1), py(i+1)];
end

end

