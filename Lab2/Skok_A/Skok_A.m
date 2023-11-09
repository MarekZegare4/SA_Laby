% obiekt drugiego rzędu
global T1 Y1 T2 Y2 T3 Y3;

data1 = csvread("NewFile12.csv",2,0);
data2 = csvread("NewFile13.csv",2,0);
data3 = csvread("NewFile14.csv",2,0);

increment1 = 2e-5
increment2 = 2e-5
increment3 = 5e-5

Ts1 = (0:increment1/10:10*100*increment1);
T1 = (0:increment1*100:10*100*increment1);
Y1 = data1(195:100:1200, 2);
Y1 = data1(195:100:1200, 2) + abs(Y1(1));

Ts2 = (0:increment2/10:10*100*increment2);
T2 = (0:increment2*100:10*100*increment2);
Y2 = data2(195:100:1200, 2);
Y2 = data2(195:100:1200, 2) + abs(Y2(1));

Ts3 = (0:increment3/10:9*80*increment3);
T3 = (0:increment3*80:9*80*increment3);
Y3 = data3(435:80:1200, 2);
Y3 = data3(435:80:1200, 2) + abs(Y3(1));

Xo1 = [1 1e-9 1e-6 1e-3 1];
X1 = fminsearch('Skok_A_f_1', Xo1);
Ls1 = [X1(1)];
Ms1 = [X1(2) X1(3) X1(4) X1(5)];

Xo2 = [1 1e-9 1e-6 1e-3 1];
X2 = fminsearch('Skok_A_f_2', Xo2);
Ls2 = [X2(1)];
Ms2 = [X2(2) X2(3) X2(4) X2(5)];

Xo3 = [1 1e-9 1e-6 1e-3 1];
X3 = fminsearch('Skok_A_f_3', Xo3);
Ls3 = [X3(1)];
Ms3 = [X3(2) X3(3) X3(4) X3(5)];

Ys1 = step(Ls1, Ms1, Ts1);
Ys2 = step(Ls2, Ms2, Ts2);
Ys3 = step(Ls3, Ms3, Ts3);

plot(Ts1, Ys1, Ts2, Ys2, Ts3, Ys3, T1, Y1, 'x', T2, Y2, 'x', T3, Y3, 'x')
grid on;

Tf1 = tf([Ls1],[Ms1])
Tf2 = tf([Ls2], [Ms2])
Tf3 = tf([Ls3], [Ms3])