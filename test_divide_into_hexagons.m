clc, clear, close

n = 5;
cut_list = generate_hexagons_with_cuts(n, 180*ones(100,1), 0.05);
% cut_list = generate_hexagons_with_cuts(n, randi(180,100,1), 0.05);

% hold on
plot_cut_list(cut_list);
axis equal
% hold off

% horizontal_and_vertical = true;
% displacement = 0.5;
% innerFace = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
% innerFace = [1/10,1/10; 9/10,1/10; 9/10,9/10; 1/10,9/10];
% [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
% [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical, innerFace);

% L = zeros(1,8);
% for i = 1:6
%     % L(i) = calculate_Lp_norm_von_mises_stress(result, i);
%     L(i) = calculate_Lp_norm_von_mises_stress(result, i, [min(innerFace(:,1)),max(innerFace(:,1))], [min(innerFace(:,2)),max(innerFace(:,2))]);
% end
% % L(7) = calculate_Lp_norm_von_mises_stress(result, "infty");
% L(7) = calculate_Lp_norm_von_mises_stress(result, "infty", [min(innerFace(:,1)),max(innerFace(:,1))], [min(innerFace(:,2)),max(innerFace(:,2))]);
% % L(8) = calculate_compliance(result);
% L(8) = calculate_compliance(result, [min(innerFace(:,1)),max(innerFace(:,1))], [min(innerFace(:,2)),max(innerFace(:,2))]);
% L

% plot_solution_on_skin(result);

% plot_von_mises_stress(result);

% plot_nodes_mesh_highest_von_mises_stress(result, 50);