clc, clear, close

n = 10;
% cut_list = generate_squares_with_cuts(n, randi(4,n*n,1), 0.2);
cut_list = generate_squares_with_cuts(n, ones(n*n,1), 0.2);
% cut_list = generate_squares_with_cuts_degrees(n, randi(180,n*n,1), 0.2);
% cut_list = generate_squares_with_cuts_degrees(n, 135, 0.2);

cut_list = eliminate_cuts_around_corner(cut_list, 0.1 + 1/n);

plot_cut_list(cut_list);

% horizontal_and_vertical = true;
% displacement = 0.25;
% [output_image, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);

% plot_solution_on_skin(result)

% figure
% imshow(output_image);

% plot_von_mises_stress(result);
% plot_von_mises_stress_jpg(result, 'von Mises stress: random pattern', 'random_10x10')

% plot_nodes_mesh_highest_von_mises_stress(result, 50);

% n = 2;
% VM = zeros(4^(n*n),1);
% orientation = zeros(4^(n*n), 4);
% counter = 1;
% for i = 1:4
%     for j = 1:4
%         for k = 1:4
%             for l = 1:4
%                 orientation(counter, :) = [i, j, k, l];
%                 cut_list = generate_squares_with_cuts(n, orientation(counter, :));
%                 cut_list = shorten_edges(cut_list, 1/n/5);
%                 [~, result] = compute_skin(cut_list, displacement, horizontal_and_vertical);
%                 VM(counter) = norm(result.VonMisesStress);
%                 counter = counter + 1;
%             end
%         end
%     end
% end

% square
% hold on
% plot([0,1,1,0,0], [0,0,1,1,0], 'k')
% for i = 1:n
%     plot([i/n,i/n], [0,1], 'k')
%     plot([0,1], [i/n,i/n], 'k')
% end
% hold off
% xlim([-0.1,1.1])
% ylim([-0.1,1.1])
% axis equal
% grid on

% mesh
% pdeplot(result.Mesh)
% xlim([-0.01,0.2])
% ylim([-0.01,0.2])
% grid on