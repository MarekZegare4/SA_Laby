% obiekt drugiego rzędu
global T1 Y1 T2 Y2 T3 Y3;

data1 = csvread("NewFile15.csv",2,0);
data2 = csvread("NewFile16.csv",2,0);
data3 = csvread("NewFile17.csv",2,0);

increment1 = 5e-5
increment2 = 5e-5
increment3 = 2e-5

Ts1 = (0:increment1/10:10*75*increment1);
T1 = (0:increment1*75:10*75*increment1)
Y1 = data1(420:75:1200, 2)
Y1 = data1(420:75:1200, 2) + abs(Y1(1));

Ts2 = (0:increment2/10:10*75*increment2);
T2 = (0:increment2*75:10*75*increment2)
Y2 = data2(430:75:1200, 2)
Y2 = data2(430:75:1200, 2) + abs(Y2(1));

Ts3 = (0:increment3/10:10*100*increment3);
T3 = (0:increment3*100:10*100*increment3)
Y3 = data3(190:100:1200, 2);
Y3 = data3(190:100:1200, 2) + abs(Y3(1))

Xo1 = [-2760 3.326e6 1 1236 3.392e6];
X1 = fminsearch('Skok_B_f_1', Xo1);
Ls1 = [X1(1) X1(2)];
Ms1 = [X1(3) X1(4) X1(5)];

Xo2 = [-2760 3.326e6 1 1236 3.392e6];
X2 = fminsearch('Skok_B_f_2', Xo2);
Ls2 = [X2(1) X2(2)];
Ms2 = [X2(3) X2(4) X2(5)];

Xo3 = [-2760 3.326e6 1 1236 3.392e6];
X3 = fminsearch('Skok_B_f_3', Xo3);
Ls3 = [X3(1) X3(2)];
Ms3 = [X3(3) X3(4) X3(5)];

Ys1 = step(Ls1, Ms1, Ts1);
Ys2 = step(Ls2, Ms2, Ts2);
Ys3 = step(Ls3, Ms3, Ts3);

plot(Ts1, Ys1, Ts2, Ys2, Ts3, Ys3, T1, Y1, 'x', T2, Y2, 'x', T3, Y3, 'x')
grid on;

Tf1 = tf([Ls1],[Ms1])
Tf2 = tf([Ls2], [Ms2])
Tf3 = tf([Ls3], [Ms3])

k=[0.2  0.1 0.3];
k = 0.47 +k/2

kc =[X1(2) X2(2) X3(2)]
kw = kc./k

Tx = [X1(1)/kc(1) X2(1)/kc(2) X3(1)/kc(3)]
kp = [X1(5)/kc(1) X2(5)/kc(2) X3(5)/kc(3)]
Ti = [X1(4) - (Tx(1)*kp(1)*kc(1)) X2(4)-(Tx(2)*kp(2)*kc(2)) X3(4)-(Tx(3)*kp(3)*kc(3))]
Ty = [X1(3)/Ti(1) X2(3)/Ti(2) X3(3)/Ti(3)]

kwm = mean(kw);
kpm = mean(kp);
Txm = mean(Tx);
Tim = mean(Ti);
Tym = mean(Ty);

srednia(1) = tf([kc(1)*Tx(1) kc(1)],[Ti(1)*Ty(1) Ti(1) 0 ]);
srednia(2) = tf([kc(2)*Tx(2) kc(2)],[Ti(2)*Ty(2) Ti(2) 0 ]);
srednia(3) = tf([kc(3)*Tx(3) kc(3)],[Ti(3)*Ty(3) Ti(3) 0 ]);

srednia(1) = minreal(feedback(srednia(1),kp(1)));
srednia(2) = minreal(feedback(srednia(2),kp(2)));
srednia(3) = minreal(feedback(srednia(3),kp(3)));

sredniaf(1) = feedback(tf(k(1)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);
sredniaf(2) = feedback(tf(k(2)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);
sredniaf(3) = feedback(tf(k(3)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);

figure(6)
step(srednia(1), 'o', srednia(2), 'square', srednia(3), 'diamond', Tf1, Tf2, Tf3)
legend()

