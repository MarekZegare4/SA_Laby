% Obiekt drugiego rzędu - minimalizacja Bode

global Y F P Z;

% Poniżej wpisz swoje dane
Vout = [1.04 1.04 1.04 0.992 0.896 0.368 0.0972 0.011];
phas = [-6.73 -12.15 -32.46 -59.14 -74.66 -129.4 -153 -168.1];
freq = [20 40 120 200 250 500 1000 3000];
freq = freq*2*pi

% zamiana amplitudy i fazy na liczby zespolone
zesp = Vout .* exp(1i*deg2rad(phas)); 
Z = zesp

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = (20:0.05:3000);
Fs = 2*pi*Fs

F = freq;
Y = Vout;
P = phas;

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo = [1 0.00005 0.01];

X = fminsearch('rank2_bode', Xo);
Ls = [X(1)];
Ms = [X(2) X(3) 1];

[mag, phase, wout] = bode(Ls, Ms, Fs);

tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag), F, mag2db(Y), 'x');
grid on;

nexttile;
semilogx(Fs, phase, F, P, 'x');
grid on;

disp(Ls)
disp(Ms)
roots(Ls)
roots(Ms)
tf(Ls,Ms)

