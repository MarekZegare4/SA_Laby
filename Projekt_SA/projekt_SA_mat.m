tab = csvread("Wyjscie_symulacji.csv",1,0);

h =tab(1,1);
czasKoniec = tab(1,2);
Tp = tab(1,3);
Ti = tab(2,1);
Kp = tab(2,2);
a1 = tab(2,3);
a2 = tab(3,1);
To = tab(3,2);

clr = ["#D95319" "#EDB120" "#7E2F8E" "#77AC30" "#4DBEEE" "#A2142F"];

Y = tab(4:end,1);
e = tab(4:end,2);
czas = tab(4:end,3);
R = tab(4:end,4);


obiekt = tf(Kp/Ti,[a2*Tp (a2 +a1*Tp) (a1 +Tp)  1 0],'inputdelay',5*To);
czujnik = tf(1,[0.05*Tp 1],'inputdelay',To);
ster = 0.03 ;

    
full = feedback(obiekt*ster,czujnik);

% fullpade = pade(full,15);
% stepinfo(fullpade)
% figure(2)
% step(fullpade)


int =1500;

figure(1)
hold on
plot(czas,Y)
title("Odpowiedź skokowa układu ze sterownikiem PID")
xlabel("Czas [s]")
ylabel("Sygnał")
grid on



figure(2)
plot(czas,e, 'Color', clr(2))
title("Wykres uchybu od czasu, symulacja w C++")
xlabel("Czas [s]")
ylabel("e(t)")
legend("Pobudzenie r(t) =t")
grid on




