% Obiekt pierwszego rzędu - minimalizacja Bode

global DANE ZFULL uklad k;

% Poniżej wpisz swoje dane
Vout = [0.966 1.06 0.934 0.447 0.224 0.024; 1.04 1.07 1.47 0.647 0.284 0.03; 1.04 1.11 2.36 0.97 0.334 0.0388];
phas = [-3.6 -57 -139.6 -190 -214 -246.6; -3.6 -27 -133 -196 -215.2 -242; -2.16 -19.8 -111.7 -194.4 -217.7 -246.6];
freq = [10 150 300 400 500 1000; 10 100 300 400 500 1000; 10 100 300 400 500 1000];
freq = 2*pi*freq;
% zamiana amplitudy i fazy na liczby zespolone
zesp1 = Vout(1,:) .* exp(1i*deg2rad(phas(1,:))); 
zesp2 = Vout(2,:) .* exp(1i*deg2rad(phas(2,:))); 
zesp3 = Vout(3,:) .* exp(1i*deg2rad(phas(3,:))); 
Z1 = zesp1;
Z2 = zesp2;
Z3 = zesp3;

ZFULL = [Z1;Z2;Z3];

% W Fs ustaw zakres częstotliwości taki sam, jak w twoich pomiarach
Fs = 2*pi*((10:0.05:1000));


%0.47 +(n/2)

a1 = 2.392e-7;
a2 = 6.403e-4;
Ti = 1.3e-3;
k=[0.35 0.7 1.05];
k = 0.47 +k/2;


%Ti a1 a2 k_2] -> k_2 to domniemane wzmocnienie członu oscylacyjnego





F1 = freq(1,:);
Y1 = Vout(1,:);
P1 = phas(1,:);

F2 = freq(2,:);
Y2 = Vout(2,:);
P2 = phas(2,:);

F3 = freq(3,:);
Y3 = Vout(3,:);
P3 = phas(3,:);

DANE = [F1;Y1;P1;F2;Y2;P2;F3;Y3;P3];

% Wybierz wektor Xo, sprawdź kilka razy - możesz trafić na minimum lokalne
Xo1 = [1 1.8342e-10 1e-6 1e-3 1];
Xo2 = [1 1.8342e-10 1e-6 1e-3 1];
Xo3 = [1 1.8342e-10 1e-6 1e-3 1];

X1 = fminsearch('A_bode_f_A', Xo1);
Ls1 = [X1(1)];
Ms1 = [X1(2) X1(3) X1(4) X1(5)];
Tf1 = tf([Ls1],[Ms1]);

X2 = fminsearch('A_bode_f_B', Xo2);
Ls2 = [X2(1)];
Ms2 = [X2(2) X2(3) X2(4) X2(5)];
Tf2 = tf([Ls2],[Ms2]);

X3 = fminsearch('A_bode_f_C', Xo3);
Ls3 = [X3(1)];
Ms3 = [X3(2) X3(3) X3(4) X3(5)];
Tf3 = tf([Ls3],[Ms3]);

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
title("Charakterystyki Bodego układu A")

nexttile;
semilogx(Fs, phase1(:), Fs, phase2(:), Fs, phase3(:), F1, P1, 'o', F2, P2, 'o', F3, P3, 'o');
grid on;
xlabel("Pulsacja [rad/s]")
ylabel("Faza [°]")
%fontsize(15,"pixels")
legend()


tf(Tf1)
tf(Tf2)
tf(Tf3)

% figure(3)
% %[k_2 Ti]
% 
% uklad =1;
% 
% Xn1 = [1 Ti];%
% 
% Xn = fminsearch('bode_min',Xn1)
% Xn = [Xn, a1 a2];
% Xn(2) = Xn(2);
% Tf = tf(Xn(1)*k(1),[Xn(2)*a1 Xn(2)*a2 Xn(2) 0]);
% Tf = feedback(Tf,1)
% bode(Tf)


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
bode(srednia(1), srednia(2), srednia(3), Tf1, Tf2, Tf3)

figure(5)

opts = bodeoptions('cstprefs');
%opts.PhaseWrapping='on';
opts.PhaseMatching = 'on';
bodeplot(kloc1, opts)


