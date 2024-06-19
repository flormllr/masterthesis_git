clc, clear, close

minimize_cut_list = false;
minimize_orientation = false;
minimize_length = true;

n = 10;
p = 2;

if minimize_length
    cut_list = get_cut_list_patterns_10x10("swap");
    % f_length = @(length) minimize_von_mises_stress_length_cuts(length, cut_list, p);
    f_length = @(length) minimize_von_mises_stress_length_cuts(length, cut_list, p, [1/10, 9/10], [1/10, 9/10]);
    
    % options = optimoptions('fmincon','Display','iter');
    % -0.1518
    % [length_min, VM_min, exitflag, output] = fmincon(f_length, 0.1, [], [], [], [], -1, 0.2, [], options);
    options = optimset('Display','iter');
    length_min = fminbnd(f_length,-1,0.2,options);

    cut_list_min = change_length_of_cuts(cut_list, 1:size(cut_list,1), length_min);
    % model = create_lin_elast_model(cut_list_min, 0.5, true, 0.1);
    % generateMesh(model,'Hmax',0.007);
    % result = solve(model);

elseif minimize_cut_list
    vec_orientation = randi(4,n*n,1);
    cut_list_start = generate_squares_with_cuts(n, vec_orientation);
    cut_list_start = shorten_edges(cut_list_start, 1/n/5);
    cut_list_start = eliminate_cuts_around_corner(cut_list_start, 0.1 + 1/n/10);
    f_cut_list = @(cut_list) minimize_von_mises_stress_cut_list(cut_list, p);

    distance_cut_list = sqrt((cut_list_start(1,1)-cut_list_start(1,3))^2 + (cut_list_start(1,2)-cut_list_start(1,4))^2);
    con_cut_list_distance = @(cut_list) check_distance_between_cut_list_points(cut_list, distance_cut_list);

    cut_list_size = nnz(vec_orientation);

    cut_list_min = fmincon(f_cut_list, cut_list_start, [], [], [], [], 0.1*ones(cut_list_size,4), 0.9*ones(cut_list_size,4), con_cut_list_distance);
    % cut_list_min = fminsearchbnd(f_cut_list, cut_list_start, 0.1*ones(cut_list_size,4), 0.9*ones(cut_list_size,4));
elseif minimize_orientation
    f_orientation = @(orientation) minimize_von_mises_stress_orientation(n, orientation, p);
    nvars = n*n;
    lb = ones(n*n,1);
    ub = 4*ones(n*n,1);

    orientation_swap = ones(100,1);
    orientation_swap([2,4,6,8,10,11,13,15,17,19,22,24,26,28,30,31,33,35,37,39,42,44,...
        46,48,50,51,53,55,57,59,62,64,66,68,70,71,73,75,77,79,82,84,86,88,90,91,93,95,97,99]) = 2;
    orientation_swap([1,10,91,100]) = 0;

    options = optimoptions('ga','Display','diagnose','PopulationSize',nvars,'MaxStallGenerations',20,'MaxGenerations',100,...
        'InitialPopulationMatrix',orientation_swap);
    [orientation_min,VMstress_min,exitflag,output,population,scores] = ga(f_orientation,nvars,[],[],[],[],lb,ub,[],1:nvars,options);
    % orientation_min = ga(f_orientation,nvars,[],[],[],[],lb,ub,[],1:nvars,options);

    cut_list_min = generate_squares_with_cuts(n, orientation_min);
    % cut_list_min = shorten_edges(cut_list_min, 1/n/5);
    cut_list_min = eliminate_cuts_around_corner(cut_list_min, 0.1 + 1/n/10);
end

plot_cut_list(cut_list_min);