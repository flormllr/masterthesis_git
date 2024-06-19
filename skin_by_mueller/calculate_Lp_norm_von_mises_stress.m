function VMstress_norm = calculate_Lp_norm_von_mises_stress(result, p, xRange, yRange)
% SUMMARY:
%       This function calculates the Lp-norm of the von Mises stress for
%       the result of a PDE. If xRange and yRange aren't specified, it is
%       computed over the entire domain. Else we only compute it in the box
%       given by (xRange x yRange).
%       Note: Only the elements that are entirely within the box are taken
%       into consideration.
% INPUT:
%       result: solution to our PDE represented in model
%       p: integer, tells us which Lp-norm to use
%       xRange: two-element row array, tells us the x-coordinates of the
%           box where we want to compute the von Mises stress
%       yRange: two-element row array, tells us the y-coordinates of the
%           box where we want to compute the von Mises stress
% OUTPUT:
%       VMstress: the Lp-norm of the von Mises stress

if nargin < 4
    amountOfElements = size(result.Mesh.Elements,2);
    idxs_elements = 1:amountOfElements;
else
    idxs_elements = findElements(result.Mesh, "box", xRange, yRange);
    amountOfElements = size(idxs_elements,2);
end

% amountOfElements = size(result.Mesh.Elements,2);

VMstress_norm = 0;
for i = 1:amountOfElements
    % indices of nodes of triangle element
    triangle_indices = result.Mesh.Elements(:,idxs_elements(i));
    % triangle_indices = result.Mesh.Elements(:,i);
    % coordinates of nodes of triangle element
    a = result.Mesh.Nodes(:,triangle_indices(1));
    b = result.Mesh.Nodes(:,triangle_indices(2));
    c = result.Mesh.Nodes(:,triangle_indices(3));

    % von Mises stress in MPa
    VMstress_triangle = result.VonMisesStress(triangle_indices) / 1000000;
    triangle_area = 1/2 * abs(a(1)*(b(2)-c(2)) + b(1)*(c(2)-a(2)) + c(1)*(a(2)-b(2)));
    % integral_result = triangle_area * 1/6 * (sum(VMstress_triangle(1:3).^p) + 4*sum(VMstress_triangle(4:6).^p));
    integral_result = triangle_area * 1/3 * sum(VMstress_triangle(4:6).^p);
    % VMstress_norm = VMstress_norm + nthroot(integral_result,p);
    VMstress_norm = VMstress_norm + integral_result;

    % 2nd variant, takes a lot longer
    % VM_fct = @(x,y) (interpolateVonMisesStress(result,x,y)/1000000) .^p;
    % VMstress_norm = VMstress_norm + integrate_over_triangle(VM_fct,a,b,c);

    % DOESN'T WORK
    % ab = result.Mesh.Nodes(:,triangle_indices(4));
    % bc = result.Mesh.Nodes(:,triangle_indices(5));
    % ac = result.Mesh.Nodes(:,triangle_indices(6));
    % triangleX = [a(1); b(1); c(1); ab(1); bc(1); ac(1)];
    % triangleY = [a(2); b(2); c(2); ab(2); bc(2); ac(2)];
    % VMstress_triangle = result.VonMisesStress(triangle_indices);
    % VM_fct = @(x,y) interp2(triangleX, triangleY, VMstress_triangle, x, y);
    % VM_fct_triangle = @(x,y) (inpolygon(x,y,[a(1); b(1); c(1)],[a(2); b(2); c(2)]) * VM_fct(x,y))^p;
    % VMstress_norm = VMstress_norm + nthroote(integral2(VM_fct_triangle, min(triangleX), max(triangleX), min(triangleY), max(triangleY), 'Method', 'iterated'), p);
end
VMstress_norm = nthroot(VMstress_norm,p);

end


% function integral_result = integrate_over_triangle(f, a, b, c)
% % SUMMARY:
% %       This function calculates the integral of the function f over the
% %       triangle given by the points [a,b,c]. The triangle is transformed
% %       to the unit triangle given by the points [(0,0),(0,1),(1,0)]. We
% %       then integrate over this unit triangle.
% % INPUT:
% %       f: function to integrate over triangle
% %       a: first point of triangle
% %       b: second point of triangle
% %       c: third point of triangle
% % OUTPUT:
% %       integral_result: result of the integration
% 
% % Jacobian determinant
% jd = abs((b(1)-a(1))*(c(2)-a(2)) - (c(1)-a(1))*(b(2)-a(2)));
% % f over unit triangle (0,0),(0,1),(1,0)
% f_tilda = @(u,v) f(a(1) + u.*(b(1)-a(1)) + v.*(c(1)-a(1)), a(2) + u.*(b(2)-a(2)) + v.*(c(2)-a(2)));
% f_tilda_vec = @(x, y) arrayfun(f_tilda, x, y);
% 
% fy = @(x) 1-x;
% integral_result = jd * integral2(f_tilda_vec, 0, 1, 0, fy);
% 
% end