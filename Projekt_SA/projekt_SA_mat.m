tab = csvread("Wyjscie_symulacji.csv",1,0);

h =tab(1,1);
czasKoniec = tab(1,2);
Tp = tab(1,3);
Ti = tab(2,1);
Kp = tab(2,2);
a1 = tab(2,3);
a2 = tab(3,1);
To = tab(3,2);

Y = tab(4:end,1);
U = tab(4:end,2);
czas = tab(4:end,3);

% Kp = 2.483;
% Tp = 0.002249;
% a2 = 2.6991e-7;
% a1 = 6.9312e-4;
% Ti = 0.73e-3;


obiekt = tf(Kp/Ti,[a2*Tp (a2 +a1*Tp) (a1 +Tp)  1 0]);
czujnik = tf(1,[0.05*Tp 1]);
ster = 1;

full = feedback(obiekt*ster,czujnik);



figure(1)
plot(czas,Y,'Color','Red') %'Marker','x','LineStyle','none','
title("Symulacja")
hold on

% figure(2)
%step(full)


%legend("Symulacja w c++ (podzielona przez 2h z jakiegoś powodu)", "impulse()")

syms Ti Kp Tp a2 a1 Ti To s

expand(1/(Ti*s)*(Kp/(1 +Tp*s))*(1/(1 +s*a1 + s*a2*s)))

