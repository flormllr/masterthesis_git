clc, clear, close

% also known as "flowsnake"

Z = pattern_gosper_curve(4); % original 4
px = real(Z) - min(real(Z));
py = imag(Z) - min(imag(Z));
px = 2.9*px/max(px) - 1;
py = 3.1*py/max(py) - 0.98;

cut_list = generate_cuts_from_points(px, py);
% index = find((abs(cut_list(:,1)) <= 0.5) & (abs(cut_list(:,2)) <= 0.5)...
%             & (abs(cut_list(:,3)) <= 0.5) & (abs(cut_list(:,4)) <= 0.5));
% cut_list = cut_list(index,:) + 0.5;
cut_list = cut_list((abs(cut_list(:,1)) <= 0.5) & (abs(cut_list(:,2)) <= 0.5)...
            & (abs(cut_list(:,3)) <= 0.5) & (abs(cut_list(:,4)) <= 0.5), :) + 0.5;
cut_list = cut_list + 0.005;

% cut_list = shorten_edges(cut_list, 0.03); % original 0.01

% cut_list = eliminate_cuts_around_corner(cut_list, 0.2);

plot_cut_list(cut_list);
% plot_cut_list_jpg(cut_list, "Gosper curve", "gosper_curve");

% horizontal_and_vertical = true;
% displacement = 0.5;
% [output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% figure
% imshow(output_image)

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: Gosper curve', 'gosper_curve')
% plot_von_mises_stress_jpg(result, 'von Mises stress (log scale): Gosper curve', 'gosper_curve_log', true)


% plot_nodes_mesh_highest_von_mises_stress(result, 50);
% plot_nodes_mesh_highest_von_mises_stress_jpg(result, 50, 'Gosper curve', 'gosper_curve')

% generate_pictures_jpg(cut_list,'gosper_curve');

% L1 = calculate_Lp_norm_von_mises_stress(result,1);
% L2 = calculate_Lp_norm_von_mises_stress(result,2);
% L3 = calculate_Lp_norm_von_mises_stress(result,3);
% L4 = calculate_Lp_norm_von_mises_stress(result,4);
% L5 = calculate_Lp_norm_von_mises_stress(result,5);
% L6 = calculate_Lp_norm_von_mises_stress(result,6);
% normes = [L1,L2,L3,L4,L5,L6]