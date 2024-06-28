function save_pattern_as_dossier_page_pdf(cut_list, name, filename, drawBox, subdomain)
% SUMMARY:
%       This function generates a page as in the dossier of the pattern
%       specified in cut_list. The pattern gets the name as specified in
%       name and is saved as a pdf-file under the name given in filename.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       name: string, name of the pattern
%       filename: string, name of the generated pdf-file
%       drawBox: coordinates of a box that should be drawn in the plot of
%           the cut_list. If nothing is specified there is no additional
%           box drawn.
%           example: [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
%       subdomain: coordinates of a box where we also want to calculate the
%           Lp-norm of the von Mises stress. If nothing is specified, only
%           the Lp-norm of the entire domain is displayed.
%           example: [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];

close
A4_width_cm = 21;
A4_height_cm = 29.7;

ffilename = filename + ".pdf";

horizontal_and_vertical = true;
displacement = 0.5;
if nargin > 4
    [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical, subdomain);
else
    [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
end

displacement = 0.25;
[~, result2] = compute_skin(cut_list, displacement, horizontal_and_vertical);

fig = figure('Visible','Off');
% tiledlayout(3, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
t = tiledlayout(3,2);
title_name = name + ": stretch horizontal and vertical, 0.5";
title(t, title_name)

% nexttile([1 2]);
nexttile;
plot_cut_list(cut_list)
hold on
plot([0,0,1,1],[0,1,1,0],'k-')
if nargin > 3
    plot(drawBox(:,1),drawBox(:,2),'k-')
end
hold off
title("cut list")
axis tight
axis equal

nexttile;
if nargin > 4
    whatNormes = "normes over entire domain";
    L2val = sprintf("L2: %f", calculate_Lp_norm_von_mises_stress(result, 2));
    L4val = sprintf("L4: %f", calculate_Lp_norm_von_mises_stress(result, 4));
    L6val = sprintf("L6: %f", calculate_Lp_norm_von_mises_stress(result, 6));
    maxval = sprintf("max: %f", calculate_Lp_norm_von_mises_stress(result, "infty"));
    whatNormessub = "normes over subdomain (" + min(subdomain(:,1)) + "," + max(subdomain(:,1)) + ")^2";
    L2valsub = sprintf("L2: %f", calculate_Lp_norm_von_mises_stress(result, 2, [min(subdomain(:,1)),max(subdomain(:,1))],[min(subdomain(:,2)),max(subdomain(:,2))]));
    L4valsub = sprintf("L4: %f", calculate_Lp_norm_von_mises_stress(result, 4, [min(subdomain(:,1)),max(subdomain(:,1))],[min(subdomain(:,2)),max(subdomain(:,2))]));
    L6valsub = sprintf("L6: %f", calculate_Lp_norm_von_mises_stress(result, 6, [min(subdomain(:,1)),max(subdomain(:,1))],[min(subdomain(:,2)),max(subdomain(:,2))]));
    maxvalsub = sprintf("max: %f", calculate_Lp_norm_von_mises_stress(result, "infty", [min(subdomain(:,1)),max(subdomain(:,1))],[min(subdomain(:,2)),max(subdomain(:,2))]));
    text(0,1/2,sprintf('%s\n%s\n%s\n%s\n%s\n\n%s\n%s\n%s\n%s\n%s',whatNormes,L2val,L4val,L6val,maxval,whatNormessub,L2valsub,L4valsub,L6valsub,maxvalsub))
else
    whatNormes = "normes over entire domain";
    L2val = sprintf("L2: %f", calculate_Lp_norm_von_mises_stress(result, 2));
    L4val = sprintf("L4: %f", calculate_Lp_norm_von_mises_stress(result, 4));
    L6val = sprintf("L6: %f", calculate_Lp_norm_von_mises_stress(result, 6));
    maxval = sprintf("max: %f", calculate_Lp_norm_von_mises_stress(result, "infty"));
    text(0,1/2,sprintf('%s\n%s\n%s\n%s\n%s',whatNormes,L2val,L4val,L6val,maxval))
end
ax = gca;
ax.Visible = 0;

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

exportgraphics(fig, ffilename, 'ContentType', 'image', 'BackgroundColor', 'white', 'Append', true);
close(fig);

% This next part is to add stretching only in vertical direction to the dossier

% horizontal_and_vertical = false;
% displacement = 0.5;
% [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
% displacement = 0.25;
% [~, result2] = compute_skin(cut_list, displacement, horizontal_and_vertical);
% 
% fig = figure('Visible','Off');
% t = tiledlayout(3,2);
% title_name = name + ": stretch only vertical";
% title(t, title_name)
% 
% nexttile;
% plot_solution_on_skin(result);
% title("displacement = 0.5")
% 
% nexttile;
% plot_solution_on_skin(result2);
% title("displacement = 0.25")
% 
% nexttile;
% plot_von_mises_stress(result);
% title("von Mises stress")
% 
% nexttile;
% plot_von_mises_stress(result,true);
% title("von Mises stress in log scale")
% 
% set(fig, 'Units', 'centimeters','OuterPosition', [0 0 A4_width_cm A4_height_cm])
% 
% exportgraphics(fig, ffilename, 'ContentType', 'image', 'BackgroundColor', 'white', 'Append', true);
% close(fig);

end