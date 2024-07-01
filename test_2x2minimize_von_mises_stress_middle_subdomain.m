clc, clear, close

disp("script starts (2x2 on subdomain)")

n = 10;
n_middle = 2;
drawBox = [2/5,2/5; 3/5,2/5; 3/5,3/5; 2/5,3/5; 2/5,2/5];
subdomain = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];

save_orientation = zeros(n^2,4);
% p = 2;
for p_counter = 1:4
    if p_counter == 1
        p = 2;
    elseif p_counter == 2
        p = 4;
    elseif p_counter == 3
        p = 6;
    elseif p_counter == 4
        p = "infty";
    end
    disp("p=" + p + " is starting now.")

    % f_orientation = @(orientation_middle) minimize_von_mises_stress_middle(n, n_middle, orientation_middle, p, subdomain);
    % nvars = n_middle^2;
    % lb = ones(nvars,1);
    % ub = 4*ones(nvars,1)
    % swap_middle = [1,2; 2,1];
    %
    % options = optimoptions('ga','Display','diagnose','PopulationSize',nvars,'MaxStallGenerations',20,'MaxGenerations',100,...
    %     'InitialPopulationMatrix',swap_middle);
    % [orientation_min_middle,VMstress_min,exitflag,output,population,scores] = ga(f_orientation,nvars,[],[],[],[],lb,ub,[],1:nvars,options);
    % % [orientation_min_middle,VMstress_min,exitflag,output,population,scores] = ga(f_orientation,nvars,[],[],[],[],lb,ub,[],1:nvars);

    VMstress = zeros(4^(n_middle^2),1);
    orientation_middle = zeros(4^(n_middle^2),4);
    counter = 1;
    for i1 = 1:4
        for i2 = 1:4
            for i3 = 1:4
                for i4 = 1:4
                    orientation_middle(counter,:) = [i1, i2, i3, i4];
                    VMstress(counter) = minimize_von_mises_stress_middle(n, n_middle, [i1, i2, i3, i4], p, subdomain);
                    counter = counter + 1;
                end
            end
        end
    end
    [VMstress_min, argmin] = min(VMstress);
    orientation_min_middle = orientation_middle(argmin, :);

    orientation_min_middle = reshape(orientation_min_middle, [n_middle n_middle])';

    orientation_min = repmat(orientation_min_middle, n/n_middle);
    cut_list_min = generate_squares_with_cuts(n, orientation_min, 0.2);

    % plot_cut_list(cut_list_min)

    name_title = "Min of L" + p + "-norm over subdomain (1/4,3/4)^2";
    save_pattern_as_dossier_page_pdf(cut_list_min, name_title, "min2x2middle_subdomain", drawBox, subdomain)

    save_orientation(:,p_counter) = orientation_min(:);

    disp("p=" + p + " is done, continue with next p")
end

save("output/2x2subdomain_orientation.mat","save_orientation");

disp("We are done, congrats. Please look at your file min2x2middle_subdomain.pdf")