clc, clear, close

b = 0.1;

P = [0, b; 0, 0; b, 0; b, b; 0, b];
cut_list = generate_cuts_from_points(P(:,1), P(:,2));

cut_list = shorten_edges(cut_list, 0.02);

cut_list = repeat_pattern(cut_list, 9, 9, 0.05, 0.05, 0.0, 0.0, 0, 0, true);

cut_list = eliminate_cuts_around_corner(cut_list, 0.15);

plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "grid", "grid");

horizontal_and_vertical = true;
displacement = 0.5;
[output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image)

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: grid', 'grid')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): grid', 'grid_log', true)

% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'grid', 'grid')

% generate_pictures_jpg(cut_list, 'grid');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]