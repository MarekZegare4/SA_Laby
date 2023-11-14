% --- Całkujący ---
Ti = 1.3e-3
sTi = tf([1],[Ti 0])

% ------------------------------ A ------------------------------
k1 = [0.35 0.7 1.05 2.62]*4;
k1 = 0.47 + k1 / 2;
r2 = tf([1.042],[2.838e-7 0.0007181 1]);
figure(1)
bode(feedback(r2*k1(1)*sTi,1), feedback(r2*k1(2)*sTi,1), feedback(r2*k1(3)*sTi,1), feedback(r2*k1(4)*sTi,1))
legend("k=0,645","k=0,82","k=0,995")

figure(2)
nyquist(feedback(r2*k1(1)*sTi,1), feedback(r2*k1(2)*sTi,1), feedback(r2*k1(3)*sTi,1))
grid on;
legend("k=0,645","k=0,82","k=0,995")

figure(3)
rlocus(feedback(r2*k1(1)*sTi,1), feedback(r2*k1(2)*sTi,1), feedback(r2*k1(3)*sTi,1), feedback(r2*k1(4)*sTi,1))
legend("kc=0.35","kc=0.7","kc=1.05", "k=kgr=1,78")

% Poniżej wpisz swoje dane
Vout1 = [0.966 1.06 0.934 0.447 0.224 0.024; 1.04 1.07 1.47 0.647 0.284 0.03; 1.04 1.11 2.36 0.97 0.334 0.0388];
phas1 = [-3.6 -57 -139.6 -190 -214 -246.6; -3.6 -27 -133 -196 -215.2 -242; -2.16 -19.8 -111.7 -194.4 -217.7 -246.6];
freq1 = [10 150 300 400 500 1000; 10 100 300 400 500 1000; 10 100 300 400 500 1000];
freq1 = 2*pi*freq1;

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs1 = 2*pi*((10:0.05:1000));

[mag11, phase11, wout11] = bode(feedback(r2*k1(1)*sTi, 1), Fs1);
[mag21, phase21, wout21] = bode(feedback(r2*k1(2)*sTi, 1), Fs1);
[mag31, phase31, wout31] = bode(feedback(r2*k1(3)*sTi, 1), Fs1);

figure(10)
tiledlayout(2,1);
nexttile;
semilogx(Fs1, mag2db(mag11(:)), Fs1, mag2db(mag21(:)), Fs1, mag2db(mag31(:)), freq1(1,:), mag2db(Vout1(1,:)), 'o', freq1(2,:), mag2db(Vout1(2,:)), 'o', freq1(3,:), mag2db(Vout1(3,:)), 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend("k=0,645","k=0,82","k=0,995","k=0,645","k=0,82","k=0,995")
title("Charakterystyki Bodego układu A")

nexttile;
semilogx(Fs1, phase11(:), Fs1, phase21(:), Fs1, phase31(:), freq1(1,:), phas1(1,:), 'o', freq1(2,:), phas1(2,:), 'o', freq1(3,:), phas1(3,:), 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
%fontsize(15,"pixels")
legend("k=0,645","k=0,82","k=0,995","k=0,645","k=0,82","k=0,995")


% % ------------------------------ B ------------------------------
% k2 = [0.1 0.2 0.3];
% k2 = 0.47 + k2 / 2;
% nmin = tf([-0.001431 1],[0.0002309 1])
% figure(4)
% bode(feedback(nmin*k2(1)*sTi,1), feedback(nmin*k2(2)*sTi,1), feedback(nmin*k2(3)*sTi,1))
% 
% figure(5)
% nyquist(feedback(nmin*k2(1)*sTi,1), feedback(nmin*k2(2)*sTi,1), feedback(nmin*k2(3)*sTi,1))
% 
% figure(6)
% rlocus(feedback(nmin*k2(1)*sTi,1), feedback(nmin*k2(2)*sTi,1), feedback(nmin*k2(3)*sTi,1))
% 
% % Poniżej wpisz swoje dane
% Vout2 = [1.07 1.3 2.13 2.79 1.29 0.51; 1.06 1.27 1.92 2.09 1.09 0.452; 1.07 1.32 2.27 3.7 1.48 0.54];
% phas2 = [-3.6 -41.4 -86.2 -152 -217.8 -263.8; -5.4 -45 -96.48 -160.7 -212.2 -246.6; -5.4 -37.8 -76.32 -147.7 -220.4 -260.2];
% freq2 = [10 100 200 300 500 1000; 10 100 200 300 500 1000; 10 100 200 300 500 1000];
% freq2 = 2*pi*freq2;
% 
% % W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
% Fs2 = 2*pi*((10:0.05:1000));
% 
% [mag12, phase12, wout12] = bode(feedback(nmin*k2(1)*sTi,1), Fs2);
% [mag22, phase22, wout22] = bode(feedback(nmin*k2(2)*sTi,1), Fs2);
% [mag32, phase32, wout32] = bode(feedback(nmin*k2(3)*sTi,1), Fs2);
% figure(11)
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs2, mag2db(mag12(:)), Fs2, mag2db(mag22(:)), Fs2, mag2db(mag32(:)), freq2(1,:), mag2db(Vout2(1,:)), 'o', freq2(2,:), mag2db(Vout2(2,:)), 'o', freq2(3,:), mag2db(Vout2(3,:)), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend()
% title("Charakterystyki Bodego układu B")
% 
% nexttile;
% semilogx(Fs2, phase12(:) - 360, Fs2, phase22(:) - 360, Fs2, phase32(:) - 360, freq2(1,:), phas2(1,:), 'o', freq2(2,:), phas2(2,:), 'o', freq2(3,:), phas2(3,:), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% %fontsize(15,"pixels")
% legend()
% 
% 
% % ------------------------------ D ------------------------------
% k3 = [0.8 1.4 2];
% k3 = 0.47 + k3 / 2;
% r1 = tf([1079],[1 733.3]);
% figure(7)
% bode(feedback(r1*k3(1),1), feedback(r1*k3(2),1), feedback(r1*k3(3),1))
% 
% figure(8)
% nyquist(r1*k3(1), r1*k3(2), r1*k3(3))
% 
% figure(9)
% rlocus(r1*k3(1), r1*k3(2), r1*k3(3))
% 
% Vout3 = [0.484 0.412 0.352 0.264 0.184 0.0756; 0.564 0.496 0.436 0.338 0.242 0.104; 0.62 0.556 0.508 0.408 0.294 0.130];
% phas3 = [-2.16 -32.4 -46.63 -59.4 -73.44 -87.84; -5.4 -27.36 -41.2 -52.2 -70.56 -87.84; -3.6 -24.48 -41.2 -52.2 -67.68 -87.84];
% freq3 = [10 200 300 500 800 2000; 10 200 300 500 800 2000; 10 200 300 500 800 2000];
% freq3 = 2*pi*freq3;
% % W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
% Fs3 = 2*pi*((10:0.05:2000));
% 
% [mag13, phase13, wout13] = bode(feedback(r1*k3(1),1), Fs3);
% [mag23, phase23, wout23] = bode(feedback(r1*k3(2),1), Fs3);
% [mag33, phase33, wout33] = bode(feedback(r1*k3(3),1), Fs3);
% 
% figure(12)
% tiledlayout(2,1);
% nexttile;
% semilogx(Fs3, mag2db(mag13(:)), Fs3, mag2db(mag23(:)), Fs3, mag2db(mag33(:)), freq3(1,:), mag2db(Vout3(1,:)), 'o', freq3(2,:), mag2db(Vout3(2,:)), 'o', freq3(3,:), mag2db(Vout3(3,:)), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Amplituda [dB]")
% legend()
% title("Charakterystyki Bodego układu D")
% 
% nexttile;
% semilogx(Fs3, phase13(:), Fs3, phase23(:), Fs3, phase33(:), freq3(1,:), phas3(1,:), 'o', freq3(2,:), phas3(2,:), 'o', freq3(3,:), phas3(3,:), 'o');
% grid on;
% xlabel("Pulsacja [rad/s]")
% ylabel("Faza [°]")
% %fontsize(15,"pixels")
% legend()
