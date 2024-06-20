function generate_dossier_von_mises_pdf()
% SUMMARY:
%       This function generates the dossier of the von Mises stress plots
%       of all the different patterns.
%       Only works if the jpg-files of the von Mises stress for all
%       patterns are already generated.
%       It is saved/appended in the pdf-file called "dossier_von_mises" or
%       "dossier_nodes_highest_von_mises".

problem_name = ["lines", "shifted_lines", "grid", "s", "hexagon", "octagon", ...
    "hilbert_curve", "sierpinski_curve", "peano_curve", "gosper_curve"];

close

fig = figure('Visible','Off');

% dossier_von_mises
% for i = 1:10
%     ffilename = sprintf('imagesVM/%s_corners_free_vonMisesStress.jpg',problem_name(i));
%     im = imread(ffilename);
%     imshow(im);
%     exportgraphics(gcf, "dossier_von_mises.pdf", 'BackgroundColor', 'none', 'Append', true);
% end

% dossier_von_mises_log_scale
for i = 1:10
    ffilename = sprintf('imagesVM/%s_log_vonMisesStress.jpg',problem_name(i));
    im = imread(ffilename);
    imshow(im);
    exportgraphics(gcf, "dossier_von_mises_log.pdf", 'BackgroundColor', 'none', 'Append', true);
end

% dossier_nodes_highest_von_mises
% for i = 1:10
%     ffilename = sprintf('imagesVM/%s_nodesHigestVonMisesStress.jpg',problem_name(i));
%     im = imread(ffilename);
%     imshow(im);
%     exportgraphics(gcf, "dossier_nodes_highest_von_mises.pdf", 'BackgroundColor', 'none', 'Append', true);
% end

close(fig);

end