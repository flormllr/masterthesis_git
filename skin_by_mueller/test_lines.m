clc, clear, close

% length of a cut for a straight line
cut_list = [0, 0, 0.1, 0];

cut_list = repeat_pattern(cut_list, 7, 13, 0.02, 0.02, 0.04, 0.08, 0, 0, false);

cut_list = eliminate_cuts_around_corner(cut_list, 0.15);

% plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "lines", "lines");

horizontal_and_vertical = true;
displacement = 0.5;
[output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image);

fig = figure;
plot_von_mises_stress(result,true);
saveas(fig,'output/VMstress_lines_TEST.pdf');
close(fig)
% plot_von_mises_stress_jpg(result, 'von Mises stress: lines', 'lines')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): lines', 'lines_log', true)

% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'lines', 'lines')

% generate_pictures_jpg(cut_list, 'lines');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]