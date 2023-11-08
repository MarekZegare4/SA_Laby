% Obiekt pierwszego rzędu - minimalizacja Bode

global Y_b F P Z;

% Poniżej wpisz swoje dane
Vout = [2.5 2.29 1.98 1.74 0.846 0.222];
phas = [-16.33 -32.91 -40.45 -48.92 -73.34 -84.04];
freq = [20 40 60 80 200 800];
freq = 2*pi*freq
% zamiana amplitudy i fazy na liczby zespolone
zesp = Vout .* exp(1i*deg2rad(phas)); 
Z = zesp

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((20:0.05:800));

F = freq;
Y = Vout;
P = phas;

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo = [1.1 1];

X_b = fminsearch('rank1_bode', Xo);
Ls = [X_b(1)];
Ms = [X_b(2) 1];

[mag, phase, wout] = bode(Ls, Ms, Fs);

tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag), F, mag2db(Y), 'x');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend("model", "punkty pomiarowe")
title("Charakterystyka Bodego układu I rzędu")

nexttile;
semilogx(Fs, phase, F, P, 'x');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
fontsize(14,"pixels")
legend("model", "punkty pomiarowe")
disp(Ls)
disp(Ms)

roots(Ls)
roots(Ms)
tf(Ls, Ms)
save("1_b.mat", "X_b")
