% Function for formatting dates.

function plot_multi(x1, x2, y1, y2, x_lab, y_lab1, y_lab2,...
    fignum, limits)

    figure(fignum);

    yyaxis left
    plot(x1, y1);
    xlabel(x_lab);
    ylabel(y_lab1);

    yyaxis right
    plot(x2, y2);
    ylabel(y_lab2);
    
    xlim(limits);
end