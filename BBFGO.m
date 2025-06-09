function[Leader_score,Convergence_curve,new_bamboos,ct] = BBFGO(bamboos, objective_function, lb, ub, max_iter)
% IGS-BBFGOA (Improved Group Search Binary Bamboo Forest Growth Optimization Algorithm) Implementation

% Parameters
num_groups = size(bamboos, 1);
dim = size(bamboos, 2);
group_size = 10;        % Number of bamboos in each group

% Initialize bamboos (population)
num_bamboos = num_groups * group_size;

% Evaluate initial bamboo positions
fitness = zeros(num_bamboos, 1);
for i = 1:num_bamboos
    fitness(i) = objective_function(bamboos(i, :));  % Evaluate each bamboo's fitness
end

% initialize position vector and score for the leader
new_bamboos=zeros(1,dim);
Leader_score=inf; %change this to -inf for maximization problems


%Initialize the positions of search agents

Convergence_curve=zeros(1,Max_iter);
iter=0;% Loop counter
tic;

% Main loop
for iter = 1:max_iter
    % Group bamboos into groups
    groups = reshape(bamboos, group_size, num_groups, dim);
    
    % Calculate group best fitness and position
    group_best_fitness = inf(num_groups, 1);
    group_best_position = zeros(num_groups, dim);
    for g = 1:num_groups
        group_fitness = fitness((g-1)*group_size+1:g*group_size);
        [min_fitness, min_idx] = min(group_fitness);
        group_best_fitness(g) = min_fitness;
        group_best_position(g, :) = bamboos((g-1)*group_size+min_idx, :);
    end
    
    % Update bamboos' positions based on group best positions
    new_bamboos = bamboos;
    for i = 1:num_bamboos
        group_idx = ceil(i / group_size);
        % Bamboo growth process: grow towards group best position
        growth_rate = rand(1, dim);  % Random growth rate (0 to 1)
        new_bamboos(i, :) = (bamboos(i, :) | (growth_rate > 0.5 * group_best_position(group_idx, :)));
    end
    
    % Evaluate new bamboo positions
    new_fitness = zeros(num_bamboos, 1);
    for i = 1:num_bamboos
        new_fitness(i) = objective_function(new_bamboos(i, :));  % Evaluate each new bamboo's fitness
    end
    
    % Update bamboos if the new position is better
    for i = 1:num_bamboos
        if new_fitness(i) < fitness(i)  % Minimization problem
            bamboos(i, :) = new_bamboos(i, :);
            fitness(i) = new_fitness(i);
        end
        iter=iter+1;
        Convergence_curve(iter)=Leader_score;
    end
    Leader_score = Convergence_curve(end);
    ct = toc;
end
end
