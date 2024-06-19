function cut_list = generate_squares_with_cuts_different_lengths(n, vec_degree, xRange, yRange, shorten_cut)
% SUMMARY:
%       This function divides the domain (0,1)x(0,1) in little squares.
%       In each square we set a cut depending on the given orientation for
%       each square. The orientation is given in degrees from 0 to 179.
%       The input-variables may have multiple rows. Each row divides the
%       domain given in xRange x yRange in n*n little squares and sets the
%       cut according to the degree given in vec_degree.
%       By dividing the domain in multiple subdomains, it is possible to
%       get different lengths of the cuts in each subdomain.
% INPUT:
%       n: matrix. Each row contains two elements and tells us the number
%           of little square the domain is divided into per row. The first
%           entry are the amount of little square in horizontal direction,
%           the second entry are the amount of little squares in vertical
%           direction.
%       vec_degree: matrix. Each row contains the degrees for a subdomain.
%           Each entry is a number from 0 to 179 and tells us by how many
%           degrees we have to rotate the horizontal cut.
%       xRange: matrix. Each row contains two elements and tells us the
%           x-coordinates of the box where we want to divide into n*n
%           little squares.
%       yRange: matrix. Each row contains two elements and tells us the
%           y-coordinates of the box where we want to divide into n*n
%           little squares.
%       shorten_cut: value in percentage that we shorten the length of
%           each cut by, 0 < shorten_cut < 1
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

subdomains = size(n,1);
amountOfCuts = sum(n(:,1).*n(:,2));
cut_list = zeros(amountOfCuts,4);

cut_counter = 1;
for k = 1:subdomains
    squares_x_length = (xRange(k,2)-xRange(k,1))/n(k,1);
    squares_y_length = (yRange(k,2)-yRange(k,1))/n(k,2);
    square_counter = 1;
    for i = 1:n(k,2)
        for j = 1:n(k,1)
            % find x- and y-coordinates of the little square
            % square_x = [(j-1)*squares_x_length + 1/10*squares_x_length, j*squares_x_length - 1/10*squares_x_length] + xRange(k,1);
            % square_y = [(i-1)*squares_y_length + 1/10*squares_y_length, i*squares_y_length - 1/10*squares_y_length] + yRange(k,1);
            square_x = [(j-1)*squares_x_length, j*squares_x_length] + xRange(k,1);
            square_y = [(i-1)*squares_y_length, i*squares_y_length] + yRange(k,1);
            x_horiz = square_x;
            y_horiz = [(square_y(1)+square_y(2))/2, (square_y(1)+square_y(2))/2];
            x_cen = (square_x(1)+square_x(2))/2;
            y_cen = (square_y(1)+square_y(2))/2;

            x_rot = (x_horiz-x_cen)*cosd(vec_degree(k,square_counter)) + (y_horiz-y_cen)*sind(vec_degree(k,square_counter)) + x_cen;
            y_rot = -(x_horiz-x_cen)*sind(vec_degree(k,square_counter)) + (y_horiz-y_cen)*cosd(vec_degree(k,square_counter)) + y_cen;
            cut_list(cut_counter, :) = [x_rot(1), y_rot(1), x_rot(2), y_rot(2)];
            cut_counter = cut_counter + 1;
            square_counter = square_counter + 1;
        end
    end
end

if 0 < shorten_cut && shorten_cut < 1
    cut_list = change_length_of_cuts(cut_list,1:amountOfCuts,-shorten_cut);
end

end