% obiekt pierwszego rzędu
global T Y_i;

data = csvread("NewFile6.csv",2,0);
Ts = (0:1e-7:10*70*5e-6);
T = (0:5e-06*70:10*70*5e-6)
Y_i = data(442:70:1200, 2)
Y_i = data(442:70:1200, 2) %+ abs(Y_i(1))



Xo = [1.1 1 0.1];
X_i = fminsearch('niemin_f', Xo);
Ls = [X_i(1)*X_i(3) 1*X_i(3)];
Ms = [X_i(2) 1];

Ys = step(Ls, Ms, Ts);

plot(Ts, Ys, T, Y_i, 'x')
grid on;
disp(Ls);
disp(Ms)
tf([Ls],[Ms])
