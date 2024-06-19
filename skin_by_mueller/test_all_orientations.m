n = 2;

counter = 1;
L2 = zeros(4^(n^2),1);
orientation = zeros(4^(n^2),4);

for i1 = 1:4
    for i2 = 1:4
        for i3 = 1:4
            for i4 = 1:4
                orientation(counter,:) = [i1,i2,i3,i4];
                cut_list = generate_squares_with_cuts(n, orientation(counter,:), 0.2);
                [~, result] = compute_skin(cut_list, 0.5, true);
                L2(counter) = calculate_Lp_norm_von_mises_stress(result, 2);
                counter = counter + 1;
            end
        end
    end
end