function cut_list = get_cut_list_patterns_10x10_cutsEverywhere(name)
% SUMMARY:
%       This function generates and returns the cut_list for the pattern
%       specified in name. Possible patterns are:
%       "lines", "grid", "s", "hexagon", "octagon", "hilbert_curve",
%       "sierpinski_curve", "peano_curve", "gosper_curve", "swap",
%       "swap_diagonal", "z_curve", "e_curve".
%       Here there are cuts in every little square. Only the four corners
%       don't have cuts.
% INPUT:
%       name: string, specifying the name of the pattern
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

n = 10;
shorten_by = 0.2;

if name == "lines"
    orientation = ones(100,1);
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "grid"
    orientation = zeros(100,1);
    orientation(2:2:end-2) = 1;
    orientation(3:2:end-1) = 2;
    orientation([10,91]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "s"
    orientation = zeros(100,1);
    orientation([2,4,6,8,22,24,26,28,30,42,44,46,48,50,52,54,56,58,60,72,74,76,78,80,92,94,96,98]) = 1;
    orientation([11,13,15,17,19,31,33,35,37,39,61,63,65,67,69,81,83,85,87,89]) = 2;
    orientation([3,5,7,9,41,43,45,47,49,51,53,55,57,59,91,93,95,97,99,12,16,20,34,38,62,66,70,84,88]) = 4;
    orientation(orientation==0) = 3;
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "hexagon"
    degrees = [0,180,180,0,0,180,180,0,0,180;
        60,60,120,120,60,60,120,120,60,60;
        120,120,60,60,120,120,60,60,120,120;
        0,180,180,0,0,180,180,0,0,180;
        60,60,120,120,60,60,120,120,60,60;
        120,120,60,60,120,120,60,60,120,120;
        0,180,180,0,0,180,180,0,0,180;
        60,60,120,120,60,60,120,120,60,60;
        120,120,60,60,120,120,60,60,120,120;
        0,180,180,0,0,180,180,0,0,180]';
    degrees(degrees==0) = 90;
    degrees = degrees(:);
    degrees([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "octagon"
    degrees = zeros(100,1);
    degrees([3,4,7,8,43,44,47,48,83,84,87,88,23,24,27,28,63,64,67,68]) = 180;
    degrees([12,13,16,17,20,34,35,38,39,52,53,56,57,60,74,75,78,79,92,93,96,97,100,31,71]) = 45;
    degrees([21,22,25,26,29,30,61,62,65,66,69,70,2,5,6,9,41,42,45,46,49,50,81,82,85,86,89,90]) = 90;
    degrees([14,15,18,19,32,33,36,37,40,54,55,58,59,72,73,76,77,80,94,95,98,99,11,51,91]) = 135;
    degrees([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "hilbert_curve"
    orientation = [0,2,1,1,2,2,1,1,2,0;
        1,2,2,1,2,2,1,2,2,1;
        3,4,3,1,4,3,1,4,3,4;
        2,1,2,3,2,2,4,2,1,2;
        2,3,1,1,4,3,1,1,4,2;
        1,1,2,1,1,1,1,2,1,1;
        4,2,1,2,3,4,2,1,2,3;
        2,1,2,1,2,2,1,2,1,2;
        4,3,1,3,2,2,4,1,4,3;
        0,2,1,2,2,2,2,1,2,0]';
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "sierpinski_curve"
    degrees = [0,135,180,45,135,45,135,180,45,0;
        135,135,180,135,45,135,45,180,45,45;
        180,90,45,90,180,180,90,135,90,180;
        45,45,180,135,135,45,45,180,135,135;
        135,45,90,135,135,45,45,90,135,45;
        180,90,180,90,45,135,90,180,90,180;
        45,135,90,45,180,180,135,90,45,135;
        135,135,180,45,45,135,135,180,45,45;
        45,90,135,90,180,180,90,135,90,135;
        0,45,180,135,135,45,45,180,135,0]';
    degrees = degrees(:);
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "peano_curve"
    orientation = [0,3,2,1,2,4,2,1,2,0;
        2,4,2,3,2,4,2,3,2,4;
        2,1,2,4,2,3,2,4,2,1;
        4,3,4,3,2,4,2,3,4,3;
        2,1,2,4,2,3,2,4,2,1;
        2,4,2,3,2,4,2,3,2,4;
        2,3,2,1,2,3,2,1,2,3;
        2,4,3,4,3,4,3,4,3,4;
        2,3,2,1,2,3,2,1,2,3;
        0,1,2,4,2,1,2,3,2,0]';
    orientation = orientation(:);
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "gosper_curve"
    degrees = [0,180,90,180,120,180,90,180,90,0;
        180,90,180,90,180,90,60,90,120,90;
        60,120,90,60,180,180,60,120,90,120;
        90,60,180,60,180,120,120,90,180,90;
        120,90,180,90,180,60,60,90,180,90;
        90,180,90,60,180,180,60,60,120,180;
        180,90,120,90,180,180,90,60,60,60;
        90,180,90,60,180,120,90,120,180,90;
        60,180,60,180,90,180,90,60,90,180;
        0,90,180,90,60,180,180,90,180,0]';
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "swap"
    orientation = ones(100,1);
    orientation([2,4,6,8,10,11,13,15,17,19,22,24,26,28,30,31,33,35,37,39,42,44,...
        46,48,50,51,53,55,57,59,62,64,66,68,70,71,73,75,77,79,82,84,86,88,90,91,93,95,97,99]) = 2;
    % orientation([1,2,9,10,11,20,81,90,91,92,99,100]) = 0;
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "swap_diagonal"
    orientation = 4*ones(100,1);
    orientation([2,4,6,8,10,11,13,15,17,19,22,24,26,28,30,31,33,35,37,39,42,44,...
        46,48,50,51,53,55,57,59,62,64,66,68,70,71,73,75,77,79,82,84,86,88,90,91,93,95,97,99]) = 3;
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);     
elseif name == "z_curve"
    orientation = [0,2,1,2,1,2,1,2,1,0;
        3,4,4,1,4,4,4,1,4,4;
        1,2,1,3,1,2,1,3,1,2;
        3,4,3,2,3,4,3,2,3,4;
        1,2,1,3,1,2,1,3,1,2;
        4,4,4,1,4,4,4,1,4,4;
        1,2,1,3,1,2,1,3,1,2;
        3,4,3,2,3,4,3,2,3,4;
        1,2,1,3,1,2,1,3,1,2;
        0,4,4,1,4,4,4,1,3,0]';
    orientation = orientation(:);
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "e_curve"
    orientation = [0,1,1,2,3,4,3,4,3,0;
        4,3,4,2,4,3,4,3,4,2;
        3,2,1,1,3,2,1,2,3,2;
        4,2,1,1,4,2,4,2,1,1;
        3,4,3,2,3,2,3,4,3,4;
        1,1,1,2,4,1,1,2,4,3;
        2,4,3,4,3,4,3,2,3,4;
        1,1,1,1,1,1,4,2,4,3;
        3,4,3,4,3,2,3,2,3,4;
        0,3,4,3,4,1,1,1,4,0]';
    orientation = orientation(:);
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
end

end