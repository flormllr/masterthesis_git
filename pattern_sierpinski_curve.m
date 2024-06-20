function Z = pattern_sierpinski_curve(n)
% SUMMARY:
%       This function generates the coordinates for the Sierpinski curve of
%       order n.
%           Example: Z = pattern_sierpinski_curve(n) is a closed curve in
%               the complex plane with 4^(n+1)+1 points
%           plot with: plot(pattern_sierpinski_curve(4)), axis equal
% INPUT:
%       n: order of the Sierpinski curve (nonnegative integer)
% OUTPUT:
%       Z: closed curve in the complex plane (coordinates of the curve)
%   Author: Jonas Lundgren <splinefit@gmail.com> 2010

% constants
a = 1 + 1i;
b = 1 - 1i;
c = 2 - sqrt(2);

% generate point sequence
Z = c;
for k = 1:n
    w = 1i*Z;
    Z = [Z+b; w+b; a-w; Z+a]/2;
end

% close cross
Z = [Z; 1i*Z; -Z; -1i*Z; Z(1)];

end