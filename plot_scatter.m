% Function to plot multiple datasets in one window.

function plot_scatter(x_vars, y_vars, x_varname, y_varnames, x_limits)
    num_plots = length(y_varnames);

    for i = 1:num_plots
        subplot(num_plots, 1, i);
        [curve, gof] = fit(x_vars{i}, y_vars{i}, 'poly3');
        plot(curve, x_vars{i}, y_vars{i}, 'o');
        ylabel(y_varnames{i});
        xlim(x_limits);
        legend("Raw Data", "Fitted Curve");
        R2 = sprintf('R2 = %2f', gof.rsquare);
        text(x_limits(2)*3/4, max(y_vars{i}*3/4), R2);
    end

    xlabel(x_varname);
end