function [new_cut, duplicate_counter_new] = eliminate_duplicate_cuts(cut_list, cut_to_add)
% SUMMARY:
%       This function checks if some cuts in cut_to_add are already present
%       in cut_list. If a cut is already there it is eliminated. Cuts that
%       aren't already there are then returned.
%       It is used in repeat_pattern if we need to check for duplicates.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       cut_to_add: cut that we want to add to cut_list
% OUTPUT:
%       new_cut: cut that can be added to cut_list as they are new cuts
%       duplicate_counter_new: amount of duplicate cuts that were
%           eliminated

other_direction = [cut_to_add(:,3), cut_to_add(:,4), cut_to_add(:,1), cut_to_add(:,2)];
idxs1 = ismembertol(cut_to_add, cut_list, "ByRows", true);
idxs2 = ismembertol(other_direction, cut_list, "ByRows", true);
if any(idxs1) || any(idxs2)
    idxs = or(idxs1, idxs2);
    new_cut = cut_to_add(~idxs,:);
    duplicate_counter_new = sum(idxs);
    %       cuts_per_pattern: amount of cuts that have to be done per new
    %           repeat of the pattern
    %       counter: tells us in which step of repeat_pattern we are and thus
    %           where we add new points to cut_list
    %       duplicate_counter: tells us how many duplicates have already been
    %           found in total so we know where to add new points to cut_list
    % if any(idxs1) && any(idxs2)
    %     new_cut1 = cut_to_add(~idxs1,:);
    %     duplicate_counter_new = sum(idxs1);
    %     start_counter = counter*cuts_per_pattern-(cuts_per_pattern-1)-duplicate_counter;
    %     end_counter = counter*cuts_per_pattern-duplicate_counter-duplicate_counter_new;
    %     cut_list(start_counter:end_counter,:) = new_cut1;
    % 
    %     idxs2 = ismembertol(other_direction, cut_list, "ByRows", true);
    %     if any(idxs2)
    %         new_cut2 = other_direction(~idxs2,:);
    %         duplicate_counter_new2 = sum(idxs2);
    %     else
    %         new_cut2 = [];
    %         duplicate_counter_new2 = 0;
    %     end
    % 
    %     new_cut = [new_cut1; new_cut2];
    %     duplicate_counter_new = duplicate_counter_new + duplicate_counter_new2;
    % elseif any(idxs1)
    %     new_cut = cut_to_add(~idxs1,:);
    %     duplicate_counter_new = sum(idxs1);
    % else
    %     new_cut = other_direction(~idxs2,:);
    %     duplicate_counter_new = sum(idxs2);
    % end
else % not there yet, have to add it
    new_cut = cut_to_add;
    duplicate_counter_new = 0;
end

end