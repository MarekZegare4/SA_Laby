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
U = tab(4:end,2);
czas = tab(4:end,3);


obiekt = tf(Kp/Ti,[a2*Tp (a2 +a1*Tp) (a1 +Tp)  1 0],'inputdelay',5*To);
czujnik = tf(1,[0.05*Tp 1],'inputdelay',To);
ster = 0.04;

full = feedback(obiekt*ster,czujnik);

int =1500;


figure(1)
plot(czas(1:int:end),Y(1:int:end),'Color',clr(4),'Marker','o','LineStyle','none','MarkerSize',10) 
title("Symulacja w C++")
xlabel("Czas [s]")

hold on

opt = timeoptions("cstprefs");
opt.XLabel.String = 'Czas';
opt.YLabel.String = "y(t)";
opt.Title.String = "Odpowiedź skokowa modelu referencyjnego";

% figure(2)
step(full,opt)
grid on


legend("Symulacja w C++ ", "step()")

syms Ti Kp Tp a2 a1 Ti To s

expand(1/(Ti*s)*(Kp/(1 +Tp*s))*(1/(1 +s*a1 + s*a2*s)))

