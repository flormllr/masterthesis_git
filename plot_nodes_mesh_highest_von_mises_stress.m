function plot_nodes_mesh_highest_von_mises_stress(result, k)
% SUMMARY:
%       This function plots the mesh of the result of a PDE and highlights
%       the k nodes where there is the highest von Mises stress.
% INPUT:
%       result: solution to a PDE
%       k: integer, how many nodes we want to highlight

% to find where the nodes with the biggest von Mises stress are
[~, b] = maxk(result.VonMisesStress, k);
pdeplot(result.Mesh)
hold on
plot(result.Mesh.Nodes(1,b), result.Mesh.Nodes(2,b), 'or', 'MarkerFaceColor', 'g')
hold off

end