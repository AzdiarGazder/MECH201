function simplex_method()

    % Objective function coefficients
    c = [-150; -175];

    % Inequality constraint matrix
    A = [7 11;
         10 8;
         1 0;
         0 1;
        -1 0;
         0 -1];

    % Inequality constraint vector
    b = [77; 80; 9; 6; 0; 0];

    % Initial basic variables
    basic_vars = [3; 4];

    % Perform the simplex method
    [basic_vars, opt_val] = simplex(c, A, b, basic_vars);

    % Display the results
    disp('Optimal values:');
    disp(['x = ', num2str(basic_vars(1))]);
    disp(['y = ', num2str(basic_vars(2))]);
    disp(['Maximum Z = ', num2str(-opt_val)]);

end

function [basic_vars, opt_val] = simplex(c, A, b, basic_vars)

    % Extract the basic and non-basic variables
    non_basic_vars = setdiff(1:length(c), basic_vars);

    % Construct the initial tableau
    B = A(:, basic_vars);  % Use row indices to extract basic variable columns
    N = A(:, non_basic_vars);
    c_b = c(basic_vars);
    c_n = c(non_basic_vars);
    x_b = B\b;

    % Calculate the initial objective value
    opt_val = c_b' * x_b;

    while true
        % Calculate the reduced costs
        reduced_costs = c_n' - c_b' * inv(B) * N;

        % Check for optimality
        if all(reduced_costs >= 0)
            break;
        end

        % Determine the entering variable (pivot column)
        [~, pivot_col_idx] = min(reduced_costs);
        pivot_col = non_basic_vars(pivot_col_idx);

        % Calculate the search direction
        d = inv(B) * A(:, pivot_col);  % Use row indices to extract pivot column

        % Check for unboundedness
        if all(d <= 0)
            error('The problem is unbounded.');
        end

        % Determine the leaving variable (pivot row)
        ratios = x_b ./ d;
        ratios(d <= 0) = inf;
        [~, pivot_row_idx] = min(ratios);
        pivot_row = basic_vars(pivot_row_idx);

        % Update the basic and non-basic variables
        basic_vars(pivot_row_idx) = pivot_col;
        non_basic_vars(pivot_col_idx) = pivot_row;

        % Update the tableau
        B = A(:, basic_vars);  % Use row indices to extract basic variable columns
        N = A(:, non_basic_vars);
        c_b = c(basic_vars);
        c_n = c(non_basic_vars);
        x_b = B\b;

        % Update the objective value
        opt_val = c_b' * x_b;
    end
end

% % Call the simplex method to solve the problem
% simplex_method();
