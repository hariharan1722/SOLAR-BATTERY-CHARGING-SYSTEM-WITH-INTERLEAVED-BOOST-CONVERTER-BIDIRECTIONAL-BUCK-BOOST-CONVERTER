% Define parameters
Vin = 600; % Input voltage
Vo = 370; % Output voltage
L = 10.92e-3; % Inductance
C = 104e-6; % Capacitance
R = 45.6; % Load resistance
Kp_current = 0.0158; % Current loop proportional gain
Ki_current = 8.96; % Current loop integral gain
Kp_voltage = 0.00206; % Voltage loop proportional gain
Ki_voltage = 0.23; % Voltage loop integral gain
D=0.38;
% Create current PI controller
G_PI_current = tf([Kp_current Ki_current], [1 0]);
% Create voltage PI controller
G_PI_voltage = tf([Kp_voltage Ki_voltage], [1 0]);
% Define converter transfer function
G_id = tf([Vin * (1-D)], [L 0]);
G_vd = tf([Vin * (1-D)], [L*(1-D) + R]);
% Current loop open loop transfer function
G_open_current = G_PI_current * G_id;
% Voltage loop open loop transfer function
G_open_voltage = G_PI_voltage * G_vd;
% Close the loops using feedback
G_closed_current = feedback(G_open_current, 1);
G_closed_voltage = feedback(G_open_voltage, 1);

% Get Gain Margin and Phase Margin
[Gm_current, Pm_current, Wcg_current, Wcp_current] = margin(G_closed_current);
[Gm_voltage, Pm_voltage, Wcg_voltage, Wcp_voltage] = margin(G_closed_voltage);
% Display the results
disp('Current Loop Transfer Function Margins:');
disp(['Gain Margin (dB): ', num2str(20*log10(Gm_current))]);
disp(['Phase Margin (degrees): ', num2str(Pm_current)]);
disp(['Gain Crossover Frequency (rad/s): ', num2str(Wcg_current)]);
disp(['Phase Crossover Frequency (rad/s): ', num2str(Wcp_current)]);

disp('Voltage Loop Transfer Function Margins:');
disp(['Gain Margin (dB): ', num2str(20*log10(Gm_voltage))]);
disp(['Phase Margin (degrees): ', num2str(Pm_voltage)]);
disp(['Gain Crossover Frequency (rad/s): ', num2str(Wcg_voltage)]);
disp(['Phase Crossover Frequency (rad/s): ', num2str(Wcp_voltage)]);

% Root Locus of Closed Loop Current Transfer Function
figure;
rlocus(G_closed_current);
title('Root Locus of Closed Loop Current Transfer Function');

% Root Locus of Closed Loop Voltage Transfer Function
figure;
rlocus(G_closed_voltage);
title('Root Locus of Closed Loop Voltage Transfer Function');


% Run the simulation and observe the results

