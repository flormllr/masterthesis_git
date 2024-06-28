function generate_dossier_10x10_pdf(names)
% SUMMARY:
%       This function generates the dossier for the 10x10 patterns.
%       It is saved/appended in the pdf-file called "dossier10x10".
% INPUT:
%       names: string(-array), specifying the names of the patterns we want
%           to add to the dossier10x10.pdf file. If empty, we generate the
%           dossier for all available 10x10-pattern.

if nargin < 1
    names = ["lines", "grid", "s", "hexagon", "octagon", "hilbert_curve",...
        "sierpinski_curve", "peano_curve", "gosper_curve", "swap",...
        "swap_diagonal", "zigzag", "z_curve", "e_curve"];
end

patterns_to_show_original = ["s", "hexagon", "octagon", "hilbert_curve",...
        "sierpinski_curve", "peano_curve", "gosper_curve", "gosper_curve_2",...
        "z_curve", "e_curve"];
A4_width_cm = 21;
A4_height_cm = 29.7;

close

for i = 1:length(names)
    pattern = names(i);
    cut_list = get_cut_list_patterns_10x10_cutsEverywhere(pattern);

    horizontal_and_vertical = true;
    displacement = 0.5;
    [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
    displacement = 0.25;
    [~, result2] = compute_skin(cut_list, displacement, horizontal_and_vertical);

    fig = figure('Visible','Off');
    % tiledlayout(3, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
    t = tiledlayout(3,2);
    title_name = strrep(pattern,'_',' ') + ": stretch horizontal and vertical";
    title(t, title_name)

    if any(pattern == patterns_to_show_original)
        nexttile;
        plot_cut_list(cut_list)
        hold on
        plot([0,0,1,1],[0,1,1,0],'k-')
        hold off
        title(strrep(pattern,'_',' '))
        axis tight
        axis equal

        nexttile;
        plot_cut_list(get_cut_list_patterns_10x10(pattern))
        hold on
        plot([0,0,1,1],[0,1,1,0],'k-')
        hold off
        title("pattern")
        axis tight
        axis equal
    else
        nexttile([1 2]);
        plot_cut_list(cut_list)
        hold on
        plot([0,0,1,1],[0,1,1,0],'k-')
        hold off
        title(strrep(pattern,'_',' '))
        axis tight
        axis equal
    end

    nexttile;
    plot_solution_on_skin(result);
    title("displacement = 0.5")

    nexttile;
    plot_solution_on_skin(result2);
    title("displacement = 0.25")

    nexttile;
    plot_von_mises_stress(result);
    title("von Mises stress")

    nexttile;
    plot_von_mises_stress(result,true);
    title("von Mises stress in log scale")

    set(fig, 'Units', 'centimeters','OuterPosition', [0 0 A4_width_cm A4_height_cm])
    % set(fig, 'Position', [100, 100, A4_width_cm*100/2.54, A4_height_cm*100/2.54]);

    exportgraphics(fig, "dossier10x10.pdf", 'ContentType', 'image', 'BackgroundColor', 'white', 'Append', true);
    close(fig);

    % This next part is to add stretching only in vertical direction to the dossier

    horizontal_and_vertical = false;
    displacement = 0.5;
    [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
    displacement = 0.25;
    [~, result2] = compute_skin(cut_list, displacement, horizontal_and_vertical);

    fig = figure('Visible','Off');
    t = tiledlayout(3,2);
    title_name = strrep(pattern,'_',' ') + ": stretch only vertical";
    title(t, title_name)

    nexttile;
    plot_solution_on_skin(result);
    title("displacement = 0.5")

    nexttile;
    plot_solution_on_skin(result2);
    title("displacement = 0.25")

    nexttile;
    plot_von_mises_stress(result);
    title("von Mises stress")

    nexttile;
    plot_von_mises_stress(result,true);
    title("von Mises stress in log scale")

    set(fig, 'Units', 'centimeters','OuterPosition', [0 0 A4_width_cm A4_height_cm])

    exportgraphics(fig, "dossier10x10.pdf", 'ContentType', 'image', 'BackgroundColor', 'white', 'Append', true);
    close(fig);
end

end