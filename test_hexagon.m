clc, clear, close

b = 0.076;

cut_list = pattern_hexagon(b);

cut_list = repeat_pattern(cut_list, 4, 13, 0.02, 0.04, b, -(sqrt(3)/2)*b, 1.5*b, 0, true);

cut_list = shorten_edges(cut_list, 0.01);

cut_list = eliminate_cuts_around_corner(cut_list, 0.15);

plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "hexagon shape", "hexagon");

horizontal_and_vertical = true;
displacement = 0.5;
[output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image)

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: hexagon', 'hexagon')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): hexagon', 'hexagon_log', true)

% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'hexagon', 'hexagon')

% generate_pictures_jpg(cut_list, 'hexagon');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]