

global Y_b F P Z;

% Poniżej wpisz swoje dane
Vout = [2.56 2.32 2.01 1.93 1.28 0.84 0.222 0.11];
phas = [-18.63 -34.05 -45.21 -48.91 -71.57 -85.3 -139.6 -192.2];
freq = [20 40 60 80 120 200 800 1600];
freq = 2*pi*freq
% zamiana amplitudy i fazy na liczby zespolonerank1
zesp = Vout .* exp(1i*deg2rad(phas)); 
Z = zesp

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((20:0.05:1600));

F = freq;
Y = Vout;
P = phas;

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo = [2.5 0.00235 0.000210];

X_b = fminsearch('rank1_to_bode_f', Xo);
Ls = [X_b(1)];
Ms = [X_b(2) 1];
Tf = tf(Ls, Ms, 'InputDelay', X_b(3))
[mag, phase, wout] = bode(Tf, Fs);
tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag(:)), F, mag2db(Y), 'x');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend("model", "punkty pomiarowe")
title("Charakterystyka Bodego układu I rzędu z opoźnieniem transportowym")

nexttile;
semilogx(Fs, phase(:), F, P, 'x');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
fontsize(14,"pixels")
legend("model", "punkty pomiarowe")
disp(Ls)
disp(Ms)

roots(Ls)
roots(Ms)
tf(Ls, Ms, 'InputDelay', X_b(3))
save("1_b.mat", "X_b")
