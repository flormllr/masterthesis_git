function [new_cut_list] = repeat_pattern(cut_list, nx, ny, x_first_offset, y_first_offset, x_offset, y_offset, x_offset_second, y_offset_second, check_for_duplicates)
% SUMMARY:
%       This function repeats the given cut and returns the coordinates
%       from where to where the cuts go for the given pattern.
% INPUT:
%       cut_list: vector, tells us how the cut should look like (pattern)
%           example: [0, 0, 0.1, 0] tells us the cut starts from (0,0) and
%           goes to (0.1,0), i.e. is a straight line
%       nx: number of times we repeat the pattern in x-direction
%       ny: number of times we repeat the pattern in y-direction
%       x_first_offset: x-coordinate where the first cut should start
%       y_first_offset: y-coordinate where the first cut should start
%       x_offset: x-value of length of space to the neighboring cut
%       y_offset: y-value of length of space to the neighboring cut
%       x_offset_second: x-value of shift of even cuts
%       y_offset_second: y-value of shift of even cuts
%       check_for_duplicates: boolean, true if we need to check if a cut is
%           already added before adding it to new_cut_list
% OUTPUT:
%       new_cut_list: matrix with all the cuts. one cut is saved per row.

cuts_per_pattern = size(cut_list,1);
new_cut_list = zeros(nx*ny*cuts_per_pattern, 4);

[xmin, xmax] = bounds(cut_list(:,[1,3]), "all");
[ymin, ymax] = bounds(cut_list(:,[2,4]), "all");

% xmax = max(cut_list(:,[1,3]), [], "all");
% xmin = min(cut_list(:,[1,3]), [], "all");
% ymax = max(cut_list(:,[2,4]), [], "all");
% ymin = min(cut_list(:,[2,4]), [], "all");

xsize = xmax - xmin;
ysize = ymax - ymin;

counter = 1;
duplicate_counter = 0;
for i = 1:nx
    for j = 1:ny
        xpos = x_first_offset + (i-1)*xsize + (i-1)*x_offset;
        ypos = y_first_offset + (j-1)*ysize + (j-1)*y_offset;

        if mod(i,2) == 0
            ypos = ypos + y_offset_second;
        end
        if mod(j,2) == 0
            xpos = xpos + x_offset_second;
        end

        if check_for_duplicates
            [new_cut, duplicate_counter_new] = eliminate_duplicate_cuts(new_cut_list, [xpos+cut_list(:,1), ypos+cut_list(:,2), xpos+cut_list(:,3), ypos+cut_list(:,4)]);
            start_counter = counter*cuts_per_pattern-(cuts_per_pattern-1)-duplicate_counter;
            end_counter = counter*cuts_per_pattern-duplicate_counter-duplicate_counter_new;
            new_cut_list(start_counter:end_counter,:) = new_cut;
            counter = counter + 1;
            duplicate_counter = duplicate_counter + duplicate_counter_new;
        else
            start_counter = counter*cuts_per_pattern-(cuts_per_pattern-1);
            end_counter = counter*cuts_per_pattern;
            new_cut_list(start_counter:end_counter,:) = [xpos+cut_list(:,1), ypos+cut_list(:,2), xpos+cut_list(:,3), ypos+cut_list(:,4)];
            counter = counter + 1;
        end
       
    end
end

new_cut_list(end-duplicate_counter+1:end, :) = [];

end