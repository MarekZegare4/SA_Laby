
global Y1 Y2 Y3 F1 F2 F3 P1 P2 P3 Z1 Z2 Z3;

% Poniżej wpisz swoje dane
Vout = [1.07 1.3 2.13 2.79 1.29 0.51; 1.06 1.27 1.92 2.09 1.09 0.452; 1.07 1.32 2.27 3.7 1.48 0.54];
phas = [-3.6 -41.4 -86.2 -152 -217.8 -263.8; -5.4 -45 -96.48 -160.7 -212.2 -246.6; -5.4 -37.8 -76.32 -147.7 -220.4 -260.2];
freq = [10 100 200 300 500 1000; 10 100 200 300 500 1000; 10 100 200 300 500 1000];
freq = 2*pi*freq;
% zamiana amplitudy i fazy na liczby zespolone
zesp1 = Vout(1,:) .* exp(1i*deg2rad(phas(1,:))); 
zesp2 = Vout(2,:) .* exp(1i*deg2rad(phas(2,:))); 
zesp3 = Vout(3,:) .* exp(1i*deg2rad(phas(3,:))); 
Z1 = zesp1;
Z2 = zesp2;
Z3 = zesp3;

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((10:0.05:1000));

F1 = freq(1,:);
Y1 = Vout(1,:);
P1 = phas(1,:);

F2 = freq(2,:);
Y2 = Vout(2,:);
P2 = phas(2,:);

F3 = freq(3,:);
Y3 = Vout(3,:);
P3 = phas(3,:);

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo1 = [-2760 3.326e6 1 1236 3.392e6];
Xo2 = [-2760 3.326e6 1 1236 3.392e6];
Xo3 = [-2760 3.326e6 1 1236 3.392e6];

% [-0.001431 1],[0.0002309 1]

X1 = fminsearch('test_f', Xo1);
Ls1 = [X1(1) X1(2)];
Ms1 = [X1(3) X1(4) 0];
%Ls1 = [X1(1)];
%Ms1 = [X1(2) X1(3) X1(4) 0];
Tf1_open = tf([Ls1],[Ms1])
Tf1 = feedback(Tf1_open, 1);

X2 = fminsearch('test_f_2', Xo2);
Ls2 = [X2(1)*(-0.001431) X2(1)];
Ms2 = [X2(2)*13e-3*0.0002309 X2(2)*13e-3 0];
Tf2_open = tf([Ls2],[Ms2])
Tf2 = feedback(Tf2_open, 1);

X3 = fminsearch('B_bode_f_C', Xo3);
Ls3 = [X3(1) X3(2)];
Ms3 = [X3(3) X3(4) X3(5)];
Tf3 = tf([Ls3],[Ms3]);

[mag1, phase1, wout1] = bode(Tf1, Fs);
[mag2, phase2, wout2] = bode(Tf2, Fs);
[mag3, phase3, wout3] = bode(Tf3, Fs);

tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Fs, mag2db(mag3(:)), F1, mag2db(Y1), 'o', F2, mag2db(Y2), 'o', F3, mag2db(Y3), 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend()
title("Charakterystyki Bodego układu B")

nexttile;
semilogx(Fs, phase1(:) - 360, Fs, phase2(:) - 360, Fs, phase3(:) - 360, F1, P1, 'o', F2, P2, 'o', F3, P3, 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
fontsize(15,"pixels")
legend()


tf(Tf1)
Ps2 = tf(Tf2)
Gs = Ps2/(1 - Ps2);
Gs = minreal(Gs)
tf(Tf3)


