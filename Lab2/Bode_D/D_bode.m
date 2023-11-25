% Obiekt pierwszego rzędu - minimalizacja Bode

global Y1 Y2 Y3 F1 F2 F3 P1 P2 P3 Z1 Z2 Z3 Ms;

% Poniżej wpisz swoje dane
% Vout = [0.484 0.412 0.352 0.264 0.184 0.0756; 0.564 0.496 0.436 0.338 0.242 0.104; 0.62 0.556 0.508 0.408 0.294 0.130];
% phas = [-2.16 -32.4 -46.63 -59.4 -73.44 -87.84; -5.4 -27.36 -41.2 -52.2 -70.56 -87.84; -3.6 -24.48 -41.2 -52.2 -67.68 -87.84];
% freq = [10 200 300 500 800 2000; 10 200 300 500 800 2000; 10 200 300 500 800 2000];
Vout = [0.616 0.504 0.424 0.308 0.212 0.091; 0.672 0.572 0.496 0.374 0.26 0.113; 0.716 0.624 0.556 0.432 0.308 0.135];
phas = [-1.8 -33.12 -45 -59.4 -70.56 -84.96; -1.8 -30.24 -42.29 -55.8 -67.68 -84.96; -1.8 -27.36 -36.43 -52.2 -64.8 -84.96];
freq = [10 200 300 500 800 2000; 10 200 300 500 800 2000; 10 200 300 500 800 2000];
freq = 2*pi*freq;
% zamiana amplitudy i fazy na liczby zespolone
zesp1 = Vout(1,:) .* exp(1i*deg2rad(phas(1,:))); 
zesp2 = Vout(2,:) .* exp(1i*deg2rad(phas(2,:))); 
zesp3 = Vout(3,:) .* exp(1i*deg2rad(phas(3,:))); 
Z1 = zesp1;
Z2 = zesp2;
Z3 = zesp3;

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((10:0.05:2000));

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
Xo1 = [1 1 1963];
Xo2 = [1 1 1963];
Xo3 = [1 1 1963];

Ms = ([0.002354 1])
k = [1 1.5 2];
k = 0.47 +k/2

X1 = fminsearch('D_bode_f_A', Xo1);
Ls1 = [X1(1)];
Ms1 = [X1(2) X1(3)];
%Tf1 = feedback(tf([Ls1],[Ms]), 1);
Tf1 = feedback(k(1)*tf([1091],[1 745.5]), 1);

X2 = fminsearch('D_bode_f_B', Xo2);
Ls2 = [X2(1)];
Ms2 = [X2(2) X2(3)];
%Tf2 = feedback(tf([Ls2],[Ms]), 1);
Tf2 = feedback(k(2)*tf([1091],[1 745.5]), 1);

X3 = fminsearch('D_bode_f_C', Xo3);
Ls3 = [X3(1)];
Ms3 = [X3(2) X3(3)];
%Tf3 =  feedback(tf([Ls3],[Ms]), 1);
Tf3 = feedback(k(3)*tf([1091],[1 745.5]), 1);

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
title("Charakterystyki Bodego układu D")

nexttile;
semilogx(Fs, phase1(:), Fs, phase2(:), Fs, phase3(:), F1, P1, 'o', F2, P2, 'o', F3, P3, 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
fontsize(15,"pixels")
legend()


tf(Tf1)
tf(Tf2)
tf(Tf3)

