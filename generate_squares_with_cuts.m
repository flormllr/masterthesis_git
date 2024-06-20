function cut_list = generate_squares_with_cuts(n, vec_orientation, shorten_cut)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in n*n squares.
%       In each square we set a cut (horizontal, vertical, diagonal; left
%       to right or right to left) depending on the given orientation for
%       each square.
% INPUT:
%       n: number of little square the domain is divided into per row, >0,
%           in total there are thus n*n squares
%       vec_orientation: vector of size n*n. each entry is either 0 (no
%           cut), 1 (horizontal cut), 2 (vertical cut), 3 (diagonal cut,
%           bottom right to top left), 4 (diagonal cut, bottom left to top
%           right). tells us how the cut in each square should look like.
%       shorten_cut: value in percentage that we shorten the length of
%           each cut by, 0 < shorten_cut < 1
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

% start with square in bottom left. then move to the right. if row is
% complete, move one row up, until reach top right square.

cut_list = zeros(nnz(vec_orientation),4);
square_length = 1/n;

cut_counter = 1;
for i = 1:n
    for j = 1:n
        square_counter = (i-1)*n+j;
        % find x- and y-coordinates of the little square
        square_x = [(j-1)*square_length, j*square_length];
        square_y = [(i-1)*square_length, i*square_length];

        x_horiz = square_x;
        y_horiz = [(square_y(1)+square_y(2))/2, (square_y(1)+square_y(2))/2];
        x_cen = (square_x(1)+square_x(2))/2;
        y_cen = (square_y(1)+square_y(2))/2;
        if vec_orientation(square_counter) == 1 % horizontal cut
            cut_list(cut_counter, :) = [square_x(1), (square_y(1)+square_y(2))/2, square_x(2), (square_y(1)+square_y(2))/2];
            cut_counter = cut_counter + 1;
        elseif vec_orientation(square_counter) == 2 % vertical cut
            cut_list(cut_counter, :) = [(square_x(1)+square_x(2))/2, square_y(1), (square_x(1)+square_x(2))/2, square_y(2)];
            cut_counter = cut_counter + 1;
        elseif vec_orientation(square_counter) == 3 % diagonal cut, bottom left to top right
            % cut_list(cut_counter, :) = [square_x(1), square_y(1), square_x(2), square_y(2)];
            x_rot = (x_horiz-x_cen)*cosd(45) + (y_horiz-y_cen)*sind(45) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(45) + (y_horiz-y_cen)*cosd(45) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
        elseif vec_orientation(square_counter) == 4 % diagonal cut, bottom right to top left
            % cut_list(cut_counter, :) = [square_x(2), square_y(1), square_x(1), square_y(2)];
            x_rot = (x_horiz-x_cen)*cosd(135) + (y_horiz-y_cen)*sind(135) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(135) + (y_horiz-y_cen)*cosd(135) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
        else % vec_orientation(square_counter) == 0, no cut in this square
        end
    end
end

if 0 < shorten_cut && shorten_cut < 1
    cut_list = change_length_of_cuts(cut_list,1:nnz(vec_orientation),-shorten_cut);
end

end