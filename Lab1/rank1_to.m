% obiekt pierwszego rzędu
global T Y_i;

data = csvread("NewFile4.csv",2,0);
Ts = (0:1e-6:26*45*5e-6);
T =(96*5e-6:45*5e-6:27*45*5e-6)
%T = [45*5e-6 90*5e-6 135*5e-6 180*5e-6 225*5e-6 270*5e-6 315*5e-6 360*5e-6 405*5e-6 450*5e-6 495*5e-6 540*5e-6]
Y_i = data(96:45:1200, 2);
%Y_i = [0 0.24 0.48 0.64 0.8 0.96 1.12 1.2 1.32 1.48 1.52]
Y_i = data(96:45:1200, 2) + abs(Y_i(1));
Y_i = abs(Y_i)



Xo = [1 0.1 0.000225];
X_i = fminsearch('rank1_to_f', Xo);
Ls = [X_i(1)];
Ms = [X_i(2) 1];
Tf = tf(Ls, Ms, 'InputDelay', X_i(3))
Ys = step(Tf, Ts);

plot(Ts, Ys, T, Y_i, 'o')
%xlabel("Czas [\mus]")
ylabel("Amplituda [V]")
xlabel('Czas [s]')
title('Odpowiedź skokowa układu I rzędu z opoźnieniem transportowym')
legend("model" , "punkty pomiarowe")
fontsize(15, "pixels")
grid on;
disp(Ls);
disp(Ms)
tf([Ls],[Ms], 'InputDelay', X_i(3))
save("1.mat", "X_i")

