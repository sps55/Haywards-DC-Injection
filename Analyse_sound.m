% Program to plot sound pressure data.

file_1 = 'cv_mic_2023_01_28_11_00_00.wav';
file_2 = 'cv_mic_2023_01_28_11_05_00.wav';
file_3 = 'cv_mic_2023_01_28_12_00_00.wav';
file_4 = 'cv_mic_2023_01_28_12_30_00.wav';

[y1, fs] = audioread(file_1);
[y2, fs] = audioread(file_2);
[y3, fs] = audioread(file_3);
[y4, fs] = audioread(file_4);

x = [];

for i = 1:length(y1)
    x = [x, i];
end

x1 = x*1000/fs;

m = 2;
n = 2;
ymax = 1.5;
ymin = -1.5;
xmax = 500;
xmin = 0;

figure(1);

subplot(m, n, 1);
plot(x1,y1);
xlabel('time (ms)');
ylabel('Sound Pressure (Pa)');
title('28/01/23 11:00');
ylim([ymin ymax]);
xlim([xmin xmax]);

subplot(m, n, 2);
plot(x1,y2);
xlabel('time (ms)');
ylabel('Sound Pressure (Pa)');
title('28/01/23 11:05');
ylim([ymin ymax]);
xlim([xmin xmax]);

subplot(m, n, 3);
plot(x1,y3);
xlabel('time (ms)');
ylabel('Sound Pressure (Pa)');
title('28/01/23 12:00');
ylim([ymin ymax]);
xlim([xmin xmax]);

subplot(m, n, 4);
plot(x1,y4);
xlabel('time (ms)');
ylabel('Sound Pressure (Pa)');
title('28/01/23 12:30');
ylim([ymin ymax]);
xlim([xmin xmax]);

% Plot fft of signal

figure(2);

t1 = (x1/1000)';

y11 = timetable(seconds(t1), y1);
y33 = timetable(seconds(t1), y3);

[p1,f] = pspectrum(y11);
[p3,f] = pspectrum(y33);

semilogx(f,pow2db(p1), f, pow2db(p3));
grid on
xlabel('Frequency (Hz)')
ylabel('Power Spectrum (dB)')
legend('28/01/23 11:00', '28/01/23 12:00');

