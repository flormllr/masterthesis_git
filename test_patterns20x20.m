clc, clear, close

% cut_list = get_cut_list_patterns_20x20_cutsEverywhere("gosper_curve");
% cut_list = get_cut_list_patterns_20x20("e_curve");

% cut_list = change_length_of_cuts(cut_list, 1:size(cut_list,1), 0.2);

% plot_cut_list(cut_list)
% hold on
% plot([0,0,1,1,0],[0,1,1,0,0],'k-')
% hold off
% xlim([-0.1,1.1])
% ylim([-0.1,1.1])
% axis equal
% grid on

% horizontal_and_vertical = true;
% displacement = 0.5;
% % innerFace = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
% % innerFace = [1/10,1/10; 9/10,1/10; 9/10,9/10; 1/10,9/10];
% [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
% % [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical, innerFace);
% 
% % calculate_Lp_norm_von_mises_stress(result,2)
% % calculate_Lp_norm_von_mises_stress(result,2,[min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
% % L = zeros(1,6);
% % for i = 1:6
% %     % L(i) = calculate_Lp_norm_von_mises_stress(result,i);
% %     L(i) = calculate_Lp_norm_von_mises_stress(result,i,[min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
% % end
% % % L(7) = calculate_Lp_norm_von_mises_stress(result,"infty");
% % L(7) = calculate_Lp_norm_von_mises_stress(result,"infty",[min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
% % L
% 
% % plot_solution_on_skin(result)
% 
% plot_von_mises_stress(result,true);
% 
% % plot_nodes_mesh_highest_von_mises_stress(result, 50);


names = ["lines", "grid", "s", "hexagon", "octagon", "hilbert_curve",...
    "sierpinski_curve", "peano_curve", "gosper_curve",...
    "swap", "swap_diagonal", "zigzag", "z_curve", "e_curve"];
normes = zeros(length(names),7);
% normesRange = zeros(length(names),7);
for i = 1:length(names)
    pattern = names(i)
    cut_list = get_cut_list_patterns_20x20_cutsEverywhere(pattern);
    horizontal_and_vertical = false;
    displacement = 0.5;
    % innerFace = [1/10,1/10; 9/10,1/10; 9/10,9/10; 1/10,9/10];
    % innerFace = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
    [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
    % [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical, innerFace);

    L1 = calculate_Lp_norm_von_mises_stress(result,1);
    L2 = calculate_Lp_norm_von_mises_stress(result,2);
    L3 = calculate_Lp_norm_von_mises_stress(result,3);
    L4 = calculate_Lp_norm_von_mises_stress(result,4);
    L5 = calculate_Lp_norm_von_mises_stress(result,5);
    L6 = calculate_Lp_norm_von_mises_stress(result,6);
    Linfty = max(result.VonMisesStress/1000000);
    % xRange = [min(innerFace(:,1)),max(innerFace(:,1))];
    % yRange = [min(innerFace(:,2)),max(innerFace(:,2))];
    % L1range = calculate_Lp_norm_von_mises_stress(result,1,xRange,yRange);
    % L2range = calculate_Lp_norm_von_mises_stress(result,2,xRange,yRange);
    % L3range = calculate_Lp_norm_von_mises_stress(result,3,xRange,yRange);
    % L4range = calculate_Lp_norm_von_mises_stress(result,4,xRange,yRange);
    % L5range = calculate_Lp_norm_von_mises_stress(result,5,xRange,yRange);
    % L6range = calculate_Lp_norm_von_mises_stress(result,6,xRange,yRange);
    % Linftyrange = calculate_Lp_norm_von_mises_stress(result,"infty",xRange,yRange);
    normes(i,:) = [L1,L2,L3,L4,L5,L6,Linfty];
    % normesRange(i,:) = [L1range,L2range,L3range,L4range,L5range,L6range,Linftyrange];
end