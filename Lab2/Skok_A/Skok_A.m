% obiekt drugiego rzędu
global T1 Y1 T2 Y2 T3 Y3;

data1 = csvread("NewFile12.csv",2,0);
data2 = csvread("NewFile13.csv",2,0);
data3 = csvread("NewFile14.csv",2,0);

increment1 = 2e-5
increment2 = 2e-5
increment3 = 5e-5

Ts1 = (0:increment1/10:10*50*increment3);
T1 = (0:increment1*100:10*100*increment1);
Y1 = data1(195:100:1200, 2);
Y1 = data1(195:100:1200, 2) + abs(Y1(1));

Ts2 = (0:increment2/10:10*50*increment3);
T2 = (0:increment2*100:10*100*increment2);
Y2 = data2(195:100:1200, 2);
Y2 = data2(195:100:1200, 2) + abs(Y2(1));

Ts3 = (0:increment3/10:9*50*increment3);
T3 = (0:increment3*50:9*50*increment3)
Y3 = data3(435:50:900, 2);
Y3 = data3(435:50:900, 2) + abs(Y3(1))

Xo1 = [1 1e-9 1e-6 1e-3 1];
X1 = fminsearch('Skok_A_f_1', Xo1);
Ls1 = [X1(1)];
Ms1 = [X1(2) X1(3) X1(4) X1(5)];

Xo2 = [1 1e-9 1e-6 1e-3 1];
X2 = fminsearch('Skok_A_f_2', Xo2);
Ls2 = [X2(1)];
Ms2 = [X2(2) X2(3) X2(4) X2(5)];

Xo3 = [1 1.0440e-10 3.1110e-07 6.0194e-04 1];
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

a1 = 2.392e-7;
a2 = 6.403e-4;
Ti = 1.3e-3;
k=[0.35 0.7 1.05];
k = 0.47 +k/2;

wzm_petl =[X1(5)/X1(1) ,X2(5)/X2(1),X3(5)/X3(1)]
Ti_n = [X1(4), X2(4), X3(4)]
a1_n = [X1(2)/X1(4) X2(2)/X2(4) X3(2)/X3(4)]
a2_n = [X1(3)/X1(4) X2(3)/X2(4) X3(3)/X3(4)]
k2_n = [X1(1) X2(1) X3(1)]./k

wzm_petlm = mean(wzm_petl);
Tin = mean(Ti_n);
a1n = mean(a1_n);
a2n = mean(a2_n);
k2n = mean(k2_n);

% figure(4)
% tiledlayout(5,1);
% nexttile;
% plot(k,wzm_petl,'o')
% nexttile;
% plot(k,Ti_n,'x')
% nexttile;
% plot(k,a1_n,'s')
% nexttile;
% plot(k,a2_n,'+')
% nexttile;
% plot(k,k2_n, 'o')

kloc1 = tf(k(1)*k2_n(1),[Ti_n(1)*a1_n(1) Ti_n(1)*a2_n(1) Ti_n(1) 0 ]);
kloc1 = feedback(kloc1,wzm_petl(1))

srednia(1) = tf(k(1)*k2n(1),[Tin(1)*a1n(1) Tin(1)*a2n(1) Tin(1) 0 ]);
srednia(2) = tf(k(2)*k2n(1),[Tin(1)*a1n(1) Tin(1)*a2n(1) Tin(1) 0 ]);
srednia(3) = tf(k(3)*k2n(1),[Tin(1)*a1n(1) Tin(1)*a2n(1) Tin(1) 0 ]);

srednia(1) = minreal(feedback(srednia(1),wzm_petlm));
srednia(2) = minreal(feedback(srednia(2),wzm_petlm));
srednia(3) = minreal(feedback(srednia(3),wzm_petlm));

figure(6)
step(srednia(1), srednia(2), srednia(3), Tf1, Tf2, Tf3)

