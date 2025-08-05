% Function to calculate even THD from PQ Box Recordings.

function even_THD = calc_THD(harm_data)
    variables = harm_data.Properties.VariableNames;
    num_vars = length(variables) - 3;
    num_rows = length(harm_data.(variables{1}));
    
    % Calculate even THD
    squared_harmonics = zeros(num_rows, 1);
    fundamental = harm_data.(variables{end-1});
    
    for i = 1:num_vars - 1
        i_harmonic = harm_data.(variables{i+2});
        squared_harmonics = squared_harmonics + i_harmonic.^2;
    end
    
    even_THD = (sqrt(squared_harmonics) ./ fundamental) * 100;
    
end