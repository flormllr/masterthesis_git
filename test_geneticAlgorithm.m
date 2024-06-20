clc, clear, close

disp("it worked, test_geneticAlgorithm is starting to run now");

n = 10;
p = 2;

f_orientation = @(orientation) minimize_von_mises_stress_orientation(n, orientation, p);
nvars = n*n-4;
lb = ones(n*n-4,1);
ub = 4*ones(n*n-4,1);
% nvars = n*n;
% lb = ones(n*n,1);
% ub = 4*ones(n*n,1);

orientation_swap = ones(1,100);
orientation_swap([2,4,6,8,10,11,13,15,17,19,22,24,26,28,30,31,33,35,37,39,42,44,...
    46,48,50,51,53,55,57,59,62,64,66,68,70,71,73,75,77,79,82,84,86,88,90,91,93,95,97,99]) = 2;
orientation_swap([1,10,91,100]) = [];
% orientation_swap = [1,2,2,1];

disp("genetic algorithm starts now");

options = optimoptions('ga','PopulationSize',nvars,'InitialPopulationMatrix',orientation_swap,'Display','diagnose','MaxStallGenerations',500,'MaxGenerations',1000);
% options = optimoptions('ga','Display','diagnose','PopulationSize',nvars,'MaxStallGenerations',20,'MaxGenerations',100,...
%     'InitialPopulationMatrix',orientation_swap);
[orientation_min,VMstress_min,exitflag,output,population,scores] = ga(f_orientation,nvars,[],[],[],[],lb,ub,[],1:nvars,options);

save("output/orientation_min.mat","orientation_min");
save("output/VMstress_min.mat","VMstress_min");
save("output/exitflag.mat","exitflag");
save("output/output.mat","output");
save("output/population.mat","population");
save("output/scores.mat","scores");