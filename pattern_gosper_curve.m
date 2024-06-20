function Z = pattern_gosper_curve(n)
% SUMMARY:
%       This function generates the coordinates for the Gosper curve 
%       (flowsnake) of order n.
%           Example: Z = pattern_gosper_curve(n) is a continuous curve in
%               the complex plane with 7^n+1 points.
%           plot with: plot(pattern_gosper_curve(4)), axis equal
% INPUT:
%       n: order of the Gosper curve (nonnegative integer)
% OUTPUT:
%       Z: closed curve in the complex plane (coordinates of the curve)
%   Author: Jonas Lundgren <splinefit@gmail.com> 2010

% constants
a = (1 + sqrt(-3))/2;
b = (1 - sqrt(-3))/2;
c = [1; a; -b; -1; -a; b];

% segment angles (divided by pi/3)
u = 0;
for k = 1:n
    v = u(end:-1:1);
    u = [u; v+1; v+3; u+2; u; u; v-1]; %#ok
end
u = mod(u,6);

% points
Z = cumsum(c(u+1));
Z = [0; Z/7^(n/2)];

end