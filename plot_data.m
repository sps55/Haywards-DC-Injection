% Function to plot multiple datasets in one window.

function plot_data(x_vars, y_vars, x_varname, y_varnames, x_limits)
    num_plots = length(y_varnames);

    for i = 1:num_plots
        subplot(num_plots, 1, i);
        plot(x_vars{i}, y_vars{i});
        ylabel(y_varnames{i});
        xlim(x_limits);
    end

    xlabel(x_varname);
end