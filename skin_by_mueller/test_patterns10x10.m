clc, clear, close

cut_list = get_cut_list_patterns_10x10("swap");

% cut_list = change_length_of_cuts(cut_list, 1:size(cut_list,1), 0.2);

% plot_cut_list(cut_list)
% hold on
% plot([0,0,1,1,0],[0,1,1,0,0],'k-')
% hold off
% xlim([-0.1,1.1])
% ylim([-0.1,1.1])
% axis equal
% grid on

horizontal_and_vertical = true;
displacement = 0.5;
innerFace = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
% innerFace = [1/10,1/10; 9/10,1/10; 9/10,9/10; 1/10,9/10];
% [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
[~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical, innerFace);

% xBox = [1/4 3/4];
% yBox = [1/4 3/4];
% Ef = findElements(result.Mesh,"box",xBox,yBox);
% figure
% pdemesh(result.Mesh)
% hold on
% pdemesh(result.Mesh.Nodes,result.Mesh.Elements(:,Ef),EdgeColor="green")
% plot([xBox(1),xBox(1),xBox(2),xBox(2),xBox(1)],[yBox(1),yBox(2),yBox(2),yBox(1),xBox(1)],'k-')
% hold off

% calculate_Lp_norm_von_mises_stress(result,2)
% calculate_Lp_norm_von_mises_stress(result,2,[min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
% L = zeros(1,6);
% for i = 1:6
%     L(i) = calculate_Lp_norm_von_mises_stress(result,i,[min(innerFace(:,1)),max(innerFace(:,1))],[min(innerFace(:,2)),max(innerFace(:,2))]);
% end
% L

% plot_solution_on_skin(result)

% plot_von_mises_stress(result,true);

% plot_nodes_mesh_highest_von_mises_stress(result, 50);



% names = ["lines", "grid", "s", "hexagon", "octagon", "hilbert_curve",...
%     "sierpinski_curve", "peano_curve", "gosper_curve", "swap", "z_curve", "e_curve"];
% % names = ["lines","grid"];
% normes = zeros(length(names),7);
% normesRange = zeros(length(names),6);
% normesRange2 = zeros(length(names),6);
% for i = 1:length(names)
%     pattern = names(i);
%     cut_list = get_cut_list_patterns_10x10(pattern);
%     horizontal_and_vertical = true;
%     displacement = 0.5;
%     [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
% 
%     L1 = calculate_Lp_norm_von_mises_stress(result,1);
%     L2 = calculate_Lp_norm_von_mises_stress(result,2);
%     L3 = calculate_Lp_norm_von_mises_stress(result,3);
%     L4 = calculate_Lp_norm_von_mises_stress(result,4);
%     L5 = calculate_Lp_norm_von_mises_stress(result,5);
%     L6 = calculate_Lp_norm_von_mises_stress(result,6);
%     Linfty = max(result.VonMisesStress/1000000);
%     xRange = [1/10, 9/10];
%     yRange = [1/10, 9/10];
%     L1range = calculate_Lp_norm_von_mises_stress(result,1,xRange,yRange);
%     L2range = calculate_Lp_norm_von_mises_stress(result,2,xRange,yRange);
%     L3range = calculate_Lp_norm_von_mises_stress(result,3,xRange,yRange);
%     L4range = calculate_Lp_norm_von_mises_stress(result,4,xRange,yRange);
%     L5range = calculate_Lp_norm_von_mises_stress(result,5,xRange,yRange);
%     L6range = calculate_Lp_norm_von_mises_stress(result,6,xRange,yRange);
%     xRange = [1/4, 3/4];
%     yRange = [1/4, 3/4];
%     L1range2 = calculate_Lp_norm_von_mises_stress(result,1,xRange,yRange);
%     L2range2 = calculate_Lp_norm_von_mises_stress(result,2,xRange,yRange);
%     L3range2 = calculate_Lp_norm_von_mises_stress(result,3,xRange,yRange);
%     L4range2 = calculate_Lp_norm_von_mises_stress(result,4,xRange,yRange);
%     L5range2 = calculate_Lp_norm_von_mises_stress(result,5,xRange,yRange);
%     L6range2 = calculate_Lp_norm_von_mises_stress(result,6,xRange,yRange);
%     pattern;
%     normes(i,:) = [L1,L2,L3,L4,L5,L6,max(result.VonMisesStress/1000000)];
%     normes(i,:) = [L1,L2,L3,L4,L5,L6,Linfty];
%     normesRange(i,:) = [L1range,L2range,L3range,L4range,L5range,L6range];
%     normesRange2(i,:) = [L1range2,L2range2,L3range2,L4range2,L5range2,L6range2];
% end
% 
% T = array2table(normes,'VariableNames',["L1","L2","L3","L4","L5","L6","max"],"RowNames",names);
% Trange = array2table(normesRange,'VariableNames',["L1","L2","L3","L4","L5","L6"],"RowNames",names);
% Trange2 = array2table(normesRange2,'VariableNames',["L1","L2","L3","L4","L5","L6"],"RowNames",names);
% 
% writetable(T,'dossier10x10_normes.xlsx','WriteRowNames',true)
% writetable(Trange,'dossier10x10_normes.xlsx','WriteMode','Append','WriteRowNames',true)
% writetable(Trange2,'dossier10x10_normes.xlsx','WriteMode','Append','WriteRowNames',true)