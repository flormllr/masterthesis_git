function cut_list = get_cut_list(problem_name)
% SUMMARY:
%       This function returns the cut_list for a problem/pattern.
% INPUT:
%       problem_name: name of our problem/pattern
% OUTPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.

if problem_name == "lines"
    cut_list = [0, 0, 0.1, 0];
    cut_list = repeat_pattern(cut_list, 7, 13, 0.02, 0.02, 0.04, 0.08, 0, 0, false);
elseif problem_name == "shifted_lines"
    cut_list = [0, 0, 0.08, 0];
    cut_list = repeat_pattern(cut_list, 8, 13, 0.02, 0.02, 0.04, 0.08, 0.04, 0, false);
elseif problem_name == "grid"
    b = 0.1;
    P = [0, b; 0, 0; b, 0; b, b; 0, b];
    cut_list = generate_cuts_from_points(P(:,1), P(:,2));
    cut_list = shorten_edges(cut_list, 0.02);
    cut_list = repeat_pattern(cut_list, 9, 9, 0.05, 0.05, 0.0, 0.0, 0, 0, true);
elseif problem_name == "s"
    b = 0.1;
    P = [0 0; b 0; b b; 0 b; 0 2*b; b 2*b];
    cut_list = generate_cuts_from_points(P(:,1), P(:,2));
    cut_list = shorten_edges(cut_list, 0.01);
    cut_list = repeat_pattern(cut_list, 7, 4, 0.02, 0.02, 0.04, 0.04, 0, 0, false);
elseif problem_name == "hexagon"
    b = 0.076;
    cut_list = pattern_hexagon(b);
    cut_list = repeat_pattern(cut_list, 4, 13, 0.02, 0.04, b, -(sqrt(3)/2)*b, 1.5*b, 0, true);
    cut_list = shorten_edges(cut_list, 0.01);
elseif problem_name == "octagon"
    b = 0.05;
    cut_list = pattern_octagon(b);
    cut_list = repeat_pattern(cut_list, 8, 8, 0.02, 0.02, 0, 0, 0, 0, true);
    cut_list = shorten_edges(cut_list, 0.01);
elseif problem_name == "hilbert_curve"
    [px, py] = pattern_hilbert_curve(4);
    px = px + 0.5;
    py = py + 0.5;
    cut_list = generate_cuts_from_points(px, py);
    cut_list = shorten_edges(cut_list, 0.05);
elseif problem_name == "sierpinski_curve"
    Z = pattern_sierpinski_curve(3);
    px = real(Z)/2;
    py = imag(Z)/2;
    px = px + 0.5;
    py = py + 0.5;
    cut_list = generate_cuts_from_points(px, py);
    cut_list = shorten_edges(cut_list, 0.01);
elseif problem_name == "peano_curve"
    [px, py] = pattern_peano_curve(1);
    cut_list = generate_cuts_from_points(px, py);
    cut_list = shorten_edges(cut_list, 0.02);
elseif problem_name == "gosper_curve"
    Z = pattern_gosper_curve(4);
    px = real(Z) - min(real(Z));
    py = imag(Z) - min(imag(Z));
    px = 2.9*px/max(px) - 1;
    py = 3.1*py/max(py) - 0.98;
    cut_list = generate_cuts_from_points(px, py);
    index = find((abs(cut_list(:,1)) <= 0.5) & (abs(cut_list(:,2)) <= 0.5)...
        & (abs(cut_list(:,3)) <= 0.5) & (abs(cut_list(:,4)) <= 0.5));
    cut_list = cut_list(index,:) + 0.5;
    cut_list = cut_list + 0.005;
    cut_list = shorten_edges(cut_list, 0.01);
else
    disp("This problem name isn't known here.")
end

end