% Program to process data from a PQ box.

clear
close all

% Filenames
DC_data = 'transformer_currents.csv';
even_harmonic_data = 'even_harmonics.csv';
odd_harmonic_data = 'odd_harmonics.csv';
Q_data = 'reactive_power.csv';

% Observation period
start_date = datetime("21/01/2023");
end_date = datetime("30/01/2023");

% Other variables
date_format = "dd/MM/uuuu HH:mm:ss";

% Import data into MATLAB
DC = readtable(DC_data, "VariableNamingRule","preserve");
H_EVEN = readtable(even_harmonic_data, "VariableNamingRule","preserve");
H_ODD = readtable(odd_harmonic_data, "VariableNamingRule","preserve");
Q = readtable(Q_data, "VariableNamingRule","preserve");

% Format dates
H_EVEN.DateTime = H_EVEN.Date + H_EVEN.Time;
H_ODD.DateTime = H_ODD.Date + H_ODD.Time;
Q.DateTime = Q.Date + Q.Time;

H_EVEN.DateTime.Format = date_format;
H_ODD.DateTime.Format = date_format;
Q.DateTime.Format = date_format;

% Calculate Even THD
even_THD = calc_THD(H_EVEN);
H_EVEN.Even_THD = even_THD;

% Calculate Odd THD
odd_THD = calc_THD(H_ODD);
H_ODD.Odd_THD = odd_THD; 

% Calculate total reactive power
Q_tot = Q.("'Q_total_[Var]'");

% Plot data
figure(1);

x_var_name = "Time";
y_var_names = {'DC Neutral Current (A)', 'Even Current THD (%)',...
    'Reactive Power (MVAr)'};

x_vars = {DC.time3, H_EVEN.DateTime, Q.DateTime};
y_vars = {DC.HAY_T1_NCT, H_EVEN.Even_THD, Q_tot/10^6};

limits = [start_date end_date];

plot_data(x_vars, y_vars, x_var_name, y_var_names, limits);

% Plot DC current and THD on the same window.
figure(2);

plot_multi(DC.time3, H_EVEN.DateTime, DC.HAY_T1_NCT, H_EVEN.Even_THD,...
    "Time", "HAY T1 LEM Current (A)", "Even THD (%)", 2, limits);

% Plot individual harmonics and DC current on the same window.
figure(3);

plot(H_EVEN.DateTime ,H_EVEN.("'H2_I1_[A]'"), H_EVEN.DateTime, H_EVEN.("'H4_I1_[A]'"),...
    H_EVEN.DateTime, H_EVEN.("'H6_I1_[A]'"), H_EVEN.DateTime, H_EVEN.("'H8_I1_[A]'"),...
    H_EVEN.DateTime, H_EVEN.("'H10_I1_[A]'"));

xlabel(x_var_name);
ylabel("Harmonic Current Phase A (A)");
xlim(limits);

legend("H2", "H4", "H6", "H8", "H10");

% Plot DC current versus individual harmonics.
figure(4);

X = DC.HAY_T1_NCT;

Y1 = interp1(H_EVEN.DateTime, H_EVEN.("'H2_I1_[A]'"), DC.time3);
Y2 = interp1(H_EVEN.DateTime, H_EVEN.("'H4_I1_[A]'"), DC.time3);
Y3 = interp1(H_EVEN.DateTime, H_EVEN.("'H6_I1_[A]'"), DC.time3);
Y4 = interp1(H_EVEN.DateTime, H_EVEN.("'H8_I1_[A]'"), DC.time3);
Y5 = interp1(H_EVEN.DateTime, H_EVEN.("'H10_I1_[A]'"), DC.time3);

% Remove NaN
X(any(isnan(X),2),:) = [];
Y1(any(isnan(Y1),2),:) = [];
Y2(any(isnan(Y2),2),:) = [];
Y3(any(isnan(Y3),2),:) = [];
Y4(any(isnan(Y4),2),:) = [];
Y5(any(isnan(Y5),2),:) = [];

x_vars = {X, X, X, X, X};
y_vars = {Y1, Y2, Y3, Y4, Y5};
y_varnames = ["H2 Phase A (A)", "H4 Phase A (A)", "H6 Phase A (A)", "H8 Phase A (A)", "H10 Phase A (A)"];

plot_scatter(x_vars,y_vars,"Neutral Current (A)", y_varnames, [-20 40])







