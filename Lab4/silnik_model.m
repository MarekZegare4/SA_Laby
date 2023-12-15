dane = csvread("scope_0.csv",3,0);
t = dane(:,1);
zas = dane(:,2);
tacho = dane(:,3);


clrs = ["#D95319" "#EDB120" "#7E2F8E" "#77AC30" "#A2142F"];

global tm tachom 

figure(1)
plot(t+abs(t(1)),zas,'Color', clrs(1))
hold on
plot(t+abs(t(1)),tacho, 'Color', clrs(4))
title("Odpowiedż tachoprądnicy na pobudzenie sygnałem prostokątnym")
xlabel("Czas [s]")
ylabel("Napięcie [V]")
grid on
legend("Napięcie zasilania", "Napięcie na wyjściu tachoprądnicy")

int = 2;

tm= t(39:int:410);
tachom = tacho(39:int:410);




tm = tm + abs(tm(1));
tachom = tachom +abs(tachom(1));


tachom = (tachom +0.2037)/0.0786;

Xp = [1 1];
Xf = fminsearch("min1rzad",Xp);



opt = stepDataOptions("StepAmplitude",4.08);
Y = step(tf(Xf(1),[Xf(2) 1]), tm, opt);

figure(2)
plot(tm,Y,'Color',clrs(2))
hold on
plot(tm, tachom, 'x', 'Color', clrs(3))
title("Odpowiedź skokowa przybliżonego modelu")
ylabel("Obroty na minutę")
xlabel("Czas [s]")
grid on

