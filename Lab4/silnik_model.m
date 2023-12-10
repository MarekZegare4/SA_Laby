dane = csvread("scope_0.csv",3,0);
t = dane(:,1);
zas = dane(:,2);
tacho = dane(:,3);

global tm tachom

figure(1)
plot(t,zas, t,tacho)
title("Odczyt csv")

int = 10;

tm= t(39:7:410);
tachom = tacho(39:7:410);

tm = tm + abs(tm(1));
tachom = tachom +abs(tachom(1));


Xp = [1 1];
Xf = fminsearch("min1rzad",Xp);

Y = step(Xf(1), [Xf(2) 1], tm);

figure(2)
plot(tm,Y, tm, tachom, 'x')
title("Model")

