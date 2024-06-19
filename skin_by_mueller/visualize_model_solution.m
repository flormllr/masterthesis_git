function output_image = visualize_model_solution(model, result)
% SUMMARY:
%       This function visualizes the solution of our model on the skin,
%       i.e. shows the cutted and stretched skin. The plot is returned in a
%       data format.
% INPUT:
%       model: model of our problem
%       result: result/solution of our model
% OUTPUT:
%       output_image: the output image in a data format


% converts the mesh to [p,e,t] form
[p, e, t] = meshToPet(model.Mesh);
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
title('skin','fontsize',40);
colormap(gray);
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f1 = getframe(gcf);

pdeplot(p,e,t,'XYData',sk{2})
title('skin','fontsize',40);
colormap(gray);
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f2 = getframe(gcf);

pdeplot(p,e,t,'XYData',sk{3})
title('skin','fontsize',40);
colormap(gray);
clim([0 1]);
colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
f3 = getframe(gcf);

output_image(:,:,1) = f1.cdata(:,:,1);
output_image(:,:,2) = f2.cdata(:,:,1);
output_image(:,:,3) = f3.cdata(:,:,1);


mymap = colorGradient([0.94 0.94 0.94],[1 0 0], 128);

pdeplot(p,e,t,'XYData',abs(result.Strain.exx));
title('strain in horizontal direction','fontsize',40);
clim([0 1]);
colormap(mymap);
%colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
strainXX = getframe(gcf);

pdeplot(p,e,t,'XYData',abs(result.Strain.eyy));
title('strain in vertical direction','fontsize',40);
colormap(mymap);
%colormap(gray);
clim([0 1]);
%colorbar('off');
axis([-0.25 1.25 -0.25 1.25]);
strainYY = getframe(gcf);

close(fig)

new_cdata(:,:,1) = [output_image(:,:,1) strainXX.cdata(:,:,1) strainYY.cdata(:,:,1)];
new_cdata(:,:,2) = [output_image(:,:,2) strainXX.cdata(:,:,2) strainYY.cdata(:,:,2)];
new_cdata(:,:,3) = [output_image(:,:,3) strainXX.cdata(:,:,3) strainYY.cdata(:,:,3)];

output_image = new_cdata;

fig = figure('doublebuffer','on','Visible','on');

close(fig)

end