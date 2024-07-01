function cut_list = generate_hexagons_with_cuts(n_x, vec_degree, shorten_cut)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in hexagons. n gives
%       the number of hexagons in the bottom row.
%       In each hexagon we set a cut depending on the given orientation for
%       each square. The orientation is given in degrees from 1 to 180. If
%       there is a 0, we don't set a cut in this square.
% INPUT:
%       n_x: number of hexagons the domain is divided into in the first
%           row, >0
%       vec_degree: vector of size n*n. each entry is a number from 0 to
%           180 and tells us by how many degrees we have to rotate the
%           horizontal cut.
%       shorten_cut: value in percentage that we shorten the length of
%           each cut by, 0 < shorten_cut < 1
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

cut_list = zeros(nnz(vec_degree),4);

% hexagon
theta = 0:60:360;
x = cosd(theta);
y = sind(theta);
x = (x - min(x)) / 2;
y = (y - min(y)) / 2;
x_space = n_x*(max(x) - min(x)) + (n_x-1)*(x(2)-x(3));
x = x / x_space;
y = y / x_space;
y_add_to_second_row = y(1);
n_y = floor(1/max(y));
y = y + (1 - floor(1/max(y))*max(y)) / 2;

% figure
% hold on

cut_counter = 1;
for i = 1:n_y
    for j = 1:n_x
        if vec_degree(cut_counter) == 0 % no cut here
            cut_counter = cut_counter + 1;
        else
            hex_x = x + (j-1)*((max(x)-min(x)) + (x(2)-x(3)));
            hex_y = y + (i-1)*(max(y)-min(y));

            % plot(hex_x,hex_y)

            x_horiz = [hex_x(4), hex_x(1)];
            y_horiz = [hex_y(4), hex_y(1)];
            x_cen = (x_horiz(1)+x_horiz(2))/2;
            y_cen = y_horiz(1);

            x_rot = (x_horiz-x_cen)*cosd(vec_degree(cut_counter)) + (y_horiz-y_cen)*sind(vec_degree(cut_counter)) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(vec_degree(cut_counter)) + (y_horiz-y_cen)*cosd(vec_degree(cut_counter)) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
        end
    end
end

x = x + (x(2)-x(4));
y = y + y_add_to_second_row;
for i = 1:n_y-1
    for j = 1:n_x-1
        if vec_degree(cut_counter) == 0 % no cut here
            cut_counter = cut_counter + 1;
        else
            hex_x = x + (j-1)*((max(x)-min(x)) + (x(2)-x(3)));
            hex_y = y + (i-1)*(max(y)-min(y));

            % plot(hex_x,hex_y)

            x_horiz = [hex_x(4), hex_x(1)];
            y_horiz = [hex_y(4), hex_y(1)];
            x_cen = (x_horiz(1)+x_horiz(2))/2;
            y_cen = y_horiz(1);

            x_rot = (x_horiz-x_cen)*cosd(vec_degree(cut_counter)) + (y_horiz-y_cen)*sind(vec_degree(cut_counter)) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(vec_degree(cut_counter)) + (y_horiz-y_cen)*cosd(vec_degree(cut_counter)) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
        end
    end
end

if 0 < shorten_cut && shorten_cut < 1
    cut_list = change_length_of_cuts(cut_list,1:nnz(vec_degree),-shorten_cut);
end

% hold off

cut_list(cut_counter:end, :) = [];

end