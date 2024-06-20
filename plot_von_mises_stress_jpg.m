function plot_von_mises_stress_jpg(result, name, filename, log_scale)
% SUMMARY:
%       This function plots the mesh of the result of a PDE, its  von Mises
%       stress and its deformation and saves it as a jpg-file in the
%       "imagesVM" folder.
% INPUT:
%       result: solution to a PDE
%       name: name of our problem/pattern
%       filename: name that the file should have
%       log_scale: boolean, tells us if we want to plot in logarithmic 
%           scale. Default value is false.

if nargin<4
    log_scale = false;
end

if log_scale
    close
    figureVM = figure('Visible','Off');
    pdeplot(result.Mesh, XYData = result.VonMisesStress/1000000, Deformation = result.Displacement, DeformationScaleFactor = 1, ColorMap = 'jet')
    set(gca,'ColorScale','log')

    title(name);

    ffilename = sprintf('imagesVM/%s_vonMisesStress.jpg',filename);
    saveas(figureVM, ffilename);
    close(figureVM)
else
    close
    figureVM = figure('Visible','Off');
    pdeviz(result.Mesh, 'NodalData', result.VonMisesStress/1000000, 'DeformationData', result.Displacement, 'DeformationScaleFactor', 1, 'MeshVisible','off');

    % pdeplot(result.Mesh, XYData = result.VonMisesStress, Deformation = result.Displacement, DeformationScaleFactor = 1, ColorMap = 'jet')

    % [p, e, t] = meshToPet(result.Mesh);
    % % pdeplot(p,e,t);
    % p = p + [result.Displacement.ux, result.Displacement.uy]'; % deformation
    % pdeplot(p, e, t, XYData=result.VonMisesStress, ColorMap='jet');

    title(name);

    ffilename = sprintf('imagesVM/%s_vonMisesStress.jpg',filename);
    saveas(figureVM, ffilename);
    close(figureVM)
end

end