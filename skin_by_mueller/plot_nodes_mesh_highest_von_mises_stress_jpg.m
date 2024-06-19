function plot_nodes_mesh_highest_von_mises_stress_jpg(result, k, name, filename)
% SUMMARY:
%       This function plots the mesh of the result of a PDE and highlights
%       the k nodes where there is the highest von Mises stress and saves
%       it as a jpg-file in the "imagesVM" folder.
% INPUT:
%       result: solution to a PDE
%       k: integer, how many nodes we want to highlight
%       name: name of our problem/pattern
%       filename: name that the file should have

close
figureVM = figure('Visible','Off');

% to find where the nodes with the biggest von Mises stress are
[~, b] = maxk(result.VonMisesStress, k);
pdeplot(result.Mesh)
hold on
plot(result.Mesh.Nodes(1,b), result.Mesh.Nodes(2,b), 'or', 'MarkerFaceColor', 'g')
hold off

title(k + " nodes with highest von Mises stress: " + name);

ffilename = sprintf('imagesVM/%s_nodesHigestVonMisesStress.jpg',filename);

saveas(figureVM, ffilename);
close(figureVM)

end