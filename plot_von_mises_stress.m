function plot_von_mises_stress(result, log_scale)
% SUMMARY:
%       This function plots the mesh of the result of a PDE, its von Mises
%       stress in MPa and its deformation.
% INPUT:
%       result: solution to a PDE
%       log_scale: boolean, tells us if we want to plot in logarithmic 
%           scale. Default value is false.

if nargin<2
    log_scale = false;
end

if log_scale
    logVonMisesStress = log10(result.VonMisesStress/1000000);
    pdeviz(result.Mesh, 'NodalData', logVonMisesStress, 'DeformationData', result.Displacement, 'DeformationScaleFactor', 1, 'MeshVisible','off');
    % pdeplot(result.Mesh, XYData = result.VonMisesStress/1000000, Deformation = result.Displacement, DeformationScaleFactor = 1, ColorMap = 'jet')
    % set(gca,'ColorScale','log')
else
    pdeviz(result.Mesh, 'NodalData', result.VonMisesStress/1000000, 'DeformationData', result.Displacement, 'DeformationScaleFactor', 1, 'MeshVisible','off');
    % pdeplot(result.Mesh, XYData = result.VonMisesStress/1000000, Deformation = result.Displacement, DeformationScaleFactor = 1, ColorMap = 'jet')
end

% pdeviz(result.Mesh, 'NodalData', result.VonMisesStress/1000000, 'DeformationData', result.Displacement, 'DeformationScaleFactor', 1, 'MeshVisible','off');

% pdeplot(result.Mesh, XYData = result.VonMisesStress/1000000, Deformation = result.Displacement, DeformationScaleFactor = 1, ColorMap = 'jet')

% [p, e, t] = meshToPet(result.Mesh);
% % pdeplot(p,e,t);
% p = p + [result.Displacement.ux, result.Displacement.uy]'; % deformation
% pdeplot(p, e, t, XYData=result.VonMisesStress, ColorMap='jet');

end