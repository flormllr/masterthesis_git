function [x, y] = pattern_hilbert_curve(n)
% SUMMARY:
%       This function generates the vector coordinates of points in n-th
%       order Hilbert curve of area 1.
%           Example: plot the 5-th order curve:
%               [x,y] = generate_hilbert_curve(5);
%               line(x,y)
% INPUT:
%       n: order of the Hilbert curve
% OUTPUT:
%       x: x-coordinates of points for the Hilbert curve
%       y: y-coordinates of points for the Hilbert curve
%   Copyright (c) by Federico Forte
%   Date: 2000/10/06 

if n <= 0
  x = 0;
  y = 0;
else
  [xo, yo] = pattern_hilbert_curve(n-1);
  x = 0.5*[-0.5+yo, -0.5+xo, 0.5+xo, 0.5-yo];
  y = 0.5*[-0.5+xo, 0.5+yo, 0.5+yo, -0.5-xo];
end
