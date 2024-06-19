function [cut_list] = pattern_octagon(b)
% SUMMARY:
%       This function generates the cut_list for one octagon.
% INPUT:
%       b: factor, that tells us how big the octagon should be (cut length)
% OUTPUT:
%       cut_list: matrix with all the cuts for one octagon. one cut is
%           saved per row.

cut_list = [0, b/sqrt(2), b/sqrt(2), 0;
    b/sqrt(2), 0, +b/sqrt(2)+b, 0;
    b/sqrt(2)+b, 0, 2*b/sqrt(2)+b, b/sqrt(2);
    2*b/sqrt(2)+b, b/sqrt(2), 2*b/sqrt(2)+b, b/sqrt(2)+b;
    2*b/sqrt(2)+b, b/sqrt(2)+b, b/sqrt(2)+b, 2*b/sqrt(2)+b;
    b/sqrt(2)+b, 2*b/sqrt(2)+b, b/sqrt(2), 2*b/sqrt(2)+b;
    b/sqrt(2), 2*b/sqrt(2)+b, 0, 1*b/sqrt(2)+b;
    0, 1*b/sqrt(2)+b, 0, 1*b/sqrt(2)];

%h=0.02 % spacing
% cut_list = [h, h+b/sqrt(2), h+b/sqrt(2), h;
%             2*h+b/sqrt(2), 0, 2*h+b/sqrt(2)+b, 0;
%             3*h+b/sqrt(2)+b, h, 3*h+2*b/sqrt(2)+b, h+b/sqrt(2);
%             4*h+2*b/sqrt(2)+b, 2*h+b/sqrt(2), 4*h+2*b/sqrt(2)+b, 2*h+b/sqrt(2)+b;
%             3*h+2*b/sqrt(2)+b, 3*h+b/sqrt(2)+b, 3*h+b/sqrt(2)+b, 3*h+2*b/sqrt(2)+b;
%             2*h+b/sqrt(2)+b, 4*h+2*b/sqrt(2)+b, 2*h+b/sqrt(2), 4*h+2*b/sqrt(2)+b;
%             h+b/sqrt(2), 3*h+2*b/sqrt(2)+b, h, 3*h+1*b/sqrt(2)+b;
%             0, 2*h+1*b/sqrt(2)+b, 0, 2*h+1*b/sqrt(2)
%             ];

end

            