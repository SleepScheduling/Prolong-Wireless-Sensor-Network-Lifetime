function[Leader_score,Convergence_curve,new_position,ct] = GSOA(snakes, objective_function, lb, ub, max_iter)
% Garter Snake Optimization Algorithm (GSOA) Implementation

num_snakes = size(snakes, 1);
dim = size(snakes, 2);

% Evaluate initial snake positions
fitness = zeros(num_snakes, 1);
for i = 1:num_snakes
    fitness(i) = objective_function(snakes(i, :));  % Evaluate each snake's fitness
end
%Initialize the positions 

new_position=zeros(1,dim);
Leader_score=inf; %change this to -inf for maximization problems

Convergence_curve=zeros(1,Max_iter);

iter=0;% Loop counter
tic;
% Main loop
for iter = 1:max_iter
    % Sort snakes based on fitness (descending order)
    [fitness, sorted_idx] = sort(fitness, 'descend');
    snakes = snakes(sorted_idx, :);
    
    % Update snakes' positions using GSOA movement rules
    for i = 1:num_snakes
        % Calculate new position for snake i
        new_position = snakes(i, :) + randn(1, dim);  % Example: Random movement
        
        % Boundary checking
        new_position = max(new_position, lb);
        new_position = min(new_position, ub);
        
        % Evaluate new position
        new_fitness = objective_function(new_position);
        
        % Update snake if the new position is better
        if new_fitness > fitness(i)
            snakes(i, :) = new_position;
            fitness(i) = new_fitness;
        end
    iter=iter+1;
    Convergence_curve(t)=Leader_score;
    end
    
Leader_score = Convergence_curve(end);
ct = toc;
end

% Display final result
best_position = snakes(1, :);
best_fitness = fitness(1);
disp(['Optimal Solution: ', num2str(best_position)]);
disp(['Optimal Fitness: ', num2str(best_fitness)]);
end
