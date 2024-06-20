clc, clear, close

% n = [2,2;
%     4,4;
%     1,1;
%     3,3];
n = [10,15];
max_cuts = max(n(:,1).*n(:,2));
% vec_degree = zeros(size(n,1), max_cuts);
vec_degree = ones(1,200);
% vec_degree(1,1:4) = [45,135,45,90];
% vec_degree(2,1:16) = randi(180,16,1);
% vec_degree(3,1) = 135;
% vec_degree(4,1:9) = randi(180,9,1);
% xRange = [0,1/2;
%     1/2,1;
%     0,1/2;
%     1/2,1];
% yRange = [0,1/2;
%     1/2,1;
%     1/2,1
%     0,1/2];
xRange = [0,1];
yRange = [0,1];
cut_list = generate_squares_with_cuts_different_lengths(n, vec_degree, xRange, yRange, 0.2);

% cut_list = eliminate_cuts_around_corner(cut_list, 0.15);

% plot_cut_list(cut_list);

horizontal_and_vertical = true;
displacement = 0.5;
[output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% plot_solution_on_skin(result)

% figure
% imshow(output_image);

plot_von_mises_stress(result,true);
% plot_von_mises_stress_jpg(result, 'von Mises stress: random pattern', 'random_10x10')

% plot_nodes_mesh_highest_von_mises_stress(result, 50);