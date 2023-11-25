% Obiekt nieminimalnofazowy- minimalizacja Bode

global Y1 Y2 Y3 F1 F2 F3 P1 P2 P3 Z1 Z2 Z3;

% Poniżej wpisz swoje dane
% Vout = [1.07 1.3 2.13 2.79 1.29 0.51; 1.06 1.27 1.92 2.09 1.09 0.452; 1.07 1.32 2.27 3.7 1.48 0.54];
% phas = [-3.6 -41.4 -86.2 -152 -217.8 -263.8; -5.4 -45 -96.48 -160.7 -212.2 -246.6; -5.4 -37.8 -76.32 -147.7 -220.4 -260.2];
% freq = [10 100 200 300 500 1000; 10 100 200 300 500 1000; 10 100 200 300 500 1000];
Vout = [1.05 1.51 3.66 4.8 1.5 0.592; 1.05 1.51 3.8 6.32 1.61 0.62; 1.05 1.51 3.84 8.48 1.72 0.648];
phas = [-1.8 -45 -90.72 -189.8 -239.4 257.4; -1.8 -41.4 -82.08 -191.9 -243 -257.4; -1.8 -41.4 -73.44 -195 -246.6 -257.4];
freq = [10 100 200 300 500 1000; 10 100 200 300 500 1000; 10 100 200 300 500 1000];
freq = 2*pi*freq;
% zamiana amplitudy i fazy na liczby zespolone
zesp1 = Vout(1,:) .* exp(1i*deg2rad(phas(1,:))); 
zesp2 = Vout(2,:) .* exp(1i*deg2rad(phas(2,:))); 
zesp3 = Vout(3,:) .* exp(1i*deg2rad(phas(3,:))); 
Z1 = zesp1;
Z2 = zesp2;
Z3 = zesp3;

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((10:0.05:1000));

F1 = freq(1,:);
Y1 = Vout(1,:);
P1 = phas(1,:);

F2 = freq(2,:);
Y2 = Vout(2,:);
P2 = phas(2,:);

F3 = freq(3,:);
Y3 = Vout(3,:);
P3 = phas(3,:);

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo1 = [-2760 3.326e6 1 1236 3.392e6];
Xo2 = [-2760 3.326e6 1 1236 3.392e6];
Xo3 = [-2760 3.326e6 1 1236 3.392e6];

Ls = [-5.672 4101]
Ms = conv([1 4311],[7.3e-4 0])

k = [0 0.04 0.08];
k = 0.47 +k/2

X1 = fminsearch('B_bode_f_A', Xo1);
Ls1 = [X1(1) X1(2)];
Ms1 = [X1(3) X1(4) X1(5)];
Tf1 = feedback(tf([Ls]*k(1),[Ms]), 1);

X2 = fminsearch('B_bode_f_B', Xo2);
Ls2 = [X2(1) X2(2)];
Ms2 = [X2(3) X2(4) X2(5)];
Tf2 = feedback(tf([Ls]*k(2),[Ms]), 1);

X3 = fminsearch('B_bode_f_C', Xo3);
Ls3 = [X3(1) X3(2)];
Ms3 = [X3(3) X3(4) X3(5)];
Tf3 = feedback(tf([Ls]*k(3),[Ms]), 1);

[mag1, phase1, wout1] = bode(Tf1, Fs);
[mag2, phase2, wout2] = bode(Tf2, Fs);
[mag3, phase3, wout3] = bode(Tf3, Fs);


figure(1)
tiledlayout(2,1);
nexttile;
semilogx(Fs, mag2db(mag1(:)), Fs, mag2db(mag2(:)), Fs, mag2db(mag3(:)), F1, mag2db(Y1), 'o', F2, mag2db(Y2), 'o', F3, mag2db(Y3), 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Amplituda [dB]")
legend()
title("Charakterystyki Bodego układu B")

nexttile;
semilogx(Fs, phase1(:) - 360, Fs, phase2(:) - 360, Fs, phase3(:) - 360, F1, P1, 'o', F2, P2, 'o', F3, P3, 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
%fontsize(15,"pixels")
legend()


tf(Tf1)
tf(Tf2)
tf(Tf3)

% 
% k=[0.2  0.1 0.3];
% k = 0.47 +k/2
% 
% kc =[X1(2) X2(2) X3(2)]
% kw = kc./k
% 
% Tx = [X1(1)/kc(1) X2(1)/kc(2) X3(1)/kc(3)]
% kp = [X1(5)/kc(1) X2(5)/kc(2) X3(5)/kc(3)]
% Ti = [X1(4) - (Tx(1)*kp(1)*kc(1)) X2(4)-(Tx(2)*kp(2)*kc(2)) X3(4)-(Tx(3)*kp(3)*kc(3))]
% Ty = [X1(3)/Ti(1) X2(3)/Ti(2) X3(3)/Ti(3)]
% 
% 
% 
% kwm = mean(kw);
% kpm = mean(kp);
% Txm = mean(Tx);
% Tim = mean(Ti);
% Tym = mean(Ty);
% 
% 
% srednia(1) = tf([kc(1)*Tx(1) kc(1)],[Ti(1)*Ty(1) Ti(1) 0 ]);
% srednia(2) = tf([kc(2)*Tx(2) kc(2)],[Ti(2)*Ty(2) Ti(2) 0 ]);
% srednia(3) = tf([kc(3)*Tx(3) kc(3)],[Ti(3)*Ty(3) Ti(3) 0 ]);
% 
% srednia(1) = minreal(feedback(srednia(1),kp(1)));
% srednia(2) = minreal(feedback(srednia(2),kp(2)));
% srednia(3) = minreal(feedback(srednia(3),kp(3)));
% 
% sredniaf(1) = feedback(tf(k(1)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);
% sredniaf(2) = feedback(tf(k(2)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);
% sredniaf(3) = feedback(tf(k(3)*[kwm*Txm kwm],[Tim*Tym Tim 0 ]),kpm);
% 
% figure(6)
% opts = bodeoptions('cstprefs');
% %opts.PhaseWrapping='on';
% 
% bodeplot(srednia(1), srednia(2), srednia(3), Tf1, Tf2, Tf3,opts)
% 
% figure(7)
% bode(sredniaf(1), sredniaf(2), sredniaf(3), Tf1, Tf2, Tf3)
% 
% 
