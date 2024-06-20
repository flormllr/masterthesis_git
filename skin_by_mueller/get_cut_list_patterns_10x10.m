function cut_list = get_cut_list_patterns_10x10(name)
% SUMMARY:
%       This function generates and returns the cut_list for the pattern
%       specified in name. Possible patterns are:
%       "lines", "grid", "s", "hexagon", "octagon", "hilbert_curve",
%       "sierpinski_curve", "peano_curve", "gosper_curve", "swap",
%       "swap_diagonal", "z_curve", "e_curve".
% INPUT:
%       name: string, specifying the name of the pattern
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

n = 10;
shorten_by = 0.2;

if name == "lines"
    orientation = ones(100,1);
    % orientation([1,2,9,10,11,20,81,90,91,92,99,100]) = 0;
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "grid"
    orientation = zeros(100,1);
    orientation(2:2:end-2) = 1;
    orientation(3:2:end-1) = 2;
    orientation([91,10]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "s"
    orientation = zeros(100,1);
    orientation([2,4,6,8]) = 1;
    orientation([13,15,17,19]) = 2;
    orientation([22,24,26,28,30]) = 1;
    orientation([31,33,35,37,39]) = 2;
    orientation([42,44,46,48,50]) = 1;
    orientation([52,54,56,58,60]) = 1;
    orientation([63,65,67,69]) = 2;
    orientation([72,74,76,78,80]) = 1;
    orientation([81,83,85,87,89]) = 2;
    orientation([92,94,96,98]) = 1;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "hexagon"
    degrees = [0,180,0,0,0,180,0,0,0,180;
        60,0,120,180,60,0,120,180,60,0;
        120,0,60,0,120,0,60,0,120,0;
        0,180,0,0,0,180,0,0,0,180;
        60,0,120,180,60,0,120,180,60,0;
        120,0,60,0,120,0,60,0,120,0;
        0,180,0,0,0,180,0,0,0,180;
        60,0,120,180,60,0,120,180,60,0;
        120,0,60,0,120,0,60,0,120,0;
        0,180,0,0,0,180,0,0,0,180]';
    degrees = degrees(:);
    degrees([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "octagon"
    degrees = zeros(100,1);
    degrees([3,7,43,47,83,87]) = 180;
    degrees([12,16,20,34,38,52,56,60,74,78,92,96,100]) = 45;
    degrees([21,25,29,61,65,69]) = 90;
    degrees([14,18,32,36,40,54,58,72,76,80,94,98]) = 135;
    degrees([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "hilbert_curve"
    orientation = [0,2,1,1,2,2,1,1,2,0;
        1,2,2,1,2,2,1,2,2,1;
        0,0,0,1,0,0,1,0,0,0;
        2,1,2,0,2,2,0,2,1,2;
        2,0,1,1,0,0,1,1,0,2;
        1,1,0,1,1,1,1,0,1,1;
        0,2,0,2,0,0,2,0,2,0;
        2,1,0,1,2,2,1,0,1,2;
        0,0,1,0,2,2,0,1,0,0;
        0,2,0,2,2,2,2,0,2,0]';
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "sierpinski_curve"
    degrees = [0,135,0,45,135,45,135,0,45,0;
        135,0,180,0,45,135,0,180,0,45;
        0,90,0,90,0,0,90,0,90,0;
        45,0,180,0,135,45,0,180,0,135;
        135,45,0,135,0,0,45,0,135,45;
        0,0,0,90,0,0,90,0,0,0;
        45,135,0,45,0,0,135,0,45,135;
        135,0,180,0,45,135,0,180,0,45;
        0,90,0,90,0,0,90,0,90,0;
        45,0,180,0,135,45,0,180,0,45]';
    degrees = degrees(:);
    degrees([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts_degrees(n,degrees,shorten_by);
elseif name == "peano_curve"
    orientation = [2,0,2,1,2,0,2,1,2,0;
        2,0,2,0,2,0,2,0,2,0;
        2,1,2,0,2,0,2,0,2,1;
        0,0,0,0,2,0,2,0,0,0;
        2,1,2,0,2,0,2,0,2,1;
        2,0,2,0,2,0,2,0,2,0;
        2,0,2,1,2,0,2,1,2,0;
        2,0,0,0,0,0,0,0,0,0;
        2,0,2,1,2,0,2,1,2,0;
        2,1,2,0,2,1,2,0,2,1;]';
    orientation = orientation(:);
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "gosper_curve"
    degrees = [0,0,0,180,120,0,0,180,0,0;
        0,0,0,0,180,0,60,0,120,0;
        60,120,0,60,180,180,60,120,0,120;
        90,60,0,60,180,120,120,0,180,0;
        120,0,180,0,0,60,60,0,0,0;
        0,180,0,60,180,0,60,60,120,0;
        0,0,120,0,180,180,0,60,60,60;
        0,180,0,60,180,120,0,120,180,0;
        60,180,60,0,0,180,0,60,0,0;
        0,0,0,0,60,180,180,0,0,0]';
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
    orientation = [1,0,1,0,1,0,1,0,1,0;
        4,4,4,0,4,4,4,0,4,4;
        1,0,1,0,1,0,1,0,1,0;
        0,4,0,2,0,4,0,2,0,4;
        1,0,1,0,1,0,1,0,1,0;
        4,4,4,0,4,4,4,0,4,4;
        1,0,1,0,1,0,1,0,1,0;
        0,4,0,2,0,4,0,2,0,4;
        1,0,1,0,1,0,1,0,1,0;
        4,4,4,0,4,4,4,0,4,4]';
    orientation = orientation(:);
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
elseif name == "e_curve"
    orientation = [1,1,1,2,0,0,0,0,0,2;
        0,0,0,2,0,0,0,0,0,2;
        0,2,1,1,0,2,1,2,0,2;
        0,2,1,1,0,2,0,2,1,1;
        0,0,0,2,0,2,0,0,0,0;
        1,1,1,2,0,1,1,2,0,0;
        2,0,0,0,0,0,0,2,0,0,
        1,1,1,1,1,1,0,2,0,0;
        0,0,0,0,0,2,0,2,0,0,
        0,0,0,0,0,1,1,1,0,0]';
    orientation = orientation(:);
    orientation([1,10,91,100]) = 0;
    cut_list = generate_squares_with_cuts(n,orientation,shorten_by);
end

end