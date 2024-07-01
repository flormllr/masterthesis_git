function cut_list = generate_squares_with_cuts_degrees(n, vec_degree, shorten_cut)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in n*n squares.
%       In each square we set a cut depending on the given orientation for
%       each square. The orientation is given in degrees from 1 to 180. If
%       there is a 0, we don't set a cut in this square.
% INPUT:
%       n: number of little square the domain is divided into per row, >0,
%           in total there are thus n*n squares
%       vec_degree: vector of size n*n. each entry is a number from 0 to
%           180 and tells us by how many degrees we have to rotate the
%           horizontal cut.
%       shorten_cut: value in percentage that we shorten the length of
%           each cut by, 0 < shorten_cut < 1
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

% start with square in bottom left. then move to the right. if row is
% complete, move one row up, until reach top right square.

cut_list = zeros(nnz(vec_degree),4);
square_length = 1/n;

cut_counter = 1;
for i = 1:n
    for j = 1:n
        square_counter = (i-1)*n+j;
        if vec_degree(square_counter) == 0 % no cut here
        else
            % find x- and y-coordinates of the little square
            square_x = [(j-1)*square_length, j*square_length];
            square_y = [(i-1)*square_length, i*square_length];

            x_horiz = square_x;
            y_horiz = [(square_y(1)+square_y(2))/2, (square_y(1)+square_y(2))/2];
            x_cen = (square_x(1)+square_x(2))/2;
            y_cen = (square_y(1)+square_y(2))/2;

            x_rot = (x_horiz-x_cen)*cosd(vec_degree(square_counter)) + (y_horiz-y_cen)*sind(vec_degree(square_counter)) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(vec_degree(square_counter)) + (y_horiz-y_cen)*cosd(vec_degree(square_counter)) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
        end
    end
end

if 0 < shorten_cut && shorten_cut < 1
    cut_list = change_length_of_cuts(cut_list,1:nnz(vec_degree),-shorten_cut);
end

end