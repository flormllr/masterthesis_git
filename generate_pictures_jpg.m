function generate_pictures_jpg(cut_list, problem_name)
% SUMMARY:
%       This function generates jpg-files of the solution to our problem.
%       We look at stretching only in vertical direction, in vertical and
%       horizontal direction and at different displacement values.
%       The files are saved in the "images" folder.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       problem_name: name of our problem/pattern

idx = 0;

for both_directions = 0:1
    for displ = 0:0.25:0.5
        output_image = compute_skin(cut_list, displ, both_directions);
        filename = sprintf('images/%s_%d_%.2f_%d.jpg', problem_name, idx, displ, both_directions);
        imwrite(output_image, filename);
        idx = idx + 1;
    end
end

end