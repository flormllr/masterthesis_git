function plot_cut_list(cut_list)
% SUMMARY:
%       This function plots the given cut_list, i.e. shows us the pattern
%       of the cuts.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

hold on
for i = 1:size(cut_list,1)
    x = [cut_list(i,1); cut_list(i,3)];
    y = [cut_list(i,2); cut_list(i,4)];
    plot(x, y, '-b', 'LineWidth', 1);
end
xlim([0,1])
ylim([0,1])
hold off

end