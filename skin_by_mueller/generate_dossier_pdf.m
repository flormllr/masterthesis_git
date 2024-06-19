function generate_dossier_pdf(problem_name)
% SUMMARY:
%       This function generates the dossier for the given problem, i.e.
%       shows us the pattern of the cuts and strains in vertical only and
%       in vertical & horizontal direction. Only works if the jpg-files of
%       the pattern and the strains are already generated.
%       It is saved/appended in the pdf-file called "dossier".
% INPUT:
%       problem_name: name of our problem/pattern

close

fig = figure('Visible','Off');

subplot(3,1,1);
ffilename = sprintf('images/%s_shape.jpg',problem_name);
im = imread(ffilename);
imshow(im);

subplot(3,1,2);
ffilename = sprintf('images/%s_2_0.50_0.jpg',problem_name);
im = imread(ffilename);
imshow(im);

subplot(3,1,3);
ffilename = sprintf('images/%s_5_0.50_1.jpg',problem_name);
im = imread(ffilename);
imshow(im);

exportgraphics(gcf, "dossier.pdf", 'BackgroundColor', 'none', 'Append', true);

close(fig);

end