clc, clear, close

[px, py] = lebesgue2(3);
px = px + 0.5;
py = py + 0.5;

cut_list = generate_cuts_from_points(px, py);

% cut_list = change_length_of_cuts(cut_list, 1:size(cut_list,1), -0.4);

% cut_list = eliminate_cuts_around_corner(cut_list, 0.2);

plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "Z curve", "z_curve");

% horizontal_and_vertical = true;
% displacement = 0.5;
% [output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image)

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: Z curve', 'z_curve')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): Z curve', 'z_curve_log', true)

% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'Z curve', 'z_curve')

% generate_pictures_jpg(cut_list, 'z_curve');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]