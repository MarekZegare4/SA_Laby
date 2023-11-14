% obiekt drugiego rzędu
global T1 Y1 T2 Y2 T3 Y3;

data1 = csvread("NewFile18.csv",2,0);
data2 = csvread("NewFile19.csv",2,0);
data3 = csvread("NewFile20.csv",2,0);

increment1 = 2e-5
increment2 = 2e-5
increment3 = 2e-5

Ts1 = (0:increment1/10:10*100*increment1);
T1 = (0:increment1*100:10*100*increment1)
Y1 = data1(195:100:1200, 2)
Y1 = data1(195:100:1200, 2) + abs(Y1(1));

Ts2 = (0:increment2/10:10*100*increment2);
T2 = (0:increment2*100:10*100*increment2)
Y2 = data2(195:100:1200, 2)
Y2 = data2(195:100:1200, 2) + abs(Y2(1));

Ts3 = (0:increment3/10:10*100*increment3);
T3 = (0:increment3*100:10*100*increment3)
Y3 = data3(195:100:1200, 2);
Y3 = data3(195:100:1200, 2) + abs(Y3(1))

Xo1 = [916.8 1 1963];
X1 = fminsearch('Skok_D_f_1', Xo1);
Ls1 = [X1(1)];
Ms1 = [X1(2) X1(3)];

Xo2 = [916.8 1 1963];
X2 = fminsearch('Skok_D_f_2', Xo2);
Ls2 = [X2(1)];
Ms2 = [X2(2) X2(3)];

Xo3 = [916.8 1 1963];
X3 = fminsearch('Skok_D_f_3', Xo3);
Ls3 = [X3(1)];
Ms3 = [X3(2) X3(3)];

Ys1 = step(Ls1, Ms1, Ts1);
Ys2 = step(Ls2, Ms2, Ts2);
Ys3 = step(Ls3, Ms3, Ts3);

plot(Ts1, Ys1, Ts2, Ys2, Ts3, Ys3, T1, Y1, 'x', T2, Y2, 'x', T3, Y3, 'x')
grid on;

Tf1 = tf([Ls1],[Ms1])
Tf2 = tf([Ls2], [Ms2])
Tf3 = tf([Ls3], [Ms3])

k=[0.2  0.1 0.3];
k = 0.47 +k/2;

kc = [X1(1) X2(1) X3(1)];
kp = kc./k;
Tp = [X1(2) X2(2) X3(2)];

kcm = mean(kc);
kpm = mean(kp);
Tpm = mean(Tp);

srednia(1) = tf([kpm*k(1)],[Tpm 1+kcm]);
srednia(2) = tf([kpm*k(2)],[Tpm 1+kcm]);
srednia(3) = tf([kpm*k(3)],[Tpm 1+kcm]);

srednia(1) = minreal(feedback(srednia(1), 1));
srednia(2) = minreal(feedback(srednia(2), 1));
srednia(3) = minreal(feedback(srednia(3), 1));

figure(6)
step(srednia(1), srednia(2),  srednia(3),  Tf1, Tf2, Tf3)
legend()

