% obiekt pierwszego rzędu
global T Y_i;
global Y_b F P Z;

data = csvread("NewFile3.csv",2,0);
Ts_i = (0:0.05:11)
T = (0:1:11);
Y_i = data(100:100:1200, 2)
Y_i = data(100:100:1200, 2) + abs(Y_i(1))

Xo_i = [1.1 1];
X_i = fminsearch('rank1', Xo_i);
Ls_i = [X_i(1)];
Ms_i = [X_i(2) 1];

Ys_i = step(Ls_i, Ms_i, Ts_i);

% Poniżej wpisz swoje dane
Vout = [2.5 2.29 1.98 1.74 0.846 0.222];
phas = [-16.33 -32.91 -40.45 -48.92 -73.34 -84.04];
freq = deg2rad([20 40 60 80 200 800]);

% zamiana amplitudy i fazy na liczby zespolone
zesp = Vout .* exp(1i*deg2rad(phas)); 
Z = zesp

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs_b = (20:0.05:2000);

F = freq;
Y_b = Vout;
P = phas;

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo_b = [0.9 1];

X_b = fminsearch('rank1_bode', Xo_b);
Ls_b = [X_b(1)];
Ms_b = [X_b(2) 1];

[mag, phase, wout] = bode(Ls_b, Ms_b, Fs_b);

%aa = step(Ls_i, Ms_i, Ts_i)
%bb = step(Ls_b, Ms_b, Ts_i)

%plot(Ts_i, aa, Ts_i, bb)

bodeplot(tf(Ls_i, Ms_i))
hold on;
bodeplot(tf(Ls_b, Ms_b))
hold off;
disp(Ls_i);
disp(Ms_i);

roots(Ls_i);
roots(Ms_i);

disp(Ls_b);
disp(Ms_b);

roots(Ls_b);
roots(Ms_b);





