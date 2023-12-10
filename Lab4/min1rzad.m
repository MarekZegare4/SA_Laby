function wynik = min1rzad(X)

global tm tachom


L = [X(1)]; %kp
M = [X(2) 1]; %X(2) = Ts

sys = tf(L,M);

Ys = step(sys,tm);
wynik = sum((tachom-Ys).^2);

end