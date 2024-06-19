clc, clear, close

b = 0.1;

P = [0 0; b 0; b b; 0 b; 0 2*b; b 2*b];
cut_list = generate_cuts_from_points(P(:,1), P(:,2));

cut_list = shorten_edges(cut_list, 0.01);

% x_first_offset, y_first_offset = 0.02 in old version
cut_list = repeat_pattern(cut_list, 7, 4, 0.03, 0.04, 0.04, 0.04, 0, 0, false);

cut_list = eliminate_cuts_around_corner(cut_list, 0.15);

plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "S shape", "s");

horizontal_and_vertical = true;
displacement = 0.5;
[output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image)

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: S', 's')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): S', 's_log', true)

% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'S', 's')

% generate_pictures_jpg(cut_list, 's');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]