function compliance = calculate_compliance(result, xRange, yRange)
% SUMMARY:
%       This function calculates the compliance for the result of a PDE. If
%       xRange and yRange aren't specified, it is computed over the entire
%       domain. Else we only compute it in the box given by
%       (xRange x yRange).
%       Note: Only the elements that are entirely within the box are taken
%       into consideration.
% INPUT:
%       result: solution to our PDE represented in model
%       xRange: two-element row array, tells us the x-coordinates of the
%           box where we want to compute the von Mises stress
%       yRange: two-element row array, tells us the y-coordinates of the
%           box where we want to compute the von Mises stress
% OUTPUT:
%       compliance: the compliance of the model

if nargin < 3
    amountOfElements = size(result.Mesh.Elements,2);
    idxs_elements = 1:amountOfElements;
else
    idxs_elements = findElements(result.Mesh, "box", xRange, yRange);
    amountOfElements = size(idxs_elements,2);
    % figure
    % pdemesh(result.Mesh)
    % hold on
    % pdemesh(result.Mesh.Nodes,result.Mesh.Elements(:,idxs_elements),EdgeColor="green")
    % plot([xRange(1),xRange(1),xRange(2),xRange(2),xRange(1)],[yRange(1),yRange(2),yRange(2),yRange(1),xRange(1)],'k-')
    % hold off
end

compliance = 0;
for i = 1:amountOfElements
    % indices of nodes of triangle element
    triangle_indices = result.Mesh.Elements(:,idxs_elements(i));
    % coordinates of nodes of triangle element
    a = result.Mesh.Nodes(:,triangle_indices(1));
    b = result.Mesh.Nodes(:,triangle_indices(2));
    c = result.Mesh.Nodes(:,triangle_indices(3));

    % values in Pa
    % exx_triangle = result.Strain.exx(triangle_indices);
    % exy_triangle = result.Strain.exy(triangle_indices);
    % eyy_triangle = result.Strain.eyy(triangle_indices);
    % sxx_triangle = result.Stress.sxx(triangle_indices);
    % sxy_triangle = result.Stress.sxy(triangle_indices);
    % syy_triangle = result.Stress.syy(triangle_indices);
    % values in MPa
    exx_triangle = result.Strain.exx(triangle_indices);
    exy_triangle = result.Strain.exy(triangle_indices);
    eyy_triangle = result.Strain.eyy(triangle_indices);
    sxx_triangle = result.Stress.sxx(triangle_indices) / 1000000;
    sxy_triangle = result.Stress.sxy(triangle_indices) / 1000000;
    syy_triangle = result.Stress.syy(triangle_indices) / 1000000;
    integral_sum = sxx_triangle.*exx_triangle + 2*sxy_triangle.*exy_triangle + syy_triangle.*eyy_triangle;
    triangle_area = 1/2 * abs(a(1)*(b(2)-c(2)) + b(1)*(c(2)-a(2)) + c(1)*(a(2)-b(2)));
    % integral_result = triangle_area * 1/6 * (sum(integral_sum(1:3).^p) + 4*sum(integral_sum(4:6).^p));
    integral_result = triangle_area * 1/3 * sum(integral_sum(4:6));
    compliance = compliance + integral_result;
end

end