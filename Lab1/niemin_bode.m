% Obiekt pierwszego rzędu - minimalizacja Bode

global Y_b F P Z;

% Poniżej wpisz swoje dane
Vout = [1.1 1.11 1.38 1.71 2.08 5.88 6.16];
phas = [-8.14 -21.47 -48.6 -63.64 -73.8 -157.9 -175.6];
freq = [20 40 100 150 200 2000 10000];
freq = freq*2*pi;

% zamiana amplitudy i fazy na liczby zespolone
zesp = Vout .* exp(1i*deg2rad(phas)); 
Z = zesp;

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = (20:0.05:10000);
Fs = Fs*2*pi;

F = freq;
Y_b = Vout;
P = phas;

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo = [1.1 1 1];

X_b = fminsearch('niemin_f_bode', Xo);
Ls = [X_b(1)*X_b(3) X_b(3)];
Ms = [X_b(2) 1];


[mag, phase, wout] = bode(Ls, Ms, Fs);

tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag), F, mag2db(Y_b), 'x');
grid on;

nexttile;
semilogx(Fs, phase -360, F, P, 'x');
grid on;

disp(Ls)
disp(Ms)

roots(Ls)
roots(Ms)
tf([Ls],[Ms])

