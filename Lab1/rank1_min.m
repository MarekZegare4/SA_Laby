% obiekt pierwszego rzędu
global T Y_i;

data = csvread("NewFile3.csv",2,0);
Ts = (0:1e-6:11*100*2e-5)
T = (0:2e-5*100:11*100*2e-5);
Y_i = data(100:100:1200, 2)
Y_i = data(100:100:1200, 2) + abs(Y_i(1))



Xo = [1 1];
X_i = fminsearch('rank1', Xo);
Ls = [X_i(1)];
Ms = [X_i(2) 1];

Ys = step(Ls, Ms, Ts);

plot(Ts, Ys, T, Y_i, 'o')
%xlabel("Czas [\mus]")
ylabel("Amplituda [V]")
fontsize(15, "pixels")
grid on;
disp(Ls);
disp(Ms)
tf([Ls],[Ms])
save("1.mat", "X_i")
createfigure_i_rzad(Ts, Ys, T, Y_i)
