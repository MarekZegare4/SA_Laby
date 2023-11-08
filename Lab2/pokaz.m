r1 = tf([2.48],[0.00224 1]);
r12 = tf([2.483],[0.002249 1]);
r1bode = tf([2.644],[0.002354 1]);
AVout = [2.5 2.29 1.98 1.74 0.846 0.222];
Aphas = [-16.33 -32.91 -40.45 -48.92 -73.34 -84.04];
Afreq = [20 40 60 80 200 800];

r1to = tf([2.48],[0.00224 1], 'InputDelay', 210e-6);
r12to = tf([2.553],[0.002368 1], 'InputDelay', 277e-6);
r1tobode = tf([2.799],[0.002585 1], 'InputDelay', 178e-6);
BVout = [2.56 2.32 2.01 1.93 1.28 0.84 0.222 0.11];
Bphas = [-18.63 -34.05 -45.21 -48.91 -71.57 -85.3 -139.6 -192.2];
Bfreq = [20 40 60 80 120 200 800 1600];

r2 = tf([1],[2.392e-7 0.0006403 1]);
r21 = tf([1],[0.487e-6, 0.6983e-3 1])
r2bode = tf([1.042],[2.838e-7 0.0007181 1]);
CVout = [1.04 1.04 1.04 0.992 0.896 0.368 0.0972 0.011];
Cphas = [-6.73 -12.15 -32.46 -59.14 -74.66 -129.4 -153 -168.1];
Cfreq = [20 40 120 200 250 500 1000 3000];

nmin = tf([-0.001178 0.5932],[0.0002266 1]);
nminbode = tf([-0.001431 1],[0.0002309 1]);
DVout = [1.1 1.11 1.38 1.71 2.08 5.88 6.16];
Dphas = [-8.14 -21.47 -48.6 -63.64 -73.8 -157.9 -175.6];
Dfreq = [20 40 100 150 200 2000 10000];

A = tf([7.201e9],[1 2727 5.465e6 7.098e9])
A1 = tf([5.528e9],[1 2839 5.566e6 5.542e9])
EVout = [0.966 1.06 0.934 0.447 0.224 0.024];
Ephas = [-3.6 -57 -139.6 -190 -214 -246.6];
Efreq = [10 150 300 400 500 1000];

% % 1 RZAD
% data = csvread("NewFile3.csv",2,0);
% Ts = (0:1e-6:11*100*2e-5)
% T = (0:2e-5*100:11*100*2e-5);
% Y_i = data(100:100:1200, 2)
% Y_i = data(100:100:1200, 2) + abs(Y_i(1))
% 
% [y1, tout1] = step(r1, Ts)
% [y2, tout2] = step(r12, Ts)
% [y3, tout3] = step(r1bode, Ts)
% 
% plot(Ts, y1(:), Ts, y2(:), Ts, y3(:), T, Y_i, 'o')
% xlabel("Czas [s]")
% ylabel("Amplituda [V]")
% title("Odpowiedzi skokowe modeli układu I rzędu z opóźnieniem transportowym")
% legend("model wz. A","model wz. B", "model wz. C", "punkty pomiarowe")
% grid on;

% % 1 RZAD BODE
% Fs = 2*pi*((20:0.05:800));
% [mag1, phase1, wout1] = bode(r1, Fs);
% [mag2, phase2, wout2] = bode(r12, Fs);
% [mag3, phase3, wout3] = bode(r1bode, Fs);
% 
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Fs, mag2db(mag3(:)), Afreq*2*pi, mag2db(AVout), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend("model wz. A","model wz. B", "model wz. C", "punkty pomiarowe")
% title("Charakterystyka Bodego układu I rzędu")
% 
% nexttile;
% semilogx(Fs, phase1(:), Fs, phase2(:), Fs, phase3(:), Afreq*2*pi, Aphas, 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% fontsize(15,"pixels")
% legend("model wz. A","model wz. B", "model wz. C", "punkty pomiarowe")


% % 1 RZAD Z To
% data = csvread("NewFile4.csv",2,0);
% Ts = (0:1e-6:26*45*5e-6);
% T =(96*5e-6:45*5e-6:27*45*5e-6)
% Y_i = data(96:45:1200, 2);
% Y_i = data(96:45:1200, 2) + abs(Y_i(1));
% Y_i = abs(Y_i)
% 
% [y1, tout1] = step(r1to, Ts)
% [y2, tout2] = step(r12to, Ts)
% [y3, tout3] = step(r1tobode, Ts)
% 
% plot(Ts, y1(:), Ts, y2(:), Ts, y3(:), T, Y_i, 'o')
% xlabel("Czas [s]")
% ylabel("Amplituda [V]")
% title("Odpowiedzi skokowe modeli układu I rzędu z opóźnieniem transportowym")
% legend("model wz. D","model wz. E", "model wz. F", "punkty pomiarowe")
% grid on;


% % 1 RZAD Z To BODE
% Fs = 2*pi*((20:0.05:1600));
% [mag1, phase1, wout1] = bode(r1to, Fs);
% [mag2, phase2, wout2] = bode(r12to, Fs);
% [mag3, phase3, wout3] = bode(r1tobode, Fs);
% 
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Fs, mag2db(mag3(:)), Bfreq*2*pi, mag2db(BVout), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend("model wz. D","model wz. E", "model wz. F", "punkty pomiarowe")
% title("Charakterystyki Bodego modeli układu I rzędu z opóźnieniem transportowym")
% 
% nexttile;
% semilogx(Fs, phase1(:), Fs, phase2(:), Fs, phase3(:), Bfreq*2*pi, Bphas, 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% fontsize(15,"pixels")
% legend("model wz. D","model wz. E", "model wz. F", "punkty pomiarowe")


% % 2 RZAD
% data = csvread("NewFile5.csv",2,0);
% Ts = (0:5e-7:10*100*5e-6)
% T = (0:5e-06*100:10*100*5e-06);
% Y = data(200:100:1200, 2)
% Y = data(200:100:1200, 2) + abs(Y(1))
% 
% [y1, tout1] = step(r21, Ts)
% [y2, tout2] = step(r2, Ts)
% [y3, tout3] = step(r2bode, Ts)
% 
% plot(Ts, y1(:), Ts, y2(:), Ts, y3(:), T, Y, 'o')
% xlabel("Czas [s]")
% ylabel("Amplituda [V]")
% title("Odpowiedzi skokowe modeli układu II rzędu")
% legend("model wz. G","model wz. H", "model wz. I", "punkty pomiarowe")
% grid on;

% 
% % 2 RZAD BODE
% Fs = 2*pi*(20:0.05:3000);
% [mag1, phase1, wout1] = bode(r21, Fs);
% [mag2, phase2, wout2] = bode(r2, Fs);
% [mag3, phase3, wout3] = bode(r2bode, Fs);
% 
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Fs, mag2db(mag3(:)), Cfreq*2*pi, mag2db(CVout), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend("model wz. G","model wz. H", "model wz. I", "punkty pomiarowe")
% title("Charakterystyki Bodego modeli układu II rzędu")
% 
% nexttile;
% semilogx(Fs, phase1(:), Fs, phase2(:), Fs, phase3(:), Cfreq*2*pi, Cphas, 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% fontsize(15,"pixels")
% legend("model wz. G","model wz. H", "model wz. I", "punkty pomiarowe")


% % NIEMINIMALNOFAZOWE
% data = csvread("NewFile6.csv",2,0);
% Ts = (0:1e-7:10*70*5e-6);
% T = (0:5e-06*70:10*70*5e-6)
% Y = data(442:70:1200, 2)
% Y = data(442:70:1200, 2) %+ abs(Y_i(1))
% 
% [y1, tout1] = step(nmin, Ts)
% [y2, tout2] = step(nminbode, Ts)
% 
% plot(Ts, y1(:), Ts, y2(:), T, Y, 'o')
% xlabel("Czas [s]")
% ylabel("Amplituda [V]")
% title("Odpowiedzi skokowe modeli członu nieminilanofazowego")
% legend("model wz. J","model wz. K", "punkty pomiarowe")
% grid on;


% %2 NIEMINIMALNOFAZOWE BODE
% Fs = 2*pi*(20:0.05:10000);
% [mag1, phase1, wout1] = bode(nmin, Fs);
% [mag2, phase2, wout2] = bode(nminbode, Fs);
% 
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Dfreq*2*pi, mag2db(DVout), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend("model wz. J","model wz. K", "punkty pomiarowe")
% title("Charakterystyki Bodego modeli członu nieminimalnofazowego")
% 
% nexttile;
% semilogx(Fs, phase1(:) - 360, Fs, phase2(:) - 360, Dfreq*2*pi, Dphas, 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% fontsize(15,"pixels")
% legend("model wz. J","model wz. K", "punkty pomiarowe")

%2 BODE A
Fs = 2*pi*(10:0.05:1000);
[mag1, phase1, wout1] = bode(A1, Fs);
[mag2, phase2, wout2] = bode(A, Fs);

tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Efreq*2*pi, mag2db(EVout), 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend("bode", "skokowa")
title("3 rzad")

nexttile;
semilogx(Fs, phase1(:), Fs, phase2(:), Efreq*2*pi, Ephas, 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
fontsize(15,"pixels")
legend("bode", "skokowa")
