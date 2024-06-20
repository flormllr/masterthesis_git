function plot_solution_on_skin(result)
% SUMMARY:
%       This function visualizes the solution of our model on the skin,
%       i.e. shows the cutted and stretched skin. It is directly plotted
%       and the first subplot of visualize_model_solution.
% INPUT:
%       result: result/solution of our model



% converts the mesh to [p,e,t] form
[p, e, t] = meshToPet(result.Mesh);
% pdeplot(p,e,t); % to check if conversion was succesful

I = imread('texture.jpg'); % loads the file of the skin texture
II = im2double(I); % converts the image to double precision
[XX,YY] = ndgrid(0:1/1599:1, 0:1/1599:1); % creates a 2D grid (matrix)
sk = cell(3,1); %creates a cell array
for i=1:3
    F = griddedInterpolant(XX,YY,II(:,:,i)');
    sk{i} = F(p');
end

p = p + [result.Displacement.ux, result.Displacement.uy]'; % deformation

fig=figure('doublebuffer','off','Visible','Off','Position', [0 0 900 900],'DefaultAxesFontSize',18);

pdeplot(p,e,t,'XYData',sk{1})
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f1 = getframe(gcf);

pdeplot(p,e,t,'XYData',sk{2})
colormap(gray);
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f2 = getframe(gcf);

pdeplot(p,e,t,'XYData',sk{3})
colormap(gray);
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f3 = getframe(gcf);

output_image(:,:,1) = f1.cdata(:,:,1);
output_image(:,:,2) = f2.cdata(:,:,1);
output_image(:,:,3) = f3.cdata(:,:,1);

close(fig)

imshow(output_image)

end