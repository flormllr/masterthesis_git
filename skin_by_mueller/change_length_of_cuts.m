function cut_list = change_length_of_cuts(cut_list, cuts_to_change, change_by)
% SUMMARY:
%       This function changes the the length of certain cuts of cut_list
%       specified in cuts_to_change by the percentage value given in
%       change_by. Negative entries in change_by means that we want to
%       shorten the cut, positive entries indicate that we want to lengthen
%       the cut.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       cuts_to_change: indices of the cuts in cuts_list that we want to
%           change the length of
%       change_by: percentage values (+/-) that we want to lengthen/shorten
%           the associated cut in cut_list by
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

if isscalar(change_by)
    change_by = change_by*ones(length(cuts_to_change),1);
end

for i = 1:length(cuts_to_change)
    cut = cut_list(cuts_to_change(i),:);
    old_cut_length = norm(cut(3:4)-cut(1:2));
    new_cut_length = old_cut_length*(1+change_by(i));
    move_length = (new_cut_length - old_cut_length) / 2;
    direction = (cut(3:4) - cut(1:2)) / old_cut_length;
    cut_list(cuts_to_change(i),1:2) = cut(1:2) - move_length*direction;
    cut_list(cuts_to_change(i),3:4) = cut(3:4) + move_length*direction;
end

end