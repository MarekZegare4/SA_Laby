% obiekt drugiego rzędu
global T Y;

data = csvread("NewFile12.csv",2,0);
Ts = (0:5e-7:10*100*5e-6)
T = (0:5e-06*100:10*100*5e-06);
Y = data(200:100:1200, 2)
Y = data(200:100:1200, 2) + abs(Y(1))

Xo = [1 1];
X = fminsearch('rank2', Xo);
Ls = [1];
Ms = [X(1) X(2) 1];

Ys = step(Ls, Ms, Ts);

plot(Ts, Ys, T, Y, 'x')
grid on;
disp(Ls);
disp(Ms)
roots(Ls)
roots(Ms)
tf([Ls],[Ms])
createfigure_2_rzad(Ts, Ys, T, Y)