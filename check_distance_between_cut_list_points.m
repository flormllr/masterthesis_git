function [c, rest] = check_distance_between_cut_list_points(cut_list, distance)
% SUMMARY:
%       This function calculates the distance between the points in
%       cut_list and checks if it is the value given in distance. It
%       returns a vector and each entry is the difference of the lenght of
%       the cut and the aimed for distance.
%       Output is formatted s.t. the function can be used for fmincon,
%       since we wil need c<=0 and rest==0.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       distance: length that the cuts should have
% OUTPUT:
%       rest: vector, each entry is the difference of the length of each
%           cut and the aimed for length given in distance.

cut_count = size(cut_list,1);
rest = zeros(cut_count,1);
c = zeros(cut_count,1);

for i = 1:cut_count
    rest(i) = sqrt((cut_list(i,1)-cut_list(i,3))^2 + (cut_list(i,2)-cut_list(i,4))^2) - distance;
end

end