n = 10;
p = 2;

o_min = load("output/orientation_min.mat");
orientation = o_min.orientation_min;

orientation_new = zeros(1,n*n);
orientation_new(2:9) = orientation(1:8);
orientation_new(11:90) = orientation(9:88);
orientation_new(92:99) = orientation(89:96);
cut_list = generate_squares_with_cuts(n, orientation_new, 0.2);

cs = 0.1;
displ = 0.5;
horizontal_and_vertical = true;

model = create_lin_elast_model(cut_list, displ, horizontal_and_vertical, cs);

% generates the mesh, Hmax is used to control the mesh size
generateMesh(model,'Hmax',0.007);

result = solve(model);

VMstress = calculate_Lp_norm_von_mises_stress(result, p);

subdomain_to_diplay_normes = [1/4,1/4; 3/4,1/4; 3/4,3/4; 1/4,3/4];
name_title = "Genetic Algorithm with L" + p + "-norm over entire domain";
save_pattern_as_dossier_page_pdf(cut_list, name_title, "geneticAlgorithm", [0,0], subdomain_to_diplay_normes)